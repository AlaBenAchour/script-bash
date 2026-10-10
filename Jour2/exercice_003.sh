mkdir exercice_003 && touch exercice_003/uname.txt && uname -a | sed 's/^/System: /' | tee exercice_003/uname.txt
