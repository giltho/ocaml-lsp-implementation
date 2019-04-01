	dune build @doc
	dune build @doc-private
	rm -rf ./doc
	mkdir -p doc
	cp -R _esy/default/build/default/_doc/_html ./doc/