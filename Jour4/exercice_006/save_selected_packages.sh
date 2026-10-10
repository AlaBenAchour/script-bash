OUTPUT_FILE="selected_packages.txt"
LOG_FILE="save_packages.log"

echo "[$(date)] Début de la sauvegarde des paquets." > "$LOG_FILE"


selected_packages=$(dpkg-query -l | awk '$1 == "ii" {print $2}' 2>> "$LOG_FILE")


if [ $? -ne 0 ]
then
    echo "ERREUR : Impossible de récupérer les paquets." >> "$LOG_FILE"
    echo "Échec de la récupération des paquets."
    exit 1
fi

if [ -z "$selected_packages" ]
then
    echo "ERREUR : La liste des paquets est vide." >> "$LOG_FILE"
    echo "Aucun paquet à sauvegarder."
    exit 1
fi

echo "Liste des paquets récupérée avec succès." >> "$LOG_FILE"


if echo "$selected_packages" > "$OUTPUT_FILE"; then
    echo "Sauvegarde effectuée dans $OUTPUT_FILE." >> "$LOG_FILE"
    echo "Nombre de paquets sauvegardés : $(echo "$selected_packages" | wc -l)" >> "$LOG_FILE"
    echo "[$(date)] Sauvegarde terminée avec succès." >> "$LOG_FILE"
    echo "Succès : les paquets ont été sauvegardés."
else
    echo "ERREUR : Échec de l'écriture dans $OUTPUT_FILE." >> "$LOG_FILE"
    echo "Échec de la sauvegarde."
    exit 1
fi

echo "Consultez $LOG_FILE pour les détails."
exit 0