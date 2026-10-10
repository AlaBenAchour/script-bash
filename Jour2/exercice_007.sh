mkdir -p exercice_007/source && echo 'Test' > exercice_007/source/test.txt && tar -cf - exercice_007/source | gzip -k | tee exercice_007/archive.tar.gz > /dev/null
