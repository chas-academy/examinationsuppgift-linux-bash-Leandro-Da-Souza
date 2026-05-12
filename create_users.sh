#/!bin/bash

# tar in guard.sh där vi kollar root och argument
source ./guard.sh

require_root
require_args "$@"

echo "passed guard"
