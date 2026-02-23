# dotfiles-builder

A shell-based dotfiles compilation system that generates optimized shell configuration files (`.zshrc`, `.bashrc`, `.gitconfig`, etc.) by detecting available programs and conditionally including configuration.

## How It Works

The build system runs scripts that **output their value to stdout**. Empty output = feature not applicable. `install.sh` compiles everything into actual dotfiles in `$HOME`.

Key mechanism: scripts are executed or cat'd using `cat_or_exec` — files ending in `.sh` are executed, plain files are cat'd directly.

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| `aliases/` | Shell alias definitions — one `.sh` file per alias, named after the alias |
| `paths/` | `$PATH` entries — numeric prefix determines priority (higher = prepended last = highest precedence) |
| `variables/` | Environment variable definitions — `.sh` file per var, `.d` folder for first-match priority list |
| `rc/` | Shell RC scripts — included in `.zshrc`/`.bashrc`; `rc/zsh/` and `rc/bash/` for shell-specific scripts |
| `dotfiles/` | Files symlinked to home; folders with `_generate.sh` are compiled into a single file |
| `dotfiles/.gitconfig.dist/` | Git config sections — each subdirectory is a `[section]`, files are keys |
| `functions/` | Shell functions (sourced, not executed) |
| `configure/` | One-time setup scripts run by `configure.sh` |
| `variables/` | Environment variables; `.d` folders use first-match priority |
| `examples/` | Example generated output (for reference only, do not edit) |
| `lib.sh` | Core utility functions available during build |

## Core Conventions

### Script Output Pattern
Every `.sh` script **must output its value** to stdout, or output nothing if not applicable:
```sh
#!/bin/bash
if program_exists bun; then
    echo "${HOME}/.bun/bin"
fi
```

### Key `lib.sh` Functions
- `program_exists <name>` — check if a CLI tool is in `$PATH`
- `mac_app_exists <bundle-id>` — check if a macOS app is installed
- `cat_or_exec <file>` — cat plain files, execute `.sh` files
- `escape_chars <string> <chars...>` — escape characters in strings
- `wrap_single_quote <string>` — safely wrap in single quotes

### File Naming
- Files in `paths/` use numeric prefix for ordering: `20_home_bin.sh`, `25_brew.sh`, `26_bun.sh`
- Lower numbers = lower precedence in `$PATH` (they are prepended, so later = higher precedence)
- Files in `rc/` are sorted by filename across all subdirs (common, bash/, zsh/)

### Aliases (`aliases/`)
- File named `foo.sh` → creates alias `foo`
- Script outputs the alias value
- Example: `aliases/g.sh` outputs `git` → generates `alias g="git"`

### Paths (`paths/`)
- Script outputs one or more directory paths
- Paths are tested for existence automatically — no need to check
- Duplicates are removed

### Variables (`variables/`)
- `FOO.sh` → generates `export FOO="<output>"`
- `FOO.d/` folder → iterates scripts in order, uses first non-empty output

### RC Scripts (`rc/`)
- Scripts output shell code to be included in `.zshrc`/`.bashrc`
- Placed in `rc/` for both shells, `rc/zsh/` or `rc/bash/` for shell-specific
- All files sorted by basename across directories (e.g., `rc/zsh/20_paths.sh` sorts with `rc/20_variables.sh`)

### Git Config (`dotfiles/.gitconfig.dist/`)
- Each directory is a `[section]` in gitconfig
- Each file inside is a key (filename = key name, content = value)
- `.sh` files are executed to get the value conditionally
- Subdirectories become `[section "subsection"]`
- `README` files in directories are included as comments

## Common Operations

### Adding a shell alias
Create `aliases/<name>.sh`:
```sh
#!/bin/bash
program_exists <tool> && echo '<command>'
```

### Adding a $PATH entry
Create `paths/<priority>_<name>.sh` (pick priority 20-40):
```sh
#!/bin/bash
if program_exists <tool>; then
    echo "${HOME}/.<tool>/bin"
fi
```

### Adding an RC snippet
Create `rc/<priority>_<name>.sh` (or `rc/zsh/` / `rc/bash/` for shell-specific):
```sh
#!/bin/bash
if program_exists <tool>; then
    echo 'source "${HOME}/.<tool>/init.sh"'
fi
```

### Adding a git alias
Create `dotfiles/.gitconfig.dist/alias/<alias-name>` (plain file) or `<alias-name>.sh` (conditional):
- Plain: just the alias value, e.g., `st` → `status`
- Shell script: outputs the alias value conditionally

### Adding a git config key
Create `dotfiles/.gitconfig.dist/<section>/<key>` or `<key>.sh` for conditional values.

## Testing

After making changes, run `install.sh` to regenerate dotfiles:
```bash
./install.sh           # installs to $HOME
./install.sh /tmp/test # test install to a temp directory
```

Review generated files in the install path, or compare with `examples/` for expected output.

## Git Commit Style

Short, descriptive commits. Typically:
- `paths/26_bun.sh` — adding a path file
- `Add delta support` — adding a feature
- `Fix remote-default-branch` — fixing something
- `git sw` — adding a git alias
- No conventional commit format required

## Slash Commands

Project-level slash commands are defined in `.claude/commands/`:
- `/add-alias` — add a shell alias
- `/add-path` — add a `$PATH` entry
- `/add-rc` — add an RC snippet (both shells, zsh-only, or bash-only)
- `/add-git-alias` — add a git alias to `.gitconfig.dist`
