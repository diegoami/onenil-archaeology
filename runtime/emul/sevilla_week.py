"""T93: the Sevilla week's full-time route, captured — cash, news, the week
transaction and the week-2 state.

The native T91 refusal names the gap: the second week's cash movement is
unwitnessed. This module extends the T89 route — authenticate the pinned
post-week save, replay the witnessed match verified against the committed
sevilla-r0001 chunk identity, continue through the sealed caller, then
observe the full-time acknowledgement, the cash flow screen, the transfer
news screen and the week transaction with typed facts: the second week's
cash in/out and resulting cash, the save-diff fixture advance (slot, week
byte, the Celtic triple), the weekly condition refresh for the managed
roster, the week screens' texts, and the week-2 campaign projection.

Counts are observed, never transplanted: the week-0 cash values (38,761 /
69,270) are week-specific and the protocol refuses them by name. The
pre-advance finding applies at week 2 as at week 1 — observations bind the
prepared and live contexts explicitly. Long-run rules apply: append-only
records pushed at milestones, a resume command that skips what is recorded.
"""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
CAPTURE = ROOT / 'runs/T89/sevilla-r0001'

# The digest-pinned private identities (owner-local; never in git).
ENTRY_SAVE_SHA = 'f3aa2e4f076891fca47ca686664502a0f69ed79bdd67de0910bf0ed932225e29'
PREPARATION_STATE_SHA = '98275eb59475dc155e12c915996c2c2cbd0fc1298ffedf14490ff2aa118805c9'

# [confirmed:T81 dc54fe9] The week-0 movement — named only to refuse it.
WEEK0_TRANSPLANT = (38_761, 69_270)

# [confirmed:T82 c13195a] The week-2 following fixture the original should
# advertise after the Sevilla week's transaction.
WEEK2_FOLLOWING = dict(week=2, competition=1, opponent=28, flags=0)

encoded = lambda value: json.dumps(value, sort_keys=True, separators=(',', ':')).encode()
sha = lambda data: hashlib.sha256(data).hexdigest()


def match_identity():
    """The committed sevilla-r0001 identity the replay must reproduce: the
    digest-chained chunk ledger, the observed counts and the return boundary."""
    finish = json.loads((CAPTURE / 'finish.json').read_text())
    index = json.loads((CAPTURE / 'index.json').read_text())
    result = finish['result']
    if finish['status'] != 'completed' or result['entry_draws'] != 0:
        raise ValueError('the committed sevilla capture is not a complete natural run')
    return dict(
        chunk_sha256=[leaf['sha256'] for leaf in index['chunks']],
        ticks=result['ticks'], draws=result['draws'], actions=result['actions'],
        match_return=dict(site=result['match_return']['site'],
                          draw=result['match_return']['draw'],
                          seed=result['match_return']['seed']))


def authenticate_entry(save_sha256):
    """The entry gate: refuse any state that is not the T81/T82-authenticated
    post-week save before any emulation begins."""
    if save_sha256 != ENTRY_SAVE_SHA:
        raise ValueError('the entry save is not the authenticated post-week state')


def authenticate_week_facts(cash_in, cash_out, following):
    """The observed week facts: refuse the week-0 transplant by name and
    require the week-2 advertisement the T82 decode names."""
    if (cash_in, cash_out) == WEEK0_TRANSPLANT:
        raise ValueError('the week-0 cash movement is week-specific and cannot '
                         'stand for the Sevilla week')
    if following != WEEK2_FOLLOWING:
        raise ValueError('the week-2 following fixture differs from the '
                         'T82-decoded Celtic triple')


def check(directory):
    """Public acceptance: re-validate a complete capture directory without any
    private file. Refuses an unrecorded run."""
    if directory is None:
        raise ValueError('no recorded sevilla week run to check')
    directory = Path(directory)
    start = json.loads((directory / 'start.json').read_text())
    finish = json.loads((directory / 'finish.json').read_text())
    index = json.loads((directory / 'index.json').read_text())
    if start['schema'] != 'sevilla-week-start/1' or finish['schema'] != 'sevilla-week-finish/1':
        raise ValueError('sevilla week record schema differs')
    if finish['status'] != 'completed':
        raise ValueError('the recorded sevilla week run did not complete')
    identity = match_identity()
    if [leaf['sha256'] for leaf in index['chunks']] != identity['chunk_sha256']:
        raise ValueError('the replayed match stream differs from the sealed identity')
    result = finish['result']
    for key in ('ticks', 'draws', 'actions'):
        if result['match'][key] != identity[key]:
            raise ValueError(f'the replayed match {key} count differs from the sealed identity')
    authenticate_week_facts(result['week']['cash_in'], result['week']['cash_out'],
                            result['week']['following'])
    # The caller must reproduce the sealed T89 record's footprint.
    sealed_caller = json.loads((CAPTURE / 'finish.json').read_text())['result']['caller']
    for key in ('frame', 'census', 'preservation'):
        if result['caller'][key] != sealed_caller[key]:
            raise ValueError(f'the replayed caller {key} differs from the sealed T89 record')
    return dict(schema='sevilla-week-check/1', status='accepted',
                ticks=result['match']['ticks'], week=result['week'])
