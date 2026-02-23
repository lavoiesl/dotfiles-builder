---
description: Add a new git alias to .gitconfig.dist. Use when the user wants a new git shorthand command, e.g. "add git alias sw for switch", "git alias to open PR", or "git alias for log --oneline".
allowed-tools: Write Glob Read
---

Ask the user:
1. What is the alias name?
2. What git command or shell command should it run?
3. Is it conditional on a program existing in PATH?

Create a file at `dotfiles/.gitconfig.dist/alias/<alias-name>`:

Plain file (always included) — contains just the alias value:
```
status
```

Shell script (conditional, file named `<alias-name>.sh`):
```sh
#!/bin/sh
if program_exists <tool>; then
    echo '<alias value>'
fi
```

For shell commands (not git subcommands), prefix the value with `!`:
```
!sh -c "gh pr view --web || gh pr create --web"
```

For conditional shell commands:
```sh
#!/bin/sh
program_exists gh && echo '!sh -c "gh pr view --web || gh pr create --web"'
```
