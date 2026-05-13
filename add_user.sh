#!/bin/bash

add_user() {
	# lägg parameter i variabel, gör till lowercase
	local username="${1,,}"

	# regex för att kolla att username inte är helt numeriska.
	if [[ ! "$username" =~ ^[a-z][a-z0-9_-]*$ ]]; then
		echo "Invalid username: $username"
		return 1
	fi

	# kolla om användare redan finns i systemet
	id "$username"

	# spara exit code från funktion ovanför för enkel check
	local user_exists=$?

	if [ "$user_exists" -eq 0 ]; then
		echo "User already exists"
		return 1
	fi

	echo "Creating user: $username"

	# här skapar vi den faktiska användaren och mapparna
	useradd -m -s /bin/bash "$username"

	mkdir "/home/$username/Documents"
	mkdir "/home/$username/Downloads"
	mkdir "/home/$username/Work"

        # Se till att endast användaren har rättigheter
	chmod -R 700 "/home/$username"
	chown -R "$username:$username" "/home/$username"

	# skapa välkomstfil och lägg till välkomsttext
	local welcome_file="/home/$username/welcome.txt"

        echo "Välkommen $username" > "$welcome_file"
	echo "" >> "$welcome_file"
	echo "Andra användare:" >> "$welcome_file"
	echo "" >> "$welcome_file"

        # loopa /etc/passwd efter användare och lägg till i välkomstfilen
        while read line; do
		# kolla användare i /home och att de inte är syslog
		if [[ "$line" == *"/home"* && "$line" != syslog* && "$line" != "$username:"* ]]; then
			# ta bara användarnamnet 
			local username_from_file=$(cut -d: -f1 <<< "$line")
			echo "$username_from_file" >> "$welcome_file"
		fi
	done < /etc/passwd

}
