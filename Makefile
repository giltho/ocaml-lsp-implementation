default:
	dune build bin/wisl.exe
	#we have to do that because ppx_deriving_yojson does weird things..

doc:
	dune build @doc
	dune build @doc-private
	rm -rf ./doc
	mkdir -p doc
	cp -R _build/default/_doc/_html ./doc/

.PHONY: doc

clean:
	dune clean
	rm -rf doc
	rm -rf environment

init:
	cp scripts/commit-msg.sh .git/hooks/commit-msg