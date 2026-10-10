mkdir -p exercice_009/test && touch exercice_009/test/a.txt exercice_009/test/b.txt && find exercice_009/test -type f | sed 's/^/File: /g' | tee exercice_009/list.txt
