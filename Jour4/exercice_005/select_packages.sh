paquets=$(dpkg-query -l | awk '$1 == "ii" {print $2}')

for paquet in $paquets 
do
echo -n "Choix pour $paquet ? (oui/non) " 
read choix

while [ "$choix" != "oui" ] && [ "$choix" != "non" ] 
do 
echo 'Veuillez choisir "oui" ou "non".' 
echo -n "Choix pour $paquet ? (oui/non) " 
read choix 
done
if [ "$choix" = "oui" ] 
then 
echo "$paquet OUI" >> packages.selected.answers 
echo "$paquet" >> packages.selected.list 
else 
echo "$paquet NON" >> packages.selected.answers 
fi 
done