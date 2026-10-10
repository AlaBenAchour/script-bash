TARGET_DIRECTORY="./copie"
SOURCE_FILE="../exercice_001/sortie/téléchargement"
FILE_NAME="téléchargement"
STATUS_FILE="$TARGET_DIRECTORY/status"
LIMIT=100


if [ ! -d "$TARGET_DIRECTORY" ]; then
    echo "Le répertoire \"$TARGET_DIRECTORY/\" n'existe pas."
    echo "Création du répertoire \"$TARGET_DIRECTORY/\""
    mkdir -p "$TARGET_DIRECTORY"
fi


if [ -f "$SOURCE_FILE" ]; then
    echo "Copie du fichier $SOURCE_FILE dans $TARGET_DIRECTORY/"
    cp "$SOURCE_FILE" "$TARGET_DIRECTORY/$FILE_NAME"
else
    echo "Erreur : le fichier source $SOURCE_FILE n'existe pas."
    exit 1
fi


echo "Calcul de la taille du téléchargement."
FILE_SIZE=$(du -k "$TARGET_DIRECTORY/$FILE_NAME" | cut -f1)


echo "Génération du fichier de status."

if [ "$FILE_SIZE" -gt "$LIMIT" ]; then
    echo "Fichier supérieur à 100 Ko" > "$STATUS_FILE"
else
    echo "Fichier inférieur ou égal à 100 ko" > "$STATUS_FILE"
fi
