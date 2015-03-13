#!/bin/bash

if program_exists brew; then
    ensure_config_var HOMEBREW_GITHUB_API_TOKEN "Homebrew GitHub token, including public_repo permission (https://github.com/settings/tokens/new):"
fi
