// Ghidra pre-analysis script for tools/static/decompile.sh (T02). Not run by hand.
// Ported from goal2-archaeology tools/static/ghidra/GoalSetup.java at 774473eb; changed here: the
// data and stack segments of 1-0.EXE, and step 2 places the blocks without a parking area (1-0.EXE
// has more segments than fit below goal2's parking segment C000).
//
// Arguments: <routines.tsv> <segmap.tsv to write>
//
// Ghidra's MZ loader (12.1.4) imports the unpacked 1-0.EXE at base segment 0x1000: every listing
// segment S becomes the block S+0x1000, relocations applied. This script then places the program so
// that Ghidra decodes it correctly, and writes the mapping it used:
//
//  1. It undoes the loader's adjustSegmentStarts heuristic, which moves a block's first bytes into
//     the previous block when it sees a 0xCB (RETF) byte among its first 16 bytes. The bytes go back
//     to the start of their own segment (the run's summary says which segments, if any).
//  2. It moves listing segment number k (in ascending order: 0000, 0006, 01EF, ... , 2864) to the
//     Ghidra segment k*0x1000, so that each segment starts on a 64K linear boundary. Reason: the x86
//     SLEIGH computes a 16-bit relative target as ((inst_next >> 16) << 16) | ((inst_next + rel16) &
//     0xFFFF) on the LINEAR address (ia.sinc, rel16), which is the real-mode near target only when the
//     segment's linear base is a multiple of 0x10000. At the listing's own segment numbers, near calls
//     and jumps that cross a linear 64K line, or whose 16-bit displacement wraps, would go to wrong
//     addresses. The blocks are moved highest target first; a block whose target overlaps its own
//     current place goes through a free place above every block first.
//  3. It rewrites every relocated segment word with the new segment of the same paragraph (value v in
//     listing segment S, at paragraph distance v-S from it, becomes map(S) + (v-S)).
//  4. It sets CS per block, DS to the mapped data segment 2864, and SS at the entry point.
//  5. It creates one function per routine of routines.tsv, named f_SSSS_OOOO after its listing
//     address, near (__stdcall16near) or far (__stdcall16far) by whether its body returns with RETF.
// Ghidra's auto-analysis runs after this script.

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.TreeMap;

import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.AddressSet;
import ghidra.program.model.address.SegmentedAddress;
import ghidra.program.model.address.SegmentedAddressSpace;
import ghidra.program.model.lang.Register;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.listing.ProgramContext;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.mem.MemoryBlock;
import ghidra.program.model.reloc.Relocation;
import ghidra.program.model.symbol.SourceType;

public class OnilSetup extends GhidraScript {
	static final int LOADER_BASE = 0x1000;   // MzLoader.INITIAL_SEGMENT_VAL in Ghidra 12.1.4
	static final int DATA_SEGMENT = 0x2864;  // static/1-0-exe/README.md
	static final int STACK_SEGMENT = 0x381C; // static/1-0-exe/README.md
	static final long TOP = 0x10FFF0L;       // linear end of Ghidra's real-mode address space

	SegmentedAddressSpace space;
	TreeMap<Integer, Integer> segMap = new TreeMap<>(); // listing segment -> Ghidra segment

	@Override
	public void run() throws Exception {
		String[] args = getScriptArgs();
		if (args.length != 2) {
			throw new IllegalArgumentException("usage: OnilSetup.java <routines.tsv> <segmap.tsv>");
		}
		List<int[]> routines = readRoutines(args[0]);
		space = (SegmentedAddressSpace) currentProgram.getAddressFactory().getDefaultAddressSpace();
		Memory memory = currentProgram.getMemory();

		// 1. every initialized block starts at offset 0 of its segment
		for (MemoryBlock block : memory.getBlocks()) {
			if (!(block.getStart() instanceof SegmentedAddress) || !block.isInitialized()) {
				continue;
			}
			SegmentedAddress start = (SegmentedAddress) block.getStart();
			int lead = start.getSegmentOffset();
			if (lead == 0) {
				continue;
			}
			if (lead > 16) {
				throw new IllegalStateException("block " + block.getName() + " starts at " + start);
			}
			Address leadStart = start.subtract(lead);
			MemoryBlock previous = memory.getBlock(leadStart);
			byte[] bytes = new byte[lead];
			memory.getBytes(leadStart, bytes);
			if (!leadStart.equals(previous.getStart())) {
				memory.split(previous, leadStart);
			}
			memory.removeBlock(memory.getBlock(leadStart), monitor);
			SegmentedAddress newStart = space.getAddress(start.getSegment(), 0);
			MemoryBlock leadBlock = memory.createInitializedBlock(block.getName() + "_lead",
				newStart, lead, (byte) 0, monitor, false);
			leadBlock.setPermissions(true, true, true);
			memory.setBytes(newStart, bytes);
			String name = block.getName();
			memory.join(leadBlock, block).setName(name);
			println("ONILSETUP moved " + lead + " bytes back to segment " +
				String.format("%04X", start.getSegment() - LOADER_BASE));
		}

		// 2. one 64K-aligned Ghidra segment per listing segment
		List<MemoryBlock> blocks = new ArrayList<>();
		for (MemoryBlock block : memory.getBlocks()) {
			if (block.getStart() instanceof SegmentedAddress) {
				blocks.add(block);
			}
		}
		for (MemoryBlock block : blocks) {
			SegmentedAddress s = (SegmentedAddress) block.getStart();
			if (s.getSegmentOffset() == 0) {
				segMap.put(s.getSegment() - LOADER_BASE, segMap.size() * 0x1000);
			}
		}
		if (!segMap.containsKey(DATA_SEGMENT) || segMap.size() > 0x10) {
			throw new IllegalStateException("unexpected segments " + segMap);
		}
		// highest target first, each block to its target once no other block is there (the loader's
		// segment 0000 sits where 0006 goes, so 0006 waits until 0000 has moved down); a block whose
		// target overlaps its own current place goes through a free place above every block first
		List<String> pending = new ArrayList<>();
		for (MemoryBlock block : blocks) {
			pending.add(block.getName());
		}
		if (new java.util.HashSet<>(pending).size() != pending.size()) {
			throw new IllegalStateException("block names are not unique: " + pending);
		}
		pending.sort(Comparator.comparingLong(
			(String n) -> toGhidra(listingLinear(memory.getBlock(n))).getOffset()).reversed());
		while (!pending.isEmpty()) {
			String moved = null;
			for (String name : pending) {
				MemoryBlock block = memory.getBlock(name);
				Address target = toGhidra(listingLinear(block));
				long size = block.getSize();
				boolean blocked = false;
				for (MemoryBlock other : memory.getBlocks()) {
					if (!other.getName().equals(name) && other.getStart() instanceof SegmentedAddress &&
						overlaps(other.getStart().getOffset(), other.getSize(), target.getOffset(), size)) {
						blocked = true;
						break;
					}
				}
				if (blocked) {
					continue;
				}
				if (overlaps(block.getStart().getOffset(), size, target.getOffset(), size)) {
					long free = 0;
					for (MemoryBlock other : memory.getBlocks()) {
						if (other.getStart() instanceof SegmentedAddress) {
							free = Math.max(free, other.getEnd().getOffset() + 1);
						}
					}
					free = (free + 15) & ~15L;
					if (free + size > TOP) {
						throw new IllegalStateException("no free place to move block " + name);
					}
					memory.moveBlock(block, space.getAddress(free), monitor);
					block = memory.getBlock(name);
				}
				memory.moveBlock(block, target, monitor);
				moved = name;
				break;
			}
			if (moved == null) {
				throw new IllegalStateException("blocks " + pending + " cannot reach their segments");
			}
			pending.remove(moved);
		}

		// 3. relocated segment words follow the map
		int relocs = 0;
		for (java.util.Iterator<Relocation> it =
			currentProgram.getRelocationTable().getRelocations(); it.hasNext();) {
			Relocation r = it.next();
			long[] v = r.getValues(); // {site segment, site offset, relocated value} (MzLoader)
			long siteLinear = v[0] * 16 + v[1];
			int original = (int) ((v[2] - LOADER_BASE) & 0xffff);
			Address site = toGhidra(siteLinear);
			memory.setShort(site, (short) mapSegment(original));
			relocs++;
		}

		// 4. registers
		ProgramContext context = currentProgram.getProgramContext();
		Register cs = context.getRegister("cs");
		Register ds = context.getRegister("ds");
		Register ss = context.getRegister("ss");
		for (MemoryBlock block : memory.getBlocks()) {
			if (!(block.getStart() instanceof SegmentedAddress)) {
				continue;
			}
			int seg = ((SegmentedAddress) block.getStart()).getSegment();
			context.setValue(cs, block.getStart(), block.getEnd(), BigInteger.valueOf(seg));
			context.setValue(ds, block.getStart(), block.getEnd(),
				BigInteger.valueOf(mapSegment(DATA_SEGMENT)));
		}
		Address entry = toGhidra(0);
		context.setValue(ss, entry, entry, BigInteger.valueOf(mapSegment(STACK_SEGMENT)));

		// the bytes each segment holds (loaded and uninitialized blocks), from offset 0
		TreeMap<Integer, Long> size = new TreeMap<>();
		for (MemoryBlock block : memory.getBlocks()) {
			if (block.getStart() instanceof SegmentedAddress s) {
				long end = block.getEnd().getOffset() - (s.getSegment() & 0xF000) * 16L + 1;
				size.merge(s.getSegment() & 0xF000, end, Math::max);
			}
		}
		try (PrintWriter w = new PrintWriter(args[1])) {
			w.println("listing_segment\tghidra_segment\tbytes");
			for (var e : segMap.entrySet()) {
				w.println(String.format("%04X\t%04X\t%d", e.getKey(), e.getValue(),
					size.get(e.getValue())));
			}
		}
		println("ONILSETUP segments " + segMap.size() + " relocations " + relocs);

		// 5. one function per routine
		AddressSet starts = new AddressSet();
		for (int[] r : routines) {
			starts.add(toGhidra(r[0] * 16L + r[1]));
		}
		new DisassembleCommand(starts, null, true).applyTo(currentProgram, monitor);
		int made = 0;
		for (int[] r : routines) {
			Address a = toGhidra(r[0] * 16L + r[1]);
			String name = String.format("f_%04X_%04X", r[0], r[1]);
			Function f = getFunctionAt(a);
			if (f == null) {
				f = createFunction(a, name);
			}
			if (f == null) {
				println("ONILSETUP no function at " + name);
				continue;
			}
			f.setName(name, SourceType.USER_DEFINED);
			f.setCallingConvention(isFar(f) ? "__stdcall16far" : "__stdcall16near");
			made++;
		}
		println("ONILSETUP routines " + routines.size() + " functions " + made);
	}

	/** A block's place in the listing image (SEGMENT*16+OFFSET), from where the loader put it. */
	static long listingLinear(MemoryBlock block) {
		return block.getStart().getOffset() - LOADER_BASE * 16L;
	}

	static boolean overlaps(long a, long aSize, long b, long bSize) {
		return a < b + bSize && b < a + aSize;
	}

	/** The Ghidra segment of the listing segment holding paragraph v, plus v's distance from it. */
	int mapSegment(int v) {
		Integer s = segMap.floorKey(v);
		if (s == null) {
			throw new IllegalStateException(String.format("segment %04X below the image", v));
		}
		return segMap.get(s) + (v - s);
	}

	/** A listing image offset (SEGMENT*16+OFFSET) as a Ghidra address. */
	SegmentedAddress toGhidra(long listingLinear) {
		int paragraph = (int) (listingLinear >> 4);
		int s = segMap.floorKey(paragraph);
		return space.getAddress(segMap.get(s), (int) (listingLinear - s * 16L));
	}

	/** A routine is far when any return instruction in its body is RETF (Turbo Pascal far routine). */
	boolean isFar(Function f) {
		for (Instruction i : currentProgram.getListing().getInstructions(f.getBody(), true)) {
			if (i.getMnemonicString().toUpperCase().startsWith("RETF")) {
				return true;
			}
		}
		return false;
	}

	static List<int[]> readRoutines(String path) throws Exception {
		List<int[]> out = new ArrayList<>();
		try (BufferedReader in = new BufferedReader(new FileReader(path))) {
			String line;
			while ((line = in.readLine()) != null) {
				if (line.startsWith(";") || line.startsWith("segment:") || line.isEmpty()) {
					continue;
				}
				String[] so = line.split("\t", 2)[0].split(":");
				out.add(new int[] { Integer.parseInt(so[0], 16), Integer.parseInt(so[1], 16) });
			}
		}
		return out;
	}
}
