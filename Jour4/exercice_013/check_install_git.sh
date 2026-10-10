
LOG="installation_git.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG"
}

log "Début de la vérification"

if command -v git >/dev/null 2>&1; then
    echo "Git est déjà installé."
    log "SUCCÈS - Git est déjà installé"
else
    echo "Git n'est pas installé. Installation en cours..."
    log "INFO - Début de l'installation"
    
    if ! command -v apt >/dev/null 2>&1; then
        echo "Erreur : le gestionnaire apt n'est pas disponible."
        log "ERREUR - apt introuvable"
        exit 1
    fi

   
    if sudo apt update >> "$LOG" 2>&1 &&
       sudo apt install -y git >> "$LOG" 2>&1; then

        
        if command -v git >/dev/null 2>&1; then
            echo "Git a été installé avec succès."
            log "SUCCÈS - Installation terminée"
        else
            echo "Erreur : Git reste introuvable après l'installation."
            log "ERREUR - Vérification après installation échouée"
            exit 1
        fi
    else
        echo "Erreur lors de l'installation de Git."
        log "ERREUR - Échec de apt update ou apt install"
        exit 1
    fi
fi


if command -v git >/dev/null 2>&1; then
    git --version
    echo "$(date): Version détectée : $(git --version)" >> "$LOG"
fi

echo "Consultez le journal : $LOG"