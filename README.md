# Dotfiles Builder

## Author
Sébastien Lavoie (github@lavoie.sl)

## Description
Compiles `.zshrc` and `.bashrc` using configurations and doing some tests only once.

For example:

  * Concatenate some paths in $PATH only if directory exists and is not already in $PATH
  * Add aliases using easy file structure with auto-escaping
  * Determine best locale based on available locales
  * Determine best $EDITOR/$VISUAL
  * etc.

The goal is to optimize `.bashrc` to only include what works. 

Expensive checks can be done like looping through a lot of choices of even doing a `locate my-program`
because the `.bashrc` is compiled once, not everytime you start a new shell.

If your current shell is zsh, it will generate a `.zshrc`

## Configuration

### `rc`

All the main script are here, for zsh and bash, it will also include the file in the appropriate folder

  * Each script must output its part
  * Files are sorted as if they were all in the same directory.
  * Functions in [lib.sh](lib.sh) are always available.

### `aliases`

  * Each script must output the value of the alias
  * Each script must be named as the name of the alias and end with `.sh`
  * Functions in [lib.sh](lib.sh) are always available.

### `paths`

  * Each script must output the value of the path
  * Each outputted path will be tested for existence, no need to do it
  * Functions in [lib.sh](lib.sh) are always available.
  * Files with the highest number will be prepended last so it will have the highest precedence.
  * The current `$PATH` will be appended (but will be removed if not existent).
  * Duplicates will be removed.

### variables

  * Generates a `export VAR="value"` for each variable.
  * Each script must output the value of the variable.
  * Files in `variables` must be named as the name of the variable and end with `.sh`.
  * Folders in `variables` must be named as the name of the variable and end with `.d`. For folders, the first script to output something will be kept.

## Usage

Current shell is detected and 

```bash
skeleton.sh dump # shows the .bashrc that it would generate
skeleton.sh install # installs it
```

See [examples/.bashrc](examples/.bashrc) and [examples/.zshrc](examples/.zshrc)

If you modify your installation of your settings, re-run the build script

## Todo

  * Add config files
    * Editor preferences
    * Name, email, etc.
    * $PS1
    * Multiplexer
  * Better multi-platform support
  * Replace dependency to `bash` with `sh`
  * Remove dependency to `ruby` for `realpath`
  * Investigate more common practices for dotfiles
  * Add support for more dotfiles
  * Add commands to `skeleton.sh`: `install`, `dump`, `validate`, etc.
  * Completing this todo
