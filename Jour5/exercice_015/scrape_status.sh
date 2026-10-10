url="$1"
file="$2"

while IFS= read -r resource; do
    full_url="${url%/}/$resource"

    echo "Test de l'url : $full_url"

    status=$(curl -s -o /dev/null -w "%{http_code}" -I "$full_url")
    status_line=$(curl -s -I "$full_url" | head -n 1)

    echo "$resource : $status_line" >> resource_status.log
done < "$file"