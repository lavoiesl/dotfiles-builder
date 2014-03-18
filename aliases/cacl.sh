#!/bin/bash

program_exists php && echo "find app/logs -name '*.log' -delete && app/console ca:cl --no-warmup"
