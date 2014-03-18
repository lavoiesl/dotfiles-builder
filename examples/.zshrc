# 00_PS1_guard.sh
[ -z "$PS1" ] && return

# zsh/01_oh-my-zsh.sh
ZSH='/Users/seb/.oh-my-zsh'
ZSH_THEME="wedisagree"
COMPLETION_WAITING_DOTS="true"
plugins=(
brew
composer
git
symfony2
ssh-agent
svn
)
zstyle :omz:plugins:ssh-agent agent-forwarding on
source $ZSH/oh-my-zsh.sh

# 10_locale.sh
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# zsh/10_paths.sh
path=(
/usr/local/Cellar/php55/5.5.10/bin
/Users/seb/bin
/usr/local/sbin
/usr/local/bin
/usr/sbin
/usr/bin
/sbin
/bin
/usr/X11/bin
)

# 11_java_home.sh
export JAVA_HOME='/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home'

# 20_variables.sh
export HOMEBREW_GITHUB_API_TOKEN="4986c7904946eb933487f70457caa531edb2906a"
export HOMEBREW_TEMP="/usr/local/tmp"
export EDITOR="subl"

# 30_grep_aliases.sh
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# 30_php_version.sh
source '/usr/local/opt/php-version/php-version.sh' && php-version 5

# zsh/30_prompt.sh
PROMPT='%{$fg[magenta]%}[%~] %{$reset_color%}'

# 30_scm_breeze.sh
source '/Users/seb/.scm_breeze/scm_breeze.sh'

# 50_aliases.sh
alias cacl="find app/logs -name '*.log' -delete && app/console ca:cl --no-warmup"
alias git-root="cd \"\$(git root)\""
alias rrm="rm -Rf"
alias validate_php_dir="find . -name \"*.php\" -exec php -l \"{}\" \\;"
alias vihosts="sudo vi /etc/hosts"

# zsh/90_zsh_options.sh
unsetopt correct
unsetopt correct_all
setopt APPEND_HISTORY
unsetopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# 95_cd.sh
cd

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

