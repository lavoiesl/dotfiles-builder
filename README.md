# Dotfiles Builder

Compiles `.zshrc` and `.bashrc` using configurations and doing some tests only once.

For example:

  * Concatenate some paths in $PATH only if directory exists and is not already in $PATH
  * Add aliases using easy file structure with auto-escaping
  * Determine best locale based on available locales
  * Determine best $EDITOR/$VISUAL
  * etc.

The goal is to optimize `.bashrc` to only include what works for this specific computer.

Expensive checks can be done like looping through a lot of choices or even doing a `locate my-program`
because the `.bashrc` is compiled once, not everytime you start a new shell.

If your current shell is zsh, it will generate a `.zshrc`

## Configuration

Functions in [lib.sh](lib.sh) are always available.

### [`rc`](rc)

All the main script are here, for zsh and bash, it will also include the file in the appropriate folder

  * Each script must output its part.
  * A comment will be added before each part saying which script it is from.
  * Files are sorted as if they were all in the same directory.

### `aliases`

  * Each script must output the value of the alias.
  * Each script must be named as the name of the alias and end with `.sh`.

### `paths`

  * Each script must output the value of the path.
  * Each outputted path will be tested for existence, no need to do it.
  * Files with the highest number will be prepended last so it will have the highest precedence.
  * The current `$PATH` will be appended (but will be removed if not existent).
  * Duplicates will be removed.

### `variables`

  * Generates a `export VAR="value"` for each variable.
  * Each script must output the value of the variable.
  * Files in `variables` must be named as the name of the variable and end with `.sh`.
  * Folders in `variables` must be named as the name of the variable and end with `.d`. For folders, the first script to output something will be kept.

## Usage

Current shell is detected.

```bash
skeleton.sh dump # shows the .bashrc that it would generate
skeleton.sh install # installs it in your home
```

See [examples/.bashrc](examples/.bashrc) and [examples/.zshrc](examples/.zshrc)

If you modify your installation of your settings, re-run the build script

## Todo

  * Add config files
    * Editor preferences
    * Name, email, etc.
    * $PS1
    * Multiplexer
  * Remove dependency to `ruby` for `realpath`
  * Investigate more common practices for dotfiles
  * Add support for more dotfiles
  * Completing this todo

## Author
Sébastien Lavoie (github@lavoie.sl)

