mkdir -p exercice_011

tail -n +2 data.csv | cut -d',' -f1 | tee exercice_011/col1.txt > /dev/null

tail -n +2 data.csv | cut -d',' -f2 | sed 's/.*/\U&/' | tee exercice_011/col2.txt > /dev/null

tail -n +2 data.csv | sed 's/,/ habite à /' | tee exercice_011/summary.txt > /dev/null
