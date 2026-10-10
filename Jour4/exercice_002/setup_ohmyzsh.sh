LOG_FILE="setup_ohmyzsh.log"
ZSH_CONFIG_DIR="$HOME/.oh-my-zsh"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Début de l'installation de Oh My Zsh."

if [ -d "$ZSH_CONFIG_DIR" ]
then
    log "Oh My Zsh est déjà installé : $ZSH_CONFIG_DIR"
    log "Aucune installation nécessaire."
    exit 0
fi

log "Oh My Zsh n'est pas installé."
log "Lancement de l'installation en mode unattended."

if curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended >> "$LOG_FILE" 2>&1; then
    log "Installation de Oh My Zsh terminée avec succès."
else
    log "ERREUR : l'installation de Oh My Zsh a échoué."
    exit 1
fi

log "Fin du script."
