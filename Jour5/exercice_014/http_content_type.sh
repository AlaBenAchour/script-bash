curl -s -I "$1" | grep -i "^Content-Type:" | awk '{print $2}' | tr -d '\r'
