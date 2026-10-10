echo "Liste des paquets installés :"
paquets=$(dpkg-query -W -f='${Package}\n' | awk '{print $0}')
i=1
for paquet in $paquets 
do 
echo "$i : $paquet"  
i=$((i + 1))
done