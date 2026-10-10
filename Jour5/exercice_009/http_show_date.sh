URL="$1"

if [[ "$URL" != http://* ]]; then
    echo "Erreur : cette commande ne gère que le HTTP, pas HTTPS."
    exit 1
fi


HOST=$(echo "$URL" | sed 's|http://||' | cut -d '/' -f 1)
PATH_URL=$(echo "$URL" | sed 's|http://[^/]*||')



RESPONSE=$(
    {
        printf 'GET %s HTTP/1.0\r\nHost: %s\r\nConnection: close\r\n\r\n' "$PATH_URL" "$HOST"
        sleep 1
    } | timeout 5 telnet "$HOST" 80 2>&1
)

DATE=$(echo "$RESPONSE" | grep -i '^Date:')
if [ -n "$DATE" ]; then
    echo "$DATE"
else
    echo "Aucun en-tête Date trouvé."
fi


