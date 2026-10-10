
LOG="etat_systeme.log"


echo "$(date): Début du contrôle système" >> "$LOG"


echo ""
echo "--- Version du shell ---"
if [ -n "$BASH_VERSION" ]; then
    echo "Shell : Bash $BASH_VERSION"
    echo "$(date): Shell Bash détecté : $BASH_VERSION" >> "$LOG"
else
    echo "Shell : $SHELL"
    echo "$(date): Shell détecté : $SHELL" >> "$LOG"
fi



if command -v dpkg-query >/dev/null 2>&1; then
    NB_PAQUETS=$(dpkg-query -W -f='${db:Status-Abbrev}\n' 2>> "$LOG" |
        grep -c '^ii ')
    if [ $? -eq 0 ] || [ -n "$NB_PAQUETS" ]; then
        echo "Nombre de paquets installés : $NB_PAQUETS"
        echo "$(date): Nombre de paquets installés : $NB_PAQUETS" >> "$LOG"
    else
        echo "ERREUR : impossible de compter les paquets."
        echo "$(date): ERREUR - Comptage des paquets impossible" >> "$LOG"
    fi
else
    echo "ERREUR : dpkg-query n'est pas disponible."
    echo "$(date): ERREUR - dpkg-query introuvable" >> "$LOG"
fi



if command -v git >/dev/null 2>&1; then
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        BRANCHE=$(git branch --show-current 2>> "$LOG")
        if [ -n "$BRANCHE" ]; then
            echo "Branche Git courante : $BRANCHE"
            echo "$(date): Branche Git détectée : $BRANCHE" >> "$LOG"
        else
            echo "Dépôt Git détecté, mais HEAD est détachée."
            echo "$(date): INFO - HEAD Git détachée" >> "$LOG"
        fi
    else
        echo "Aucun dépôt Git dans le répertoire courant."
        echo "$(date): INFO - Aucun dépôt Git détecté" >> "$LOG"
    fi
else
    echo "Git n'est pas installé."
    echo "$(date): ERREUR - Git introuvable" >> "$LOG"
fi


echo "Rapport terminé."
echo "Journal détaillé : $LOG"
echo "$(date): Fin du contrôle système" >> "$LOG"
