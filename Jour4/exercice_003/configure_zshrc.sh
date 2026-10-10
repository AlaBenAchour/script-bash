LOG_FILE="configure_zshrc.log"
ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.backup"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Début de la configuration de Zsh."


if [ -f "$ZSHRC" ]
then
    log "Fichier .zshrc existant détecté."

    if cp "$ZSHRC" "$BACKUP"
    then
        log "Sauvegarde créée : $BACKUP"
    else
        log "ERREUR : impossible de sauvegarder .zshrc."
        exit 1
    fi
else
    log "Fichier .zshrc absent. Création du fichier."
    if ! touch "$ZSHRC"; then
        log "ERREUR : impossible de créer .zshrc."
        exit 1
    fi
fi


if grep -Eq '^[[:space:]]*plugins=' "$ZSHRC"; then
    log "Déclaration des plugins existante détectée."

    if grep -Eq '^[[:space:]]*plugins=.*(^|[ (])git([ )]|$)' "$ZSHRC"; then
        log "Le plugin git est déjà déclaré."
    else
        if sed -i '/^[[:space:]]*plugins=/ s/)/ git)/' "$ZSHRC"; then
            log "Plugin git ajouté."
        else
            log "ERREUR : impossible de modifier les plugins."
            exit 1
        fi
    fi

    if grep -Eq '^[[:space:]]*plugins=.*zsh-completions' "$ZSHRC"; then
        log "Le plugin zsh-completions est déjà déclaré."
    else
        if sed -i '/^[[:space:]]*plugins=/ s/)/ zsh-completions)/' "$ZSHRC"; then
            log "Plugin zsh-completions ajouté."
        else
            log "ERREUR : impossible de modifier les plugins."
            exit 1
        fi
    fi
else
    log "Aucune déclaration des plugins détectée."
    echo "" >> "$ZSHRC"
    echo "# Plugins Oh My Zsh" >> "$ZSHRC"
    echo "plugins=(git zsh-completions)" >> "$ZSHRC"
    log "Déclaration des plugins ajoutée."
fi


if grep -Eq '^[[:space:]]*autoload[[:space:]]+-Uz[[:space:]]+compinit' "$ZSHRC"; then
    log "La commande compinit est déjà déclarée."
else
    echo "" >> "$ZSHRC"
    echo "# Activation de la complétion Zsh" >> "$ZSHRC"
    echo "autoload -Uz compinit && compinit" >> "$ZSHRC"
    log "Activation de compinit ajoutée."
fi

log "Configuration de .zshrc terminée."
log "Fin du script."
