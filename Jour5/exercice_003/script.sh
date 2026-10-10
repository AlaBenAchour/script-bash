OUTPUT_FILE="config_reseau.txt"
IP_COMMAND="ip"
ADDR_OPTION="addr"
ROUTE_OPTION="route"


INTERFACES=$("$IP_COMMAND" -brief "$ADDR_OPTION")
ROUTING=$("$IP_COMMAND" "$ROUTE_OPTION")


{
    echo "Interfaces :"
    echo "$INTERFACES"
    echo "Routage :"
    echo "$ROUTING"
} > "$OUTPUT_FILE"