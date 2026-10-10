USER_NAME="$1" 
who | grep "^$USER_NAME " 
last "$USER_NAME" | head -n 5
