---
description: Add a new shell alias to the dotfiles builder. Use when the user wants to create a shorthand command, e.g. "add alias gst for git status" or "alias ll to ls -la".
allowed-tools: Write
---

Ask the user:
1. What is the alias name?
2. What command should it run?
3. Should it be conditional on a program existing in PATH?

Then create `aliases/<name>.sh` following the pattern:

Conditional on program:
```sh
#!/bin/bash
program_exists <tool> && echo '<value>'
```

Always active:
```sh
#!/bin/bash
echo '<value>'
```

The filename (without `.sh`) becomes the alias name. The script outputs the alias value, or nothing if the condition isn't met.
