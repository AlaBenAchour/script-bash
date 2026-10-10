UPDATE="apt update"
if $UPDATE
then
echo "Liste des mises à jour disponibles:"
apt list --upgradable | tr '\n' ' ' | sed 's/ $//'; echo
fi
