"""T89 entry-state authentication controls; public checks need no private saves.

The capture module's entry gate must refuse any state that is not the
T81/T82-authenticated post-week save before any emulation begins. These tests
synthesize a structurally-valid image at the static offsets and pin the pinned
identity against the committed T82 record — the real digest gate only opens
for the owner-local f3aa2e4f save at capture time.
"""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import pytest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location(
    'sevilla_match_tested', ROOT / 'runtime/emul/sevilla_match.py')
p = importlib.util.module_from_spec(spec)
spec.loader.exec_module(p)

SIZE = 194426
sha = lambda data: hashlib.sha256(data).hexdigest()
encoded = lambda value: json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def t82_record():
    return json.loads((ROOT / 'records/T82/next-fixture-r0001.json').read_text())


def synthesized_entry(club=130):
    """A structurally-valid post-week image: played friendly marked, Sevilla
    following, week byte 1, reciprocal rows intact."""
    data = bytearray(SIZE)
    at = lambda other: p.block_offsets()['[DS:D7CA]'][0] + other * 174 + 3 - 177
    week_at = p.block_offsets()['[DS:D7D2]'][0]
    # played friendly, competition 1 opponent 17, played marker (bit 64)
    data[at(club) + 0], data[at(club) + 1], data[at(club) + 2] = 1, 17, 64
    # reciprocal row
    data[at(17) + 0], data[at(17) + 1], data[at(17) + 2] = 1, club, 64
    # following fixture: Sevilla, Friendly #2, no played marker
    data[at(club) + 3], data[at(club) + 4], data[at(club) + 5] = 1, 176, 0
    data[at(176) + 3], data[at(176) + 4], data[at(176) + 5] = 1, club, 0
    data[week_at] = 1
    return bytes(data)


def test_pinned_identity_matches_the_committed_t82_record():
    decoded = t82_record()['decoded']
    assert decoded['club'] == p.MANAGED_CLUB == 130
    assert p.ENTRY_SHA == t82_record()['sources']['post']['sha256']
    assert decoded['week_byte_post'] == 1
    following = decoded['fixtures_post'][1]
    assert following == dict(p.WITNESSED_FOLLOWING)
    assert (following['competition'], following['opponent'], following['flags']) == (1, 176, 0)


def test_structurally_valid_entry_is_accepted():
    entry = p.entry_structure(synthesized_entry())
    assert entry['week_byte'] == 1
    assert entry['played'] == dict(week=0, competition=1, opponent=17, flags=64)
    assert entry['following'] == dict(p.WITNESSED_FOLLOWING)
    assert entry['reciprocal_played'] == (1, p.MANAGED_CLUB)
    assert entry['reciprocal_following'] == (1, p.MANAGED_CLUB)

@pytest.mark.parametrize('damage,marker', [
    ('played', 'played friendly triple'),
    ('reciprocal', 'reciprocal'),
    ('following', 'following fixture'),
    ('reciprocal_following', 'reciprocal'),
    ('played_marker', 'played marker'),
    ('following_marker', 'following fixture'),
    ('week', 'week counter'),
])
def test_tampered_entry_structure_refuses(damage, marker):
    data = bytearray(synthesized_entry())
    at = lambda other: p.block_offsets()['[DS:D7CA]'][0] + other * 174 + 3 - 177
    week_at = p.block_offsets()['[DS:D7D2]'][0]
    if damage == 'played':
        data[at(130) + 1] = 18
    if damage == 'reciprocal':
        data[at(17) + 1] = 131
    if damage == 'following':
        data[at(130) + 4] = 175
    if damage == 'reciprocal_following':
        data[at(176) + 4] = 131
    if damage == 'played_marker':
        data[at(130) + 2] = 0
    if damage == 'following_marker':
        data[at(130) + 5] = 64
    if damage == 'week':
        data[week_at] = 2
    with pytest.raises(ValueError, match=marker):
        p.entry_structure(bytes(data))


def test_authenticate_entry_refuses_any_wrong_digest_before_decoding(tmp_path, monkeypatch):
    # Even a structurally-valid image is refused: the digest gate opens only
    # for the pinned owner-local save. Nothing is emulated or deserialized.
    import hashlib
    good = synthesized_entry()
    assert hashlib.sha256(good).hexdigest() != p.ENTRY_SHA
    fake = tmp_path / 'SAVE1.1-0'
    fake.write_bytes(good)
    loaded = []
    monkeypatch.setattr(p, 'entry_structure', lambda *_: loaded.append(True))
    with pytest.raises(ValueError, match='digest'):
        p.authenticate_entry(fake)
    assert loaded == []
    with pytest.raises(ValueError, match='digest'):
        p.authenticate_entry(tmp_path / 'missing')
    assert loaded == []


def test_entry_record_binds_the_authenticated_identity(tmp_path, monkeypatch):
    import hashlib
    good = synthesized_entry()
    fake = tmp_path / 'SAVE1.1-0'
    fake.write_bytes(good)
    monkeypatch.setattr(p, 'ENTRY_SHA', hashlib.sha256(good).hexdigest())
    record = p.entry_record(fake)
    assert record['schema'] == 'sevilla-entry/1'
    assert record['source']['sha256'] == hashlib.sha256(good).hexdigest()
    assert record['source']['size'] == SIZE
    assert record['decoded']['following'] == dict(p.WITNESSED_FOLLOWING)
    assert record['decoded']['week_byte'] == 1


# --- stage 2: boot context protocol ---


def test_week_one_anchors_come_from_the_committed_records():
    a = p.week_one_anchors()
    assert a['seed_word'] == 10649 and a['cash'] == 421491 and a['week_byte'] == 1
    assert a['roster'][:6] == [2581, 2582, 2583, 2584, 2585, 2586] and a['roster'][18:] == [0, 0]
    assert a['following'] == dict(p.WITNESSED_FOLLOWING)
    assert a['slot_after'] == dict(week=2, competition=1, opponent=28, flags=0)
    assert 'Sevilla' in a['menu_markers'] and 'Friendly #2' in a['menu_markers']


def preparation_projected():
    t65 = json.loads((ROOT / 'runs/T65/seed-r0001.json').read_text())['initial']
    projected = json.loads(json.dumps(t65))
    anchors = p.week_one_anchors()
    projected['week_index'] = p.PREPARATION_LIVE['week_index']
    projected['cash'] = anchors['cash']
    projected['club']['first_team'] = list(anchors['roster'])
    projected['next_fixture'].update(slot=3, opponent=28, opponent_name='Celtic',
                                     competition_code=1, flags=0, venue_code=0, opponent_flags=1)
    return projected


def test_preparation_context_accepts_the_pre_advanced_projection():
    fixture = p.check_preparation_context(preparation_projected(), p.week_one_anchors())
    assert (fixture['competition_code'], fixture['opponent']) == (1, 28)


@pytest.mark.parametrize('field,value', [
    ('week_index', 1), ('week_index', 0), ('cash', 452000),
    ('manager', {'slot': 1, 'name_id': 130, 'name': 'Keegan'}),
])
def test_tampered_preparation_context_refuses(field, value):
    projected = preparation_projected()
    if field == 'manager':
        projected['manager'] = value
    else:
        projected[field] = value
    with pytest.raises(ValueError):
        p.check_preparation_context(projected, p.week_one_anchors())


def test_tampered_roster_live_fixture_and_season_refuse():
    for mutate in (lambda c: c['club']['first_team'].__setitem__(1, 2592),
                   lambda c: c['next_fixture'].update(opponent=17),
                   lambda c: c['next_fixture'].update(opponent=176),
                   lambda c: c['next_fixture'].update(competition_code=0),
                   lambda c: c['season'].update(start_year=1995)):
        projected = preparation_projected()
        mutate(projected)
        with pytest.raises(ValueError):
            p.check_preparation_context(projected, p.week_one_anchors())


def test_preparation_state_digest_refuses_before_boot(tmp_path):
    import hashlib
    fake = tmp_path / 'sevilla-preparation.sav'
    fake.write_bytes(b'not a savestate')
    assert hashlib.sha256(fake.read_bytes()).hexdigest() != p.PREPARATION_STATE_SHA
    with pytest.raises(ValueError, match='digest'):
        p.authenticate_preparation_state(fake)
    with pytest.raises(ValueError, match='digest'):
        p.authenticate_preparation_state(tmp_path / 'missing.sav')


# --- stage 2: capture-directory contract (check_capture) ---


def synth_state(seed):
    return dict(seed=seed, elapsed=0, remaining=5400, quick=0, scores=[0, 0], phase=1,
                active=1, hold=0, stoppage=0, actor=0, secondary=0,
                ball={**{f'word{k}': 0 for k in (0, 2, 4, 7, 9, 11)},
                      **{f'byte{k}': 0 for k in (6, 13, 14)}},
                scenes=[dict(index=i, **{f'word{k}': 0 for k in (0, 2, 4, 8, 10, 14, 16, 20)},
                             **{f'byte{k}': 0 for k in (6, 7, 12, 13, 18, 19, 22, 23, 24)})
                        for i in range(1, 23)])


def synth_capture(tmp_path):
    """A minimal valid capture directory: one chunk, one tick, one draw."""
    import subprocess
    head = subprocess.check_output(['git', '-C', str(ROOT), 'rev-parse', 'HEAD']).decode().strip()
    names = subprocess.check_output(
        ['git', '-C', str(ROOT), 'ls-tree', '-r', '--name-only', head]).decode().splitlines()
    census = {n: sha(subprocess.check_output(['git', '-C', str(ROOT), 'show', f'{head}:{n}']))
              for n in p.watcher_census() if n in names}
    boot = json.loads((ROOT / 'records/T89/boot-r0001.json').read_bytes())
    boot_path = ROOT / 'records/T89/boot-r0001.json'
    start = dict(schema='sevilla-watched-start/1', producer=head, producer_files=census,
                 preparation_state=dict(path='.cache/T89/states/x.sav', sha256=p.PREPARATION_STATE_SHA),
                 boot=dict(record='records/T89/boot-r0001.json',
                           record_sha256=sha(boot_path.read_bytes()),
                           projection_sha256=boot['projection_sha256']),
                 release=p.release_96(), watch_setting=1, live_context=dict(p.PREPARATION_LIVE),
                 interventions=[])
    payload = dict(index=0, draw_start=0, draw_end=1, tick_start=1, tick_end=1,
                   action_start=0, action_end=0,
                   draws=[dict(kind='draw', i=0, n=1, seed_before=100, seed_after=200,
                               value=42, callers=[])],
                   ticks=[dict(tick=1, draw_start=0, draw_end=1,
                               before=synth_state(100), after=synth_state(200))],
                   actions=[])
    chunk = dict(schema='sevilla-watched-chunk/1', producer=head,
                 payload_sha256=sha(encoded(payload)), payload=payload)
    result = dict(chunk_payloads=[sha(encoded(chunk))], final=synth_state(200), ticks=1,
                  draws=1, actions=0, first_entry=synth_state(100), entry_draws=0,
                  match_return=dict(site='0AB9:EBE2', draw=1, seed=200),
                  caller=dict(entry={}, returned={}, census=dict(reads=1, writes=1, initial=1)),
                  condition=dict(calls=[], contexts=[]),
                  seconds=1.0, smoke=True)
    finish = dict(schema='sevilla-watched-finish/1', status='completed', error=None,
                  producer=head, result=result, keys_delivered=[['Return', '24BC:0C58']],
                  unsupported=[])
    d = tmp_path / 'capture'
    d.mkdir(parents=True)
    (d / 'start.json').write_bytes(encoded(start))
    (d / 'chunk-000000.json').write_bytes(encoded(chunk))
    (d / 'finish.json').write_bytes(encoded(finish))
    (d / 'index.json').write_bytes(encoded(dict(
        start_sha256=sha(encoded(start)),
        chunks=[dict(path='chunk-000000.json', sha256=sha(encoded(chunk)))],
        finish_sha256=sha(encoded(finish)))))
    return d


def test_check_capture_accepts_a_valid_directory(tmp_path, monkeypatch):
    d = synth_capture(tmp_path)
    monkeypatch.chdir(ROOT)
    p.check_capture(d)


def test_check_capture_refuses_tampering(tmp_path, monkeypatch):
    import subprocess
    monkeypatch.chdir(ROOT)
    base = synth_capture(tmp_path)
    p.check_capture(base)  # sanity: the synth directory is valid

    def rewrite(d, name, mutate):
        value = json.loads((d / name).read_text())
        mutate(value)
        (d / name).write_bytes(encoded(value))

    # chunk payload tampered but chunk-file digest untouched -> payload digest pin
    d = synth_capture(tmp_path / 'a')
    rewrite(d, 'chunk-000000.json', lambda c: c['payload']['draws'][0].update(value=43))
    with pytest.raises(ValueError):
        p.check_capture(d)
    # index chunk digest tampered
    d = synth_capture(tmp_path / 'b')
    rewrite(d, 'index.json', lambda i: i['chunks'][0].update(sha256='0' * 64))
    with pytest.raises(ValueError):
        p.check_capture(d)
    # result identities disagree with the chunk index
    d = synth_capture(tmp_path / 'c')
    rewrite(d, 'finish.json', lambda f: f['result'].update(ticks=2))
    with pytest.raises(ValueError):
        p.check_capture(d)
    # boot anchor diverges from the committed boot record
    d = synth_capture(tmp_path / 'd')
    rewrite(d, 'start.json', lambda s: s['boot'].update(projection_sha256='0' * 64))
    with pytest.raises(ValueError):
        p.check_capture(d)
