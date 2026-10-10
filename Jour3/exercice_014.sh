if ! getent group etna > /dev/null 
then 
groupadd -g 4242 etna
echo "Groupe 'etna' créé." 
fi

if ! id testuser > /dev/null 2>&1
then
useradd -m -u 2121 testuser 
echo "Utilisateur 'testuser' créé."
fi
usermod -g etna testuser

echo "Voici les informations de l'utilisateur 'testuser':" 
id testuser
