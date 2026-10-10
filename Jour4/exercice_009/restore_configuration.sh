if [ $# -ne 1 ]; then
    echo "Usage : $0 archive.tar.gz"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Erreur : fichier non trouvé : $1"
    exit 1
fi

echo "Restauration de l'archive : $1"

tar -xzf "$1" -C "$HOME"

echo "Restauration terminée."