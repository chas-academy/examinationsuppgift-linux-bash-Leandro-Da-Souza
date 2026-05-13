#!/bin/bash

# ta in guard.sh där vi kollar root och argument
source ./guard.sh
# ta in add_user.sh där vi skapar användare, mappar, filer
source ./add_user.sh

require_root
require_args "$@"

for arg in "$@"; do
	add_user "$arg"
done

