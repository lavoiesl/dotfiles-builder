---
description: Add a new shell RC snippet to the dotfiles builder. Use when the user wants to add initialization code for a tool to their shell startup, e.g. "add nvm init to zshrc", "source rustup env in shell", or "add completions for kubectl".
allowed-tools: Write
---

Ask the user:
1. What tool or feature is this for?
2. Which shell(s)? (both / zsh-only / bash-only)
3. What priority number (00–95)? Controls load order within the RC file.

Create the file in the appropriate location:
- `rc/<priority>_<name>.sh` — included in both bash and zsh
- `rc/zsh/<priority>_<name>.sh` — zsh only
- `rc/bash/<priority>_<name>.sh` — bash only

The script must **output** the shell code (via `echo`), not execute it directly. Empty output means the snippet is skipped.

Example — sourcing a tool's init script conditionally:
```sh
#!/bin/bash
env_script="${HOME}/.sometool/init.sh"
if [ -f "$env_script" ]; then
    echo "source \"$env_script\""
fi
```

Priority reference:
- 00: guards (PS1 check)
- 05: tmux
- 10: locale
- 20: variables, paths
- 30: tool configs (dircolors, grep aliases, rvm, rust)
- 50: aliases, functions, tool integrations
- 80: oh-my-zsh
- 85: plugins (1password, zoxide)
- 90: zsh options
- 95: cd overrides
