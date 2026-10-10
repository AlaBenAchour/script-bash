if [ "$#" -ne 1 ]; then
    echo "Usage: exercice_017.sh [chaine-de-recherche]"
    exit 1
fi

critere="$1"

paquets=$(dpkg -l | awk '$1 == "ii" {print $2}')

for paquet in $paquets
do
    echo "$paquet" | grep "$critere"
done