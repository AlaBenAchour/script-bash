apt-get install -y vim > /dev/null 2>&1

if dpkg -l vim | grep -q "^ii"; then
    echo "Le paquet 'vim' s'est correctement installé."
else
    echo "Le paquet 'vim' n'a pas été installé."
fi
