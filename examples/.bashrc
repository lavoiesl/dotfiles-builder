# aliases.sh
alias git-merge-dev="git checkout dev; git branch -D test stage; git pull && git checkout test && git merge dev && git checkout stage && git merge dev && git checkout dev && git push && git branch -D test stage"
alias git-root="cd \"$(git root)\""
alias rrm="rm -Rf"
alias sass-watch="sass --unix-newlines --scss --watch scss:htdocs/css"
alias validate_php_dir="find . -name \"*.php\" -exec php -l \"{}\" \\;"
alias vihosts="sudo vi /etc/hosts"

# bmtools.sh
function cdbm() {
  if [ -n "$1" ]; then
    cd "`bm $1`";
  else
    bm
  fi
}

# brew_completion.sh
. /usr/local/etc/bash_completion

# checkwinsize.sh
shopt -s checkwinsize

# editor.sh
export EDITOR="subl"
export VISUAL="subl"

# grep_aliases.sh
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# java_home.sh
export JAVA_HOME=/Library/Java/Home

# locale.sh
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# ls_aliases.sh
alias ls='ls -FC'
alias l='ls -FC'
alias la='ls -FCa'
alias ll='ls -FCl'
alias lal='ls -FCal'

# paths.sh
export PATH='/usr/local/share/npm/bin:/sbin:/bin:/usr/sbin:/usr/local/bin:/usr/bin:/usr/X11/bin:/usr/texbin:/Users/seb/bin:/usr/local/sbin'

# prompt.sh
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"
. /Users/seb/.zer0prompt
zer0prompt

