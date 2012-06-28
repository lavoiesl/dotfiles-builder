# 00_PS1_guard.sh
[ -z "$PS1" ] && return

# 10_locale.sh
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# 10_paths.sh
export PATH='/usr/local/share/npm/bin:/sbin:/bin:/usr/sbin:/usr/local/bin:/usr/bin:/usr/X11/bin:/usr/texbin:/Users/seb/bin:/usr/local/sbin'

# 11_java_home.sh
export JAVA_HOME='/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home'

# 20_brew_completion.sh
. /usr/local/etc/bash_completion

# 30_checkwinsize.sh
shopt -s checkwinsize

# 30_grep_aliases.sh
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# 30_ls_aliases.sh
alias ls='ls -FC'
alias l='ls -FC'
alias la='ls -FCa'
alias ll='ls -FCl'
alias lal='ls -FCal'

# 30_prompt.sh
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"
. /Users/seb/.zer0prompt
zer0prompt

# 50_aliases.sh
alias git-merge-dev="git checkout dev; git branch -D test stage; git pull && git checkout test && git merge dev && git checkout stage && git merge dev && git checkout dev && git push && git branch -D test stage"
alias git-root="cd \"$(git root)\""
alias rrm="rm -Rf"
alias sass-watch="sass --unix-newlines --scss --watch scss:htdocs/css"
alias validate_php_dir="find . -name \"*.php\" -exec php -l \"{}\" \\;"
alias vihosts="sudo vi /etc/hosts"

# 50_bmtools.sh
function cdbm() {
  if [ -n "$1" ]; then
    cd "`bm $1`";
  else
    bm
  fi
}

# 50_editor.sh
export EDITOR="subl"
export VISUAL="subl"

# 99_tmux.sh
if [ -z "$TMUX" ] && [ "$TERM" = "linux" -o "$TERM" = "rxvt-unicode" -o "$TERM" = "xterm-color" -o "$TERM" = "xterm-256color" -o "$TERM" = "xterm" -o  "$SSH_TTY" = "$(tty)" ]
then
  if ! tmux has-session -t main
  then
    tmux start-server
    tmux new-session -d -s main
  fi
  tmux attach-session -t main

  if [ -f ~/.no-screen ]
  then
    rm ~/.no-screen
  else
    exit
  fi
fi

