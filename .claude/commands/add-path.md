---
description: Add a new $PATH entry to the dotfiles builder. Use when the user wants to add a tool's bin directory to their shell PATH, e.g. "add bun to path" or "add ~/.cargo/bin to path".
allowed-tools: Write
---

Ask the user:
1. What tool or directory should be added to $PATH?
2. What priority number (20–40)? Higher numbers are prepended last and have highest precedence.

Then create `paths/<priority>_<name>.sh`. Paths are automatically tested for existence — no need to check in the script.

Conditional on program existing:
```sh
#!/bin/bash
if program_exists <tool>; then
    echo "${HOME}/.<tool>/bin"
fi
```

Always (existence checked automatically):
```sh
#!/bin/bash
echo "${HOME}/.local/bin"
```

Existing priorities for reference:
- 20: home bin
- 21: ~/.local/bin
- 25: homebrew
- 26: bun
- 30: ruby, rvm, npm, amazon ec2
- 40: games, x11
