DEPOT="ma_configuration"
LOG="maj_configuration.log"


echo "$(date): Début de la synchronisation" >> "$LOG"

# Vérifier que le répertoire existe
if [ ! -d "$DEPOT" ]; then
    echo "ERREUR : le répertoire $DEPOT n'existe pas."
    echo "$(date): ERREUR - Répertoire introuvable : $DEPOT" >> "$LOG"
    exit 1
fi


if ! git -C "$DEPOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "ERREUR : $DEPOT n'est pas un dépôt Git valide."
    echo "$(date): ERREUR - Dépôt Git invalide" >> "$LOG"
    exit 1
fi

echo "Dépôt Git valide : $DEPOT"
echo "$(date): OK - Dépôt Git validé" >> "$LOG"


echo "Récupération des dernières modifications..."
if git -C "$DEPOT" pull >> "$LOG" 2>&1; then
    echo "SUCCÈS : dépôt synchronisé."
    echo "$(date): SUCCÈS - Synchronisation terminée" >> "$LOG"
else
    echo "ERREUR : échec de git pull. Consultez le journal."
    echo "$(date): ERREUR - Échec de synchronisation" >> "$LOG"
    exit 1
fi

if git -C "$DEPOT" log -1 --oneline; then
    echo "$(date): INFO - Dernier commit affiché" >> "$LOG"
else
    echo "AVERTISSEMENT : impossible de lire le dernier commit."
    echo "$(date): AVERTISSEMENT - Lecture du commit impossible" >> "$LOG"
fi

echo "Mise à jour terminée."
echo "Journal détaillé : $LOG"
echo "$(date): Fin du script" >> "$LOG"

exit 0
