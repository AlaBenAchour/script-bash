mkdir -p exercice_012
du -sh /var/log 2> /dev/null > exercice_012/disk_usage_report.txt
echo "Analyse du disque: $(cat exercice_012/disk_usage_report.txt)"
