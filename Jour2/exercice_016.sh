mkdir -p exercice_016 && grep -o '[^ ]*,Marie,[0-9]*' personnes.csv | awk -F',' '{somme += $3; count++} END {if (count > 0) print somme / count}' > moyenne_age_marie.txt
