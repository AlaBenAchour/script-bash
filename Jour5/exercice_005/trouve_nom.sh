OUTPUT_FILE="recherche_dns.txt"


echo "Recherche DNS inversée pour l'IP : $1" 
INTERFACES=$(dig -x "$1" +short)

if [ -z "$INTERFACES" ]; then
    echo "Aucune adresse IP trouvée pour le domaine $1"
    exit 1
fi
{
    echo "$INTERFACES" 
} > "$OUTPUT_FILE"

echo "Recherche terminée."