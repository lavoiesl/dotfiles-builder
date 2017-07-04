#!/bin/bash

program_exists ksdiff && echo 'ksdiff --partial-changeset --relative-path "$MERGED" -- "$LOCAL" "$REMOTE"'
