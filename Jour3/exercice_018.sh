paquets=$(cat liste_paquets.txt)

for paquet in $paquets
do
    if dpkg -l | grep -E "^ii[[:space:]]+$paquet([[:space:]]|:)" > /dev/null
    then
        echo "$paquet : INSTALLÉ" >> etat_paquets.txt
    else
        echo "$paquet : NON INSTALLÉ" >> etat_paquets.txt
    fi
done

cat etat_paquets.txt