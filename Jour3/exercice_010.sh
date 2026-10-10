fichier="tempfile_$(date +%s).txt"
touch "$fichier"
if [ -f "$fichier" ]
then
initial=$(ls -l "$fichier")
echo "Permissions initiales de '$fichier' :"
echo "$initial"
chmod 600 "$fichier"
chown root:root "$fichier"
final=$(ls -l "$fichier")
echo "Permissions modifiées de '$fichier' :"
echo "$final"
fi
