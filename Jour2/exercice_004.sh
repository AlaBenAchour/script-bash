mkdir exercice_004 && touch exercice_004/whoami.txt && whoami | sed 's/^/User: /' | tee exercice_004/whoami.txt
