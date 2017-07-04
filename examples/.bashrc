#!/usr/bin/env bash

# 00_PS1_guard.sh
[ -z "$PS1" ] && return

# 05_tmux.sh

export ZSH_TMUX_AUTOSTART=true
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

# 10_locale.sh
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LESSCHARSET='UTF-8'

# bash/10_paths.sh
export PATH='/Users/seb/bin:/usr/X11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

# bash/20_brew_completion.sh
. /usr/local/etc/bash_completion

# 20_variables.sh
export EDITOR=subl
export HOMEBREW_GITHUB_API_TOKEN=INVALID
export HOMEBREW_TEMP=/usr/local/tmp
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home

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
export CLICOLOR='1'
export LSCOLORS='exfxcxdxbxegedabagacad'
. /Users/seb/.zer0prompt.sh
zer0prompt

# 30_rvm.sh
source "/Users/seb/.rvm/scripts/rvm"

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

# 50_aliases.sh
alias cacl="find app/logs -name '*.log' -delete && app/console ca:cl --no-warmup"
alias g="git"
alias git-root="cd \"\$(git root)\""
alias rrm="rm -Rf"
alias vihosts="sudo vi /etc/hosts"

# 95_cd.sh
cd
