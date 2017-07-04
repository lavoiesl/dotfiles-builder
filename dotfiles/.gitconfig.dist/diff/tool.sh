#!/bin/bash

if program_exists ksdiff; then
    echo 'Kaleidoscope'
elif program_exists diffmerge; then
    # http://twobitlabs.com/2011/08/install-diffmerge-git-mac-os-x/
    echo 'diffmerge --nosplash'
fi
