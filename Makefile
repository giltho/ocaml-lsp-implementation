default:
	dune build bin/wisl.exe

doc:
	dune build @doc-private && rm -rf doc/ && cp -R _build/default/_doc/_html ./doc/

.PHONY: doc

init:
	cp scripts/commit-msg.sh .git/hooks/commit-msg