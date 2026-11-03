# Watched player actions and numeric commentary

[confirmed: static at d9e20a4] The existing native DD02 backend is the quick
result path. `7C3F` calls it only when `D074!=0`; the zero path enters `7A02`.
F10's original watched run has a different draw stream and result after the
common258 setup draws. Detailed player actions cannot be reconstructed as
facts from DD02's aggregate chances.

## Watched tick and first native boundary

[confirmed: seg_0AB9_13.asm,7A02–7B7A] One watched tick visits22 entries of the
order table at0B17. The flagged-ball branch uses0B2D,CF51,CF53,CF54,D0BB and
ball state CF46; it calls7423 and21D7,can call72BB for the opposite keeper,
and can visit all22 players through4DFF. Each order-table player is tested
through1CA1 and can enter72BB. The actor can trigger21D7;79ED,1998:0A16 and
78B7 run in the tick body. D0BE is decremented by2 when positive after the
loop. A native implementation must port these reached computations and their
read sets;returning pre-recorded event rows is not an implementation.

[designed] The next bounded native input contract should begin before the
first watched tick with supplied selected squads,readonly facts,ball/scene
state and current counters,then retain one image. T39's first-tick observations
are assertions and a read-set starting point,not a complete admission. Close
actual72BB/action/motion dependencies in observed order. Retain explicit
unsupported diagnostics until each reached branch is native. Timer dependence
remains scoped;no arbitrary full-match/watched claim follows from a prefix.

## Commentary ABI and identities

[confirmed: seg_0AB9_02.asm,0F94–0FFD and0E45–0F41] At0F94 entry,code is the
low byte atSP+2;SP+4 andSP+6 are roster slots;side is the low byte atSP+8.
0E45 resolves the **SP+6** slot into queue primary and **SP+4** into queue
secondary,using the club atD6E4+2*side. Zero slot yields ID0. Code/side upper
argument bytes are ignored. The observer's first attempt incorrectly treated
these bytes as words and reversed the slot roles;its aborted output is not
accepted evidence.

[confirmed] Queue head0380 advances only for an accepted,nonduplicate tuple.
A row is(code,primary player word,secondary player word,side byte),six bytes
atA52A+6*index. The next row's code becomesFF;its remaining bytes are preserved.
Formatting is separate from acceptance and logical weighted/counter updates.

[confirmed: seg_0AB9_01.asm,09E1–0AD2;strings.tsv DS0382 onward]09BD reads a
Pascal template atDS:0382+21*signed8(code). Marker1 inserts queue primary;
marker2 inserts queue secondary. Markers can precede or follow the action.
A nonzero secondary ID is not automatically an assist,fouled opponent or pass
recipient:the specific event/template determines its role.

[derived from those literal templates] The action meanings needed by a new
formatter include:

| Numeric code | Action | Named field |
| --- | --- | --- |
| 1,2 | pass | primary |
| 6 | run with the ball | primary |
| 8,9,10 | receiving a ball/pass | secondary |
| 11 | tackle | primary |
| 12 | evading a challenge | primary |
| 14 | winning the ball | primary |
| 15,16 | cross | primary |
| 17,18,19,20 | shot,volley,quick shot,header | primary |
| 25 | possession | primary |
| 28 | save | primary |
| 29,30 | block,deflection | primary |
| 33,34,35 | knocking on,interception,collection | primary |
| 38,39 | goal,own goal | primary |
| 49 | kickoff taker | primary |
| 50,51,52 | booking,dismissal,injury | primary |

[designed] New wording can describe these actual emitted actions in English.
It must preserve player identity,chronology and outcome;it must not add a
shot/pass/tackle merely because the clock advanced,derive player actions from
team-rating contests,or convert this observer into a viewer runtime backend.
The owner requires those action-producing paths under native issue62/35;
the current quick-result summary remains below that requirement.
