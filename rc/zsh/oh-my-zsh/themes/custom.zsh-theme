# On a mac with snow leopard, for nicer terminal colours:

# - Install SIMBL: http://www.culater.net/software/SIMBL/SIMBL.php
# - Download'Terminal-Colours': http://bwaht.net/code/TerminalColours.bundle.zip
# - Place that bundle in ~/Library/Application\ Support/SIMBL/Plugins (create that folder if it doesn't exist)
# - Open Terminal preferences. Go to Settings -> Text -> More
# - Change default colours to your liking.
#

# RPROMPT='${time} %{$fg[magenta]%}$(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}$(git_prompt_ahead)%{$reset_color%}'
# RPROMPT='${time}%{$reset_color%}'

# Add this at the start of RPROMPT to include rvm info showing ruby-version@gemset-name
# %{$fg[yellow]%}$(~/.rvm/bin/rvm-prompt)%{$reset_color%}

# oh-my-zsh Bureau Theme

# "%F{magenta}[${${PWD/#%$HOME/~}/#$HOME\//~/}] %f"

ZSH_THEME_BRACKET_LEFT="["
ZSH_THEME_BRACKET_RIGHT="]"

ZSH_THEME_PATH="%{$fg[magenta]%}${ZSH_THEME_BRACKET_LEFT}%~${ZSH_THEME_BRACKET_RIGHT}%{$reset_color%}"

# local time, color coded by last return code
# ZSH_THEME_TIME="%(?.%{$fg[cyan]%}.%{$fg[red]%})${ZSH_THEME_BRACKET_LEFT}%*${ZSH_THEME_BRACKET_RIGHT}%{$reset_color%}"
ZSH_THEME_TIME="%{$fg[yellow]%}${ZSH_THEME_BRACKET_LEFT}%*${ZSH_THEME_BRACKET_RIGHT}%{$reset_color%}"

ZSH_THEME_EXIT_CODE="%(?..%{$fg[red]%}${ZSH_THEME_BRACKET_LEFT}%?${ZSH_THEME_BRACKET_RIGHT}%{$reset_color%} )"


if [ -n "$(battery_pct_prompt)" ]; then
  ZSH_THEME_BATTERY=" \$(battery_pct_prompt)%{\$reset_color%}"
fi

### NVM

# ZSH_THEME_NVM_PROMPT_PREFIX="%B⬡%b "
# ZSH_THEME_NVM_PROMPT_SUFFIX=""

### Git

ZSH_THEME_GIT_PROMPT_PREFIX="${ZSH_THEME_BRACKET_LEFT}%{$fg_bold[green]%}➦ %{$reset_color%}%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}${ZSH_THEME_BRACKET_RIGHT}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

custom_git_branch () {
  if [ "$(command git config --bool --get zsh-prompt.branch)" != "false" ]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "${ref#refs/heads/}"
  fi
}

custom_git_status() {
  _STATUS=""

  if [[ "$(command git config --bool --get zsh-prompt.status)" != "false" ]]; then
    # git config zsh-prompt.status-options "--ignore-submodules -uno"
    local git_options="$(command git config --get zsh-prompt.status-options)"
    _INDEX="$(command git status ${git_options} --porcelain 2> /dev/null)"

    # check status of files
    if [[ -n "${_INDEX}" ]]; then
      if $(echo "${_INDEX}" | command grep -q '^[AMRD]. '); then
        _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_STAGED}"
      fi
      if $(echo "${_INDEX}" | command grep -q '^.[MTD] '); then
        _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_UNSTAGED}"
      fi
      if $(echo "${_INDEX}" | command grep -q -E '^\?\? '); then
        _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_UNTRACKED}"
      fi
      if $(echo "${_INDEX}" | command grep -q '^UU '); then
        _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_UNMERGED}"
      fi
    else
      _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_CLEAN}"
    fi
  
    # check status of local repository
    if $(echo "${_INDEX}" | command grep -q '^## .*ahead'); then
      _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_AHEAD}"
    fi
    if $(echo "${_INDEX}" | command grep -q '^## .*behind'); then
      _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_BEHIND}"
    fi
    if $(echo "${_INDEX}" | command grep -q '^## .*diverged'); then
      _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_DIVERGED}"
    fi
  
    if $(command git rev-parse --verify refs/stash &> /dev/null); then
      _STATUS="${_STATUS}${ZSH_THEME_GIT_PROMPT_STASHED}"
    fi
  fi

  echo "${_STATUS}"
}

custom_git_prompt () {
  local _branch=$(custom_git_branch)
  local _status=$(custom_git_status)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="${ZSH_THEME_GIT_PROMPT_PREFIX}${_branch}"
    if [[ "${_status}x" != "x" ]]; then
      _result="${_result} ${_status}"
    fi
    _result="${_result}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
  fi
  # Pad
  if [[ "${_result}" != "" ]]; then
    _result="${_result} "
  fi
  echo "${_result}"
}

if [[ $EUID -eq 0 ]]; then
  _USERNAME="%{$fg_bold[red]%}%n"
  _ANCHOR="%{$fg[red]%}#"
else
  _USERNAME="%{$fg_bold[white]%}%n"
  _ANCHOR="%{$fg[green]%}$"
fi
_USERNAME="${ZSH_THEME_BRACKET_LEFT}$_USERNAME%{$reset_color%}@%m${ZSH_THEME_BRACKET_RIGHT} "
_ANCHOR="$_ANCHOR%{$reset_color%}"

get_space () {
  # Use awk because macOS has BSD sed.
  # Use wc -m because macOS awk doesn't support multi-byte
  local LENGTH="$(echo -n "$1$2" | awk '{gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/,""); print}' | wc -m)"
  local SPACES=""
  (( LENGTH = ${COLUMNS} - $LENGTH ))

  for i in {0..$LENGTH}
    do
      SPACES="$SPACES "
    done

  echo $SPACES
}

zsh_command_time() {
  # Nothing, we print our own in the theme bar
}

custom_command_time() {
  if [ -n "$ZSH_COMMAND_TIME" ]; then
    min=$(($ZSH_COMMAND_TIME/60))
    sec=$(($ZSH_COMMAND_TIME%60))
    if [ "$ZSH_COMMAND_TIME" -le 60 ]; then
      color="green"
    elif [ "$ZSH_COMMAND_TIME" -gt 60 ] && [ "$ZSH_COMMAND_TIME" -le 180 ]; then
      color="yellow"
    else
      color="red"
    fi

    printf "$fg[$color]<%d:%02d> " $min $sec
  fi
}

# _USERNAME not used
# \$(nvm_prompt_info) not used
_1LEFT="╭─${ZSH_THEME_PATH}"
_1RIGHT="\$(custom_git_prompt)\$(custom_command_time)${ZSH_THEME_TIME}${ZSH_THEME_BATTERY}"


custom_precmd () {
  # Do "right" before because it checks the last exit code
  local right_eval="$(print -rP ${_1RIGHT})"
  local left_eval="$(print -rP ${_1LEFT})"

  local spaces="$(get_space "${left_eval}" "${right_eval}")"
  echo "${left_eval}${spaces}${right_eval}"
}

setopt prompt_subst
PROMPT='╰─${ZSH_THEME_EXIT_CODE}${_ANCHOR} '

autoload -U add-zsh-hook
add-zsh-hook precmd custom_precmd

