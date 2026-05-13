#!/bin/bash

# ta in guard.sh där vi kollar root och argument
source ./guard.sh
# ta in add_user.sh där vi skapar användare och mappar
source ./add_user.sh
# ta in create_welcome_file där vi skapar välkomst
source ./create_welcome_file.sh

require_root
require_args "$@"

for arg in "$@"; do
	add_user "$arg"
done

# separat loop för att se till att alla användare har skapat 
for arg in "$@"; do
	create_welcome_file "$arg"
done

