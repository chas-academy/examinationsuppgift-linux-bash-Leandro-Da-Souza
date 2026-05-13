#!/bin/bash

require_root() {
	local current_user
	current_user=$(id -u)

	if ! [ $current_user = 0 ]; then
		echo "Please run as root"
		exit 1
	fi
}

require_args() {
	if [ "$#" -eq 0 ]; then
		echo "no args provided"
		exit 1
	fi
}

