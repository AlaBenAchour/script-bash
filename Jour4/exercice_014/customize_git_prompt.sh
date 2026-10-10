ZSHRC="$HOME/.zshrc"
LOG="modification_theme_zsh.log"
THEME="agnoster"


if [ ! -f "$ZSHRC" ]; then
    echo "ERREUR : fichier .zshrc introuvable."
    echo "$(date): ERREUR - .zshrc absent" >> "$LOG"
    exit 1
fi

if cp "$ZSHRC" "$ZSHRC.bak"; then
    echo "Sauvegarde créée : $ZSHRC.bak"
else
    echo "ERREUR : impossible de sauvegarder .zshrc."
    echo "$(date): ERREUR - Sauvegarde impossible" >> "$LOG"
    exit 1
fi

if grep -qE '^[[:space:]]*ZSH_THEME=' "$ZSHRC"; then
    # Modifier uniquement la ligne active existante
    if sed -i -E \
        "s|^[[:space:]]*ZSH_THEME=.*|ZSH_THEME=\"$THEME\"|" "$ZSHRC"; then
        echo "Thème existant modifié : $THEME"
    else
        echo "ERREUR : modification du thème impossible."
        echo "$(date): ERREUR - Échec de sed" >> "$LOG"
        cp "$ZSHRC.bak" "$ZSHRC"
        exit 1
    fi
else
    
    if echo "ZSH_THEME=\"$THEME\"" >> "$ZSHRC"; then
        echo "Variable ZSH_THEME ajoutée : $THEME"
    else
        echo "ERREUR : impossible d'ajouter la variable."
        echo "$(date): ERREUR - Ajout impossible" >> "$LOG"
        cp "$ZSHRC.bak" "$ZSHRC"
        exit 1
    fi
fi


if grep -qE '^[[:space:]]*ZSH_THEME="agnoster"' "$ZSHRC"; then
    echo "$(date): SUCCÈS - Thème configuré sur agnoster" >> "$LOG"
    echo "Modification réussie. Relancez votre terminal."
else
    echo "$(date): ERREUR - Thème non confirmé" >> "$LOG"
    echo "ERREUR : le thème n'a pas pu être confirmé."
    exit 1
fi

echo "Journal : $LOG"