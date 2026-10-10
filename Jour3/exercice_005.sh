if dpkg -l | grep -q "^ii  curl "; then
echo "Le paquet 'curl' est installé."
else
echo "Le paquet 'curl' n'est pas installé."
fi
