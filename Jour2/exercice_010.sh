mkdir -p exercice_010/archive && echo "Données" > exercice_010/archive/data.txt && tar -cf - exercice_010/archive | gzip | tee exercice_010/data.tar.gz > /dev/null
