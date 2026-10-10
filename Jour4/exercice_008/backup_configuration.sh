
archive="backup_config.tar.gz"
temp_archive="backup_config.tar"

echo "Création de l'archive : $archive"

# Créer une archive temporaire vide
tar -cf "$temp_archive" --files-from=/dev/null

while IFS= read -r fichier || [ -n "$fichier" ]; do
    if [ -z "$fichier" ]; then
        continue
    fi

    if [ -f "$HOME/$fichier" ]; then
        echo "Ajout du fichier : $fichier"
        tar -rf "$temp_archive" -C "$HOME" "$fichier"
    else
        echo "Erreur : fichier introuvable : $fichier"
    fi
done < "$1"

# Compresser l'archive
gzip -f "$temp_archive"

echo "Archivage terminé."