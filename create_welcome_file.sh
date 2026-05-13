#!/bin/bash

# skapa välkomst fil och lägg till välkomst text
create_welcome_file() {
	# skapa variabler frpn input
	local username=${1,,}
        local welcome_file="/home/$username/welcome.txt"

        echo "Välkommen $username" > "$welcome_file"
        echo "" >> "$welcome_file"
        echo "Andra användare:" >> "$welcome_file"
        echo "" >> "$welcome_file"

	# loopa /etc/passwd efter användare och lägg till i välkomstfilen
        while read line; do
                # kolla användare i /home och att de inte är syslog
                if [[ "$line" == *"/home"* && "$line" != syslog* ]]; then
                        # ta bara användarnamnet
                        local username_from_file=$(cut -d: -f1 <<< "$line")
                        echo "$username_from_file" >> "$welcome_file"
                fi
        done < /etc/passwd
}
