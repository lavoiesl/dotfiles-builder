# 00_PS1_guard.sh
[ -z "$PS1" ] && return

# zsh/01_oh-my-zsh.sh
ZSH='/Users/seb/.oh-my-zsh'
ZSH_THEME='custom'
COMPLETION_WAITING_DOTS="true"
plugins=(
    battery
    bower
    brew
    git
    symfony2
    ssh-agent
    svn
    vagrant
)
zstyle :omz:plugins:ssh-agent agent-forwarding on
source "${ZSH}/oh-my-zsh.sh"

# 10_locale.sh
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# zsh/10_paths.sh
path=(
    "/Users/seb/bin"
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/sbin"
    "/usr/bin"
    "/sbin"
    "/bin"
)

# 20_variables.sh
HOMEBREW_GITHUB_API_TOKEN=INVALID

# 30_grep_aliases.sh
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# 30_scm_breeze.sh
source '/Users/seb/.scm_breeze/scm_breeze.sh'

# 30_ssh_settitle.sh

if [ -n "$TMUX" ]; then
    settitle() {
        printf "\033k$1\033\\"
    }

    ssh() {
        settitle "$(echo $* | head -c 20)"
        command ssh "$@"
        settitle "zsh"
    }
fi

# 30_tmup.sh

if [ -n "$TMUX" ]; then
    tmup ()
    {
        echo -n "Updating to latest tmux environment...";
        export IFS=",";
        for line in $(tmux showenv -t $(tmux display -p "#S") | tr "\n" ",");
        do
            if [[ $line == -* ]]; then
                unset $(echo $line | cut -c2-);
            else
                export $line;
            fi;
        done;
        unset IFS;
        echo "Done"
    }
fi

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
if [ -z "$TMUX" ] && [ -t 1 -o  "$SSH_TTY" = "$(tty)" ]
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
