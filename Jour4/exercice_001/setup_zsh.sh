LOG_FILE="setup_zsh.log"
#TARGET_USER="$USER"
TARGET_USER="${SUDO_USER:-$USER}"


log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Debut de la configuration de Zsh"
log "Utlisateur cible : $TARGET_USER"
log "Fichier de log : $LOG_FILE"

log "Vérification de la commande apt"
if ! command -v apt &> /dev/null 
then
    log "apt n'est pas installé. Veuillez installer apt avant de continuer."
    exit 1
fi

log "La commande apt est disponible"

log "Verifier si Zsh est installé"

if ! command -v zsh &> /dev/null 
then
    log "Zsh n'est pas installé. Installation de Zsh..."
    sudo apt update && sudo apt install -y zsh
    log "Zsh a été installé avec succès."
else
    log "Zsh est déjà installé."
fi
ZSH_PATH=$(command -v zsh)

log "Vérification du chemin de Zsh : $ZSH_PATH"


if [ ! -x "$ZSH_PATH" ]
then
    log "ERREUR: l'exécutable Zsh est introuvable ou non exécutable."
    exit 1
fi

log "Vérification de la liste des shells autorisés."

if ! grep -Fxq "$ZSH_PATH" /etc/shells
then
    log "ERREUR: $ZSH_PATH n'est pas déclaré dans /etc/shells."
    log "Ajoutez-le à /etc/shells avec les droits administrateur avant de continuer."
    exit 1
fi

log "Zsh figure dans la liste des shells autorisés."


log "Configuration du shell par défaut pour $TARGET_USER."

CURRENT_SHELL=$(getent passwd "$TARGET_USER" | cut -d: -f7)


if [ "$CURRENT_SHELL" = "$ZSH_PATH" ]
then
    log "Zsh est déjà le shell par défaut de $TARGET_USER."
else
    if [ "$(id -u)" -eq 0 ]; then
        CHSH="chsh"
    elif [ "$TARGET_USER" = "$USER" ] && command -v chsh >/dev/null 2>&1; then
        CHSH="chsh"
    elif command -v sudo >/dev/null 2>&1; then
        CHSH="sudo chsh"
    else
        log "ERREUR: impossible de modifier le shell sans droits suffisants."
        exit 1
    fi

    if $CHSH -s "$ZSH_PATH" "$TARGET_USER"; then
        log "Commande chsh exécutée avec succès."
    else
        log "ERREUR: échec de la modification du shell par défaut."
        exit 1
    fi
fi

log "Vérification de la configuration finale."

FINAL_SHELL=$(getent passwd "$TARGET_USER" | cut -d: -f7)

if [ "$FINAL_SHELL" = "$ZSH_PATH" ]
then
    log "SUCCÈS: Zsh est le shell par défaut de $TARGET_USER."
    log "Shell configuré : $FINAL_SHELL"
    log "Fin du script : SUCCÈS"
else
    log "ERREUR: le shell par défaut attendu est $ZSH_PATH, obtenu : $FINAL_SHELL"
    log "Fin du script : ÉCHEC"
    exit 1
fi

exit 0

