# Dotfiles Builder

Compiles `.zshrc` and `.bashrc` using configurations and doing some tests only once.

For example:

  * Concatenate some paths in $PATH only if directory exists and is not already in $PATH
  * Add aliases using easy file structure with auto-escaping
  * Determine best locale based on available locales
  * Determine best $EDITOR/$VISUAL
  * etc.

The goal is to optimize files like `.bashrc` and `.gitconfig` to only include what works for this specific computer.

Expensive checks can be done like looping through a lot of choices or even doing a `locate my-program`
because the `.bashrc` is compiled once, not everytime you start a new shell.

Functions in [lib.sh](lib.sh) are always available.

## Usage

```bash
./install.sh # installs it in your home
./install.sh /tmp/whatever # installs it in another folder
```

See [examples/](examples/) for a list of generated files.

If you modify your installation or your settings, re-run the build script.

## Configuration

A folder will be created in `$DOTFILES_INSTALL_PATH/.dotfiles-config`

### Variables

`~/.dotfiles-config/vars` override calculated variables

  * Filename must be the variable’s name
  * Content must be the variable’s value
  * Custom variables also supported

### SSH

  Parsed from `$HOME`.

## Documentation

### [`rc`](bashrc / zshrc)

All the main scripts are here, for zsh and bash, it will also include the file in the appropriate folder

  * Each script must output its part.
  * A comment will be added before each part saying which script it is from.
  * Files are sorted as if they were all in the same directory.

### [`aliases`](aliases)

  * Each script must output the value of the alias.
  * Each script must be named as the name of the alias and end with `.sh`.

### [`paths`](paths)

  * Each script must output the value of the path.
  * Each outputted path will be tested for existence, no need to do it.
  * Files with the highest number will be prepended last so it will have the highest precedence.
  * The current `$PATH` will be appended (but will be removed if not existent).
  * Duplicates will be removed.
  * You can add custom generators in `$DOTFILES_INSTALL_PATH/.dotfiles-config/paths`.

### [`variables`](variables)

  * Generates a `export VAR="value"` for each variable.
  * Each script must output the value of the variable.
  * Files in `variables` must be named as the name of the variable and end with `.sh`.
  * Folders in `variables` must be named as the name of the variable and end with `.d`. For folders, the first script to output something will be kept.

### [`configure`](configure)

  * Scripts that are ran when using `./configure.sh`
  * Will create configuration files in `$DOTFILES_INSTALL_PATH/.dotfiles-config`.

### [`dotfiles`](dotfiles)

  * Each file will be copied to the destination.
  * Folders must have a `_generate.sh`, it will the executed and its output will be used to generate a file named like the folder.

## Todo

  * Add config files
    * Editor preferences
    * Name, email, etc.
    * $PS1
    * Multiplexer
  * Remove dependency to `ruby` for `realpath`
  * Investigate more common practices for dotfiles
    * Investigate https://github.com/mathiasbynens/dotfiles
  * Add documentation for configuration options

## Author
Sébastien Lavoie (github@lavoie.sl)

