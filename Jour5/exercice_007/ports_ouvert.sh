OUTPUT_FILE="liste_des_ports.txt" 
netstat -pntlu | tee "$OUTPUT_FILE"