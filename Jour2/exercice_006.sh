mkdir -p exercice_006 && touch exercice_006/file1 exercice_006/file2 && find exercice_006 -type f | sed 's/^/Found: /' | tee exercice_006/find.txt
