mkdir -p exercice_014 && dpkg -l | grep '^ii' | awk '{print $2}' | grep '^lib' > lib_packages.txt && wc -l < lib_packages.txt > lib_count.txt
