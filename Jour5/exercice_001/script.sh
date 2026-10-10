DIR="sortie/"
FILE_URL="$1"
LOG_FILE="script.log"

log() {
    echo "$1" | tee -a "$LOG_FILE"
}

log "Création du répertoire \"$DIR\"."
mkdir -p "$DIR"
RET=$?
if [ $RET -eq 0 ]; then
    log "Répertoire créé !"
else
    log "Échec de la création du répertoire (code $RET) !"
    exit 1
fi

log "Téléchargement du fichier depuis $FILE_URL"
curl -s -f -o "${DIR}téléchargement" "$FILE_URL"
RET=$?
if [ $RET -eq 0 ]; then
    log "Fichier téléchargé !"
else
    log "Échec du téléchargement (code $RET) !"
    exit 1
fi