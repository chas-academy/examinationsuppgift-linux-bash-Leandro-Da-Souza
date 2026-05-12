#!/bin/bash

add_user() {
	# lägg parameter i variabel, gör till lowercase
	local username="${1,,}"

	# regex för att kolla att username inte är helt numeriska.
	if [[ ! "$username" =~ ^[a-z][a-z0-9_-]*$ ]]; then
		echo "Invalid username: $username"
		return 1
	fi

	echo "Creating user: $username"
}
