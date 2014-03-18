#!/bin/bash

program_exists php && echo 'find . -name "*.php" -exec php -l "{}" \;'
