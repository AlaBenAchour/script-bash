mkdir exercice_002 && touch exercice_002/hostname.txt && hostname | sed 's/^/Hostname: /' | tee exercice_002/hostname.txt
