if [ $# -ne 1 ]; then
    echo "Erreur : veuillez fournir le fichier de paquets."
    exit 1
fi

PACKAGES_FILE="$1"

if [ ! -f "$PACKAGES_FILE" ]; then
    echo "Erreur : le fichier $PACKAGES_FILE n'existe pas."
    exit 1
fi

echo "Téléchargement des mises-à-jour..."

if sudo apt update; then
    echo "Mises à jour automatique du système."

    if sudo apt upgrade -y; then
        echo "Mise à jour terminée."
    else
        echo "Erreur : la mise à jour du système a échoué."
        exit 1
    fi
else
    echo "Erreur : impossible de mettre à jour la liste des paquets."
    exit 1
fi

while read -r package; do
    if [ -n "$package" ]; then
        echo "Reinstallation du paquet : $package"

        if sudo apt install --reinstall -y "$package"; then
            echo "Paquet $package réinstallé."
        else
            echo "Erreur : le paquet $package n'a pas pu être réinstallé."
        fi
    fi
done < "$PACKAGES_FILE"

echo "Mise à jour terminée."
