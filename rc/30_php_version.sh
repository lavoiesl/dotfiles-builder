#!/bin/bash

if program_exists brew && [ -f "$(brew --prefix php-version)/php-version.sh" ]; then
   echo "source '$(brew --prefix php-version)/php-version.sh' && php-version 5" 
fi
