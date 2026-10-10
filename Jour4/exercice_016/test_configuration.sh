
LOG="tests_environnement.log"
ERREURS=0

echo "$(date): Début des tests" >> "$LOG"


tester() {
    if "$@" >> "$LOG" 2>&1; then
        echo "[OK] $1"
        echo "$(date): OK - $1" >> "$LOG"
    else
        echo "[ÉCHEC] $1"
        echo "$(date): ÉCHEC - $1" >> "$LOG"
        ERREURS=$((ERREURS + 1))
    fi
}


if command -v zsh >/dev/null 2>&1; then
    echo "[OK] Zsh est installé : $(zsh --version)"
    echo "$(date): OK - Zsh installé" >> "$LOG"
else
    echo "[ÉCHEC] Zsh n'est pas installé."
    echo "$(date): ÉCHEC - Zsh absent" >> "$LOG"
    ERREURS=$((ERREURS + 1))
fi


if command -v zsh >/dev/null 2>&1; then
    tester zsh -c 'echo "Zsh fonctionne correctement"'
fi


if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "[OK] Oh My Zsh est installé."
    echo "$(date): OK - Répertoire Oh My Zsh présent" >> "$LOG"
else
    echo "[ÉCHEC] Oh My Zsh est introuvable."
    echo "$(date): ÉCHEC - Oh My Zsh absent" >> "$LOG"
    ERREURS=$((ERREURS + 1))
fi


if [ -f "$HOME/.zshrc" ]; then
    echo "[OK] Le fichier .zshrc existe."
    echo "$(date): OK - .zshrc présent" >> "$LOG"
else
    echo "[ÉCHEC] Le fichier .zshrc est absent."
    echo "$(date): ÉCHEC - .zshrc absent" >> "$LOG"
    ERREURS=$((ERREURS + 1))
fi


if command -v git >/dev/null 2>&1; then
    echo "[OK] Git est installé : $(git --version)"
    echo "$(date): OK - Git installé" >> "$LOG"
else
    echo "[ÉCHEC] Git n'est pas installé."
    echo "$(date): ÉCHEC - Git absent" >> "$LOG"
    ERREURS=$((ERREURS + 1))
fi


if command -v git >/dev/null 2>&1; then
    if git var GIT_AUTHOR_IDENT >/dev/null 2>&1; then
        echo "[OK] Identité Git configurée."
        echo "$(date): OK - Identité Git valide" >> "$LOG"
    else
        echo "[ÉCHEC] Identité Git non configurée."
        echo "$(date): ÉCHEC - Configurer user.name et user.email" >> "$LOG"
        ERREURS=$((ERREURS + 1))
    fi
fi


if command -v git >/dev/null 2>&1; then
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "[OK] Le répertoire courant est un dépôt Git."
        echo "$(date): OK - Dépôt Git détecté" >> "$LOG"
    else
        echo "[INFO] Le répertoire courant n'est pas un dépôt Git."
        echo "$(date): INFO - Aucun dépôt Git dans le répertoire courant" >> "$LOG"
    fi
fi


if [ "$ERREURS" -eq 0 ]; then
    echo "Résultat : tous les tests obligatoires ont réussi."
    echo "$(date): BILAN - Aucun échec" >> "$LOG"
else
    echo "Résultat : $ERREURS test(s) en échec."
    echo "$(date): BILAN - $ERREURS échec(s)" >> "$LOG"
fi

echo "Journal complet : $LOG"
echo "$(date): Fin des tests" >> "$LOG"


if [ "$ERREURS" -gt 0 ]; then
    exit 1
fi
exit 0
