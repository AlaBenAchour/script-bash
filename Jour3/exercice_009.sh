man apt | grep -E "^[[:space:]]*(update|upgrade|full-upgrade|install,|autoremove|satisfy)" | while read ligne
do
    if echo "$ligne" | grep -q "apt-get(8)"
    then
        echo "$ligne"
    fi
done
