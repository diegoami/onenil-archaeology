# Process

[designed: owner, 2026-10-29, from goal2 and malpaco] How work runs. The rules are in CLAUDE.md.

## 1. Tasks

`docs/tasks/T<nn>.md` from [TEMPLATE.md](tasks/TEMPLATE.md), 150-400 words, indexed in
[tasks/README.md](tasks/README.md), each with its GitHub issue. Each **Done when** line is one check a
command can run: it fails before the task and passes after. A task likely to outlast about an hour
of implementation is split. The main session edits task files on `main`, with the reason.

## 2. The loop

`ready → implement → checks → merge → follow-ups → report`

1. On a branch `task/T<nn>-<slug>`; commit and push after each step; a draft PR after the first push.
2. **Checks**: every Done-when line on the PR head, the repository's checks and green CI.
3. **No per-PR review**: the PR merges on its checks. A review only at a milestone, or when the
   owner asks for one: then the main session writes the prompt and the owner runs it on a model of
   their choice. No session starts a review.
4. Merge pinned to the checked head (`gh pr merge <pr> --match-head-commit <sha>`).

## 3. Milestones and reviews

A milestone is a coherent set of merged work. Its issue (label `milestone`) lists the PRs merged
since the last one and ends with the review prompt; the owner runs it on a model of their choice.
[designed: owner, 2026-10-29, as in the owner's other repositories] Everything of a review goes
through GitHub, never only through chat: the review is posted on the milestone issue (by the
reviewer, or verbatim by the main session when the owner pastes it), each finding becomes an issue
labelled `review`, and the fixes are a PR that closes those issues and is merged like a task's
(its checks, CI green, a merge commit). The main session relays the findings in full.

## 4. Stop and resume

Every task is resumable and cut into milestones of its own, so a crash or a stop loses at most the
unit in progress. Reaching one means its outputs are committed and pushed (anything holding
original bytes to the owner's Drive, never to git) and a checkpoint comment says which is reached
and what is next. Long runs write append-only records, have a resume command that skips what is
recorded, and push their records while they run. A session resumes from the latest checkpoint
comment and rechecks live heads and checks first; a run found stopped is resumed, never assumed to
have passed.

For another computer, clone both repositories, preferably as siblings. Read the rules and the
latest checkpoint comments in [onenil-archaeology #1](https://github.com/diegoami/onenil-archaeology/issues/1)
and [onenil #1](https://github.com/diegoami/onenil/issues/1), then recheck live heads, labels and
checks. These checkpoints own current status, unfinished work, checked commits and the next
bounded action; do not infer current work from an old task definition or a local cache.

The READMEs contain public-check/build commands. Their decoded fixtures travel in git; neither
public corpus verification nor native replay needs private game bytes. A new original-code run
also needs the [private artifacts](artifacts.md#restoring-on-another-computer). Virtual environments,
compiled extensions, build caches and temporary worktrees are regenerated on the new machine.

## 5. Bugs and triage

Bugs and non-blocking findings are issues labelled `triage:needed`; triage decides fix, task,
fold or close. Status lives in GitHub labels and issues, not in documents.
