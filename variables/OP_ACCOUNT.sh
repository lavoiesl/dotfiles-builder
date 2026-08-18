#!/bin/bash

# Default 1Password account for the `op` CLI.
# With multiple accounts, `op` otherwise falls back to whichever account was
# last signed into in any terminal, which is non-deterministic across shells.
# Value can be the sign-in address (e.g. my.1password.com) or account shorthand.
if program_exists op; then
    ensure_config_var "OP_ACCOUNT" "1Password default account (sign-in address, e.g. my.1password.com)"
    get_config_var "OP_ACCOUNT"
fi
