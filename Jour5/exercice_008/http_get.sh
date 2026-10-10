OUTPUT_FILE="reponse_http.txt"
URL="$1"

if [[ "$URL" != http://* ]]; then
    echo "Erreur : cette commande ne gère que le HTTP, pas HTTPS."
    exit 1
fi


HOST=$(echo "$URL" | sed 's|http://||' | cut -d '/' -f 1)
PATH_URL=$(echo "$URL" | sed 's|http://[^/]*||')



printf 'GET %s HTTP/1.0\r\nHost: %s\r\n\r\n' \
    "$PATH_URL" "$HOST" | nc "$HOST" 80 | tee "$OUTPUT_FILE"

