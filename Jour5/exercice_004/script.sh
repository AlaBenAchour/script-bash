URL="$1"
DIG="dig"

DOMAIN=$(echo "$URL" | awk -F/ '{print $3}')

echo "Récupération de l'adresse IP du domaine $DOMAIN"

"$DIG" @8.8.8.8 "$DOMAIN" +short
