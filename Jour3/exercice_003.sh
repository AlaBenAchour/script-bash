if [ $# -ne 1 ]; then
	echo "Argument invalide."
	exit 1
fi 
case "$1" in "hello") echo "Bonjour" ;; "user") echo "$(whoami)" ;; "machine") echo "$(hostname)" ;; *) echo "Argument invalide." ;; esac
