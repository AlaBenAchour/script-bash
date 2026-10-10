USER_NAME="$2"
GROUP_NAME="$4"


if getent group "$GROUP_NAME" > /dev/null; then
    echo "Le groupe $GROUP_NAME existe déjà."
else
    sudo groupadd "$GROUP_NAME"

    if [ $? -eq 0 ]; then
        echo "Le groupe $GROUP_NAME a été créé."
    else
        echo "Erreur : impossible de créer le groupe $GROUP_NAME."
        exit 1
    fi
fi


if id "$USER_NAME" > /dev/null 2>&1; then
    echo "L'utilisateur $USER_NAME existe déjà."
else
    sudo useradd -m "$USER_NAME"

    if [ $? -eq 0 ]; then
        echo "L'utilisateur $USER_NAME a été créé."
    else
        echo "Erreur : impossible de créer l'utilisateur $USER_NAME."
        exit 1
    fi
fi


if sudo usermod -aG "$GROUP_NAME" "$USER_NAME"; then
    echo "L'utilisateur $USER_NAME a été ajouté au groupe $GROUP_NAME."
else
    echo "Erreur : impossible d'ajouter $USER_NAME au groupe."
    exit 1
fi


echo "Groupes de l'utilisateur $USER_NAME :"
groups "$USER_NAME"
