#!/bin/bash

program_exists diffmerge && echo 'diffmerge --nosplash "$LOCAL" "$REMOTE"'
