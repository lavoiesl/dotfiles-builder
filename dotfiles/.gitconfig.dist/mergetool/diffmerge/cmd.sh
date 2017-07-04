#!/bin/bash

program_exists diffmerge && echo 'diffmerge --nosplash --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
