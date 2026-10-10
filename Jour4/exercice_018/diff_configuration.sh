FICHIER_LOCAL="$HOME/.zshrc"
FICHIER_GIT="./.zshrc"


if [ -f "$FICHIER_LOCAL" ] && [ -f "$FICHIER_GIT" ]; then
    echo "Les deux fichiers existent."
    echo "Comparaison en cours..."

    if diff -u "$FICHIER_LOCAL" "$FICHIER_GIT"; then
        echo "Aucune différence détectée : les fichiers sont identiques."
    else
        CODE=$?
        if [ "$CODE" -eq 1 ]; then
            echo "Des divergences ont été détectées."
        else
            echo "Erreur lors de la comparaison des fichiers."
            exit 2
        fi
    fi
else
    echo "Erreur : un ou plusieurs fichiers sont introuvables."
    [ -f "$FICHIER_LOCAL" ] || echo "Fichier local absent : $FICHIER_LOCAL"
    [ -f "$FICHIER_GIT" ] || echo "Fichier Git absent : $FICHIER_GIT"
    exit 1
fi
