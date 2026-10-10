if [ "$#" -ne 1 ]; then
    echo "Usage : $0 <nom_utilisateur>"
    exit 1
fi

UTILISATEUR="$1"
SAUVEGARDE="./paquets.txt"
CONFIG="./zshrc"


if [ "$EUID" -ne 0 ]; then
    echo "Erreur : exécutez ce script avec sudo."
    exit 1
fi


installer_paquets() {
    echo "[INFO] Mise à jour des dépôts APT..."
    apt update || return 1

    if [ -f "$SAUVEGARDE" ]; then
        while IFS= read -r paquet; do
            [ -z "$paquet" ] && continue
            echo "[INFO] Installation du paquet : $paquet"
            apt install -y "$paquet" || \
                echo "[ERREUR] Échec d'installation : $paquet"
        done < "$SAUVEGARDE"
    else
        echo "[ERREUR] Fichier de sauvegarde introuvable."
        return 1
    fi
}


restaurer_config() {
    local utilisateur="$1"
    local repertoire

    if [ "$utilisateur" = "root" ]; then
        repertoire="/root"
    else
        repertoire=$(getent passwd "$utilisateur" | cut -d: -f6)
    fi

    if [ -z "$repertoire" ] || [ ! -d "$repertoire" ]; then
        echo "[ERREUR] Répertoire introuvable pour $utilisateur."
        return 1
    fi

    if [ -f "$CONFIG" ]; then
        echo "[INFO] Copie de la configuration vers $repertoire/.zshrc"
        cp "$CONFIG" "$repertoire/.zshrc" || return 1
        chown "$utilisateur:$utilisateur" "$repertoire/.zshrc" \
            2>/dev/null || true
    else
        echo "[ERREUR] Fichier de configuration absent : $CONFIG"
        return 1
    fi

   
    if command -v zsh >/dev/null 2>&1; then
        echo "[INFO] Configuration du shell pour $utilisateur"
        chsh -s "$(command -v zsh)" "$utilisateur"
    else
        echo "[AVERTISSEMENT] Zsh n'est pas installé."
    fi
}


if ! id "$UTILISATEUR" >/dev/null 2>&1; then
    echo "[ERREUR] L'utilisateur $UTILISATEUR n'existe pas."
    exit 1
fi

echo "=== Début de la restauration ==="

installer_paquets
if [ "$?" -ne 0 ]; then
    echo "[ERREUR] Problème pendant l'installation des paquets."
    exit 1
fi


for utilisateur in "$UTILISATEUR" root; do
    echo "[INFO] Restauration pour $utilisateur"
    if restaurer_config "$utilisateur"; then
        echo "[OK] Configuration restaurée pour $utilisateur"
    else
        echo "[ERREUR] Échec pour $utilisateur"
    fi
done
