if [ "$#" -ne 1 ]; then
echo "Usage: exercice_013.sh [SEUIL]"
exit 1
fi

seuil="$1"
processus=$(ps aux | awk -v seuil="$seuil" 'NR > 1 && $3 > seuil {print}')
if [ -z "$processus" ]; then
echo "Aucun processus ne correspond."
exit 0
fi

echo "Liste des processus consommant plus de $seuil% du CPU:"
echo "$processus"
echo "Entrez un PID pour terminer le processus:"
read -r pid
if [ -n "$pid" ]; then
echo "Envoi du signal de terminaison au processus $pid..."
kill "$pid"
fi
