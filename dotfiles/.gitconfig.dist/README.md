# .gitconfig

 * Folders represent sections.
 * Subfolder represent subsections (difftool/diffmerge/cmd.sh) will generate [difftool "diffmerge"] cmd = "VALUE".
 * Filenames represent the config name, the content is the config value.
   Files ending with `.sh` will be executed and the output will be used.
 * Empty sections will not be included.
 * Folders ending with `.d` will have the suffix stripped.
   This is to allow subsections having the same name as configs in parent section.
