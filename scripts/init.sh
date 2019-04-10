cp scripts/commit-msg.sh .git/hooks/commit-msg

cat >> .git/config <<- EOM
[diff "ocamlformat-diff"]
  command = esy ocamlformat-diff --diff=patdiff
EOM

cat >> .git/info/attributes <<- EOM
*.ml diff=ocamlformat-diff
*.mli diff=ocamlformat-diff
*.mlt diff=ocamlformat-diff
EOM