LOG_FILE="menu.log"


log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}


run_script() {
    script="$1"
    shift

    if [ -f "$script" ]; then
        echo "Lancement de $script..."
        log "INFO : lancement de $script"

        if bash "$script" "$@"; then
            echo "Operation terminee avec succes."
            log "INFO : $script termine avec succes"
        else
            echo "Erreur lors de l'execution de $script."
            log "ERREUR : echec de $script"
        fi
    else
        echo "Erreur : le script $script est introuvable."
        log "ERREUR : script introuvable : $script"
    fi
}


installation() {
    echo "Installation et configuration"
    read -r -p "Nom du script a lancer (install_config.sh) : " script
    if [ -z "$script" ]; then
        script="install_config.sh"
    fi
    log "INFO : demande d'installation/configuration"
    run_script "$script"
}


sauvegarde() {
    echo "Sauvegarde des fichiers"
    read -r -p "Nom du script de sauvegarde (backup.sh) : " script
    if [ -z "$script" ]; then
        script="backup.sh"
    fi
    log "INFO : demande de sauvegarde"
    run_script "$script"
}


mise_a_jour() {
    echo "Mise a jour du systeme ou de l'application"
    read -r -p "Nom du script de mise a jour (update.sh) : " script
    if [ -z "$script" ]; then
        script="update.sh"
    fi
    log "INFO : demande de mise a jour"
    run_script "$script"
}


compter_lignes() {
    echo "Comptage des lignes du body HTTP"
    read -r -p "URL : " url
    if [ -z "$url" ]; then
        echo "Erreur : URL obligatoire."
        log "ERREUR : URL absente pour le comptage"
        return
    fi
    log "INFO : comptage des lignes pour $url"
    run_script "compte_lignes.sh" "$url"
}


tester_status() {
    echo "Test du code HTTP"
    read -r -p "URL : " url
    if [ -z "$url" ]; then
        echo "Erreur : URL obligatoire."
        log "ERREUR : URL absente pour le test HTTP"
        return
    fi
    log "INFO : test du status HTTP pour $url"
    run_script "check_status.sh" "$url"
}


tester_content_type() {
    echo "Verification du Content-Type"
    read -r -p "URL : " url
    if [ -z "$url" ]; then
        echo "Erreur : URL obligatoire."
        log "ERREUR : URL absente pour Content-Type"
        return
    fi
    log "INFO : verification Content-Type pour $url"
    run_script "check_content_type.sh" "$url"
}


tester_ressources() {
    echo "Verification des ressources du site"
    read -r -p "URL du site : " url
    read -r -p "Fichier des ressources [resource_list.txt] : " fichier
    if [ -z "$fichier" ]; then
        fichier="resource_list.txt"
    fi
    if [ -z "$url" ] || [ ! -f "$fichier" ]; then
        echo "Erreur : URL absente ou fichier introuvable."
        log "ERREUR : parametres invalides pour les ressources"
        return
    fi
    log "INFO : verification des ressources de $url avec $fichier"
    run_script "scrape_status.sh" "$url" "$fichier"
}


afficher_menu() {
    echo
    echo "========== MENU PRINCIPAL =========="
    echo "1. Installation / configuration"
    echo "2. Sauvegarde"
    echo "3. Mise a jour"
    echo "4. Compter les lignes d'une page web"
    echo "5. Tester le code HTTP"
    echo "6. Afficher le Content-Type"
    echo "7. Tester les ressources d'un site"
    echo "8. Consulter les logs"
    echo "0. Quitter"
    echo "===================================="
}


while true; do
    afficher_menu
    read -r -p "Votre choix : " choix

    case "$choix" in
        1) installation ;;
        2) sauvegarde ;;
        3) mise_a_jour ;;
        4) compter_lignes ;;
        5) tester_status ;;
        6) tester_content_type ;;
        7) tester_ressources ;;
        8)
            if [ -f "$LOG_FILE" ]; then
                cat "$LOG_FILE"
            else
                echo "Aucun fichier de log disponible."
            fi
            ;;
        0)
            echo "Fermeture du menu."
            log "INFO : fermeture du menu"
            break
            ;;
        *)
            echo "Choix invalide. Veuillez recommencer."
            log "ERREUR : choix invalide : $choix"
            ;;
    esac
done