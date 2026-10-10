
SOURCE_USER="${2:-${SUDO_USER:-$USER}}"
TARGET_USER="${1:-}"
SOURCE_HOME="$(getent passwd "$SOURCE_USER" | cut -d: -f6)"

if [[ -z "$TARGET_USER" ]]; then
    echo "Usage : sudo $0 <nom_utilisateur> [repertoire_modele]"
    exit 1
fi

if [[ "$EUID" -ne 0 ]]; then
    echo "Erreur : exécutez ce script avec sudo ou en tant que root."
    exit 1
fi

if id "$TARGET_USER" >/dev/null 2>&1; then
    echo "L'utilisateur '$TARGET_USER' existe déjà ; aucune création nécessaire."
else
    echo "Création de l'utilisateur '$TARGET_USER' avec adduser..."
    if adduser "$TARGET_USER"; then
        echo "Utilisateur '$TARGET_USER' créé avec succès."
    else
        echo "Erreur : impossible de créer '$TARGET_USER'."
        exit 1
    fi
fi

TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
if [[ -z "$TARGET_HOME" || ! -d "$TARGET_HOME" ]]; then
    echo "Erreur : répertoire personnel introuvable pour '$TARGET_USER'."
    exit 1
fi

if [[ -z "$SOURCE_HOME" || ! -d "$SOURCE_HOME" ]]; then
    echo "Erreur : répertoire source introuvable pour '$SOURCE_USER'."
    exit 1
fi

echo "Répertoire source : $SOURCE_HOME"
echo "Répertoire cible : $TARGET_HOME"

if [[ -f "$SOURCE_HOME/.zshrc" ]]; then
    echo "Copie de .zshrc..."
    if cp -p "$SOURCE_HOME/.zshrc" "$TARGET_HOME/.zshrc"; then
        echo "Fichier .zshrc copié."
    else
        echo "Erreur lors de la copie de .zshrc."
        exit 1
    fi
else
    echo "Avertissement : $SOURCE_HOME/.zshrc n'existe pas ; fichier ignoré."
fi

if [[ -d "$SOURCE_HOME/.oh-my-zsh" ]]; then
    echo "Copie du répertoire .oh-my-zsh..."
    if cp -a "$SOURCE_HOME/.oh-my-zsh" "$TARGET_HOME/.oh-my-zsh"; then
        echo "Répertoire .oh-my-zsh copié."
    else
        echo "Erreur lors de la copie de .oh-my-zsh."
        exit 1
    fi
else
    echo "Avertissement : $SOURCE_HOME/.oh-my-zsh n'existe pas ; répertoire ignoré."
fi

echo "Attribution des droits à '$TARGET_USER'..."
if chown -R "$TARGET_USER":"$(id -gn "$TARGET_USER")" "$TARGET_HOME/.zshrc" "$TARGET_HOME/.oh-my-zsh" 2>/dev/null; then
    echo "Droits de propriété mis à jour."
else
    
    for item in "$TARGET_HOME/.zshrc" "$TARGET_HOME/.oh-my-zsh"; do
        if [[ -e "$item" ]]; then
            chown -R "$TARGET_USER":"$(id -gn "$TARGET_USER")" "$item" || exit 1
        fi
    done
    echo "Propriété vérifiée pour les éléments copiés."
fi

echo "Terminé : configuration du shell traitée pour '$TARGET_USER'."