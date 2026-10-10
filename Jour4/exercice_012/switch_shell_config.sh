
CONFIG_DIR="configurations_zsh"
ZSHRC="$HOME/.zshrc"
LOG="config_zsh.log"




if [ ! -d "$CONFIG_DIR" ]; then
    echo "Erreur : répertoire introuvable : $CONFIG_DIR"
    echo "$(date): ERREUR - Répertoire absent" >> "$LOG"
    exit 1
fi

i=1
for fichier in "$CONFIG_DIR"/*.zshrc; do
    if [ -f "$fichier" ]; then
        echo "$i. $(basename "$fichier")"
        i=$((i + 1))
    fi
done


if [ "$i" -eq 1 ]; then
    echo "Aucune configuration disponible."
    exit 1
fi


while true; do
    read -r -p "Choisissez un numéro : " choix
    if [[ "$choix" =~ ^[0-9]+$ ]] &&
       [ "$choix" -ge 1 ] && [ "$choix" -lt "$i" ]; then
        break
    fi
    echo "Choix invalide. Veuillez réessayer."
done

numero=1
for fichier in "$CONFIG_DIR"/*.zshrc; do
    if [ -f "$fichier" ]; then
        if [ "$numero" -eq "$choix" ]; then
            selection="$fichier"
            break
        fi
        numero=$((numero + 1))
    fi
done


if cp "$ZSHRC" "$ZSHRC.bak" 2>/dev/null || [ ! -f "$ZSHRC" ]; then
    if cp "$selection" "$ZSHRC"; then
        echo "Configuration appliquée avec succès : $(basename "$selection")"
        echo "$(date): SUCCÈS - Configuration appliquée : $selection" >> "$LOG"
    else
        echo "Erreur lors de la copie de la configuration."
        echo "$(date): ERREUR - Échec de la copie" >> "$LOG"
        exit 1
    fi
else
    echo "Erreur : impossible de sauvegarder le fichier .zshrc."
    echo "$(date): ERREUR - Sauvegarde impossible" >> "$LOG"
    exit 1
fi

echo "Sauvegarde disponible dans : $ZSHRC.bak"
echo "Journal des opérations : $LOG"
