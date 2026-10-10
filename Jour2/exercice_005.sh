mkdir exercice_005 && touch exercice_005/uptime.txt && uptime | sed 's/^/Uptime: /' | tee exercice_005/uptime.txt
