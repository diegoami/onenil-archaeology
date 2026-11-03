# T39-r0001 is an aborted test-side capture,not producer-identified evidence

[confirmed] The initial resume test incorrectly called the capture command before
requiring the completed index. It therefore started an extra original prefix
instead of failing immediately for missing fixtures. The test also mocked the
`git` helper,so this aborted record contains `code_commit: unused`. That is not a
valid producer identity and this run cannot support behavior claims. It was
interrupted with SIGINT and remains unchanged. The committed observer itself was
bf0e688;the then-uncommitted resume test was retained in820f131 together with its
actual failures. The corrected test checks the completed corpus first and forbids
constructing an original Week during resume.

The independently started capture from committed observer bf0e688 was running
separately throughout. It must reach all32 accepted events and pass validation
before any completed-prefix claim. No retrospective success or producer identity
is assigned to the aborted test-side record.
