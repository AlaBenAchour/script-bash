commande="sudo apt-get install -y"


for paquet in $(cat "$1"); do
    if [ -n "$paquet" ]; then
        commande="$commande $paquet"
    fi
done

echo "$commande"
