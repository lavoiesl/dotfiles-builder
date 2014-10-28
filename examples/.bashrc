# 00_PS1_guard.sh
[ -z "$PS1" ] && return

# 10_locale.sh
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# bash/10_paths.sh
export PATH='/usr/local/Cellar/php55/5.5.10/bin:/Users/seb/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11/bin'

# 11_java_home.sh
export JAVA_HOME='/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home'

# bash/20_brew_completion.sh
. /usr/local/etc/bash_completion

# 20_variables.sh
export HOMEBREW_GITHUB_API_TOKEN="4986c7904946eb933487f70457caa531edb2906a"
export HOMEBREW_TEMP="/usr/local/tmp"
export EDITOR="subl"

# 30_grep_aliases.sh
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# bash/30_ls_aliases.sh
alias ls='ls -FC'
alias l='ls -FC'
alias la='ls -FCa'
alias ll='ls -FCl'
alias lal='ls -FCal'

# bash/30_prompt.sh
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"
. /Users/seb/.zer0prompt.sh
zer0prompt

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
        settitle "bash"
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
