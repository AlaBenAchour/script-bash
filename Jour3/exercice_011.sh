mkdir -p backup_hosts

checksum_avant=$(md5sum /etc/hosts | cut -d ' ' -f 1)
cp /etc/hosts backup_hosts/
checksum_apres=$(md5sum backup_hosts/hosts | cut -d ' ' -f 1)

echo "Checksum avant copie : $checksum_avant"
echo "Checksum après copie : $checksum_apres"

if [ "$checksum_avant" = "$checksum_apres" ]
then
    echo "La copie a réussi : les checksums correspondent."
else
    echo "Erreur : les checksums ne correspondent pas."
fi
