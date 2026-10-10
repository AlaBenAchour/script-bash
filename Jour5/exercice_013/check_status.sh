code=$(curl -s -o /dev/null -w "%{http_code}" "$1")

if [ "$code" -ge 200 ] && [ "$code" -le 299 ]; then
    echo "Status: success"
else
    echo "Status: failed"
fi
