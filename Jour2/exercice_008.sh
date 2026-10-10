mkdir -p exercice_008 && echo "Date: $(date);Host: $(hostname);Uptime: $(uptime)" | sed 's/;/\n/g' | tee exercice_008/system_report.txt
