if [ "$#" -ne 1 ]
then
    echo "Erreur: ce script nécessite exactement un argument."
    exit 1
fi

section=$(man ls | grep -A 1 -E "^[[:space:]]*$1([,=[:space:]]|$)")

if [ -n "$section" ]
then
    echo "Section des options trouvée :"
    echo "$section"
else
    echo "Section des options non trouvée."
fi
