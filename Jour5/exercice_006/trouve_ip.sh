LOG_FILE="trouve_ip.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}


log "Recherche de l'IP de \"$1\"..." 

HOST_RESULT=$(host -t A "$1" 2>/dev/null) 
echo "$HOST_RESULT" >> "$LOG_FILE"

INTERFACES=$(echo "$HOST_RESULT" | awk '/has address/ {print $4; exit}')

log "L'IP de \"$1\" est $INTERFACES."
log "Test de PING vers $INTERFACES..."


if ping -c 1 -W 3 "$INTERFACES" >> "$LOG_FILE" 2>&1
then 
log "PING réussi !" 
else 
log "Échec du PING vers $INTERFACES." 
exit 1 
fi
