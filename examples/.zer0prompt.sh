#!/bin/bash

############################ [MAIN CODE] ############################
# DO NOT alter below this line unless you know what you are doing!
# user configuration options are found in zer0prompt.conf

# grab user config files via import
source ~/.zer0prompt.conf

# use bash builtin checkwinsize option for terminals which fail to properly
# set the $COLUMNS variable. (bug workaround)
shopt -s checkwinsize

# set line graphics to use based on locale
if [ "$zgfx_override" = "1" ]; then
  zg1="-"; zg2="r"; zg3="L"; zg4="|"; zg5="|"; zg6=">" # fallback GFX (forced)
elif [ $(locale charmap) = "UTF-8" ]; then
  zg1="─"; zg2="┌"; zg3="└"; zg4="┤"; zg5="├"; zg6=">" # better GFX
else
  zg1="-"; zg2="r"; zg3="L"; zg4="|"; zg5="|"; zg6=">" # fallback GFX
fi

# set inverse mode if set
if [ "$zpcl_inverse" = "1" ]; then
  zci="\[\033[7m\]"   #inverse
else
  zci=""
fi

# set user info same colour as user selected host info colour
zi0=$zi1

# if root user then colour user info and user identifier red.
[ "${UID}" = 0 ] && zi0="\[\033[1;31m\]" && zi5="\[\033[1;31m\]"

# this function is run at every prompt update, keeping our variables updated.
# bash's PROMPT_COMMAND option handles this (see end of this function).
function pre_prompt {
  # show exit code of last failed command
  ZEXIT="${?}"
  [ "$ZEXIT" = "0" ] && ZEXIT=""

  ZPWD=${PWD/#$HOME/\~}  # sorten home dir to ~

  # set length of our important info
  local infolength="$(whoami)@$(hostname):$(basename $(tty))$ZPWD"
  # set length of our graphics
  local gfxlength=23

  # construct ZFILL size to fill terminal width (minus info/gfx lengths).
  local fillsize
  let fillsize=${COLUMNS}-${gfxlength}-${#infolength}
  ZFILL=""
  while [ "$fillsize" -gt "0" ]; do
    ZFILL="$ZFILL$zg1"
    let fillsize=${fillsize}-1
  done

  # determine how much to truncate ZPWD, if ZFILL can't shrink anymore.
  if [ "$fillsize" -lt "0" ]; then
    local cut=3-${fillsize}  # some tricky math, 3-(-number)=+number
    ZPWD="...${ZPWD:${cut}}"
  fi
}
PROMPT_COMMAND=pre_prompt

# this function tells bash how to draw our prompt
function zer0prompt {
  local zc0="\[\033[0m\]"     # clear all colors
  local zc1="\[\033[1;37m\]"
  local zc2="\[\033[0;37m\]"

  # set colour theme
  if [ "$zpcl" = "cyan" ]; then
    local zc3="\[\033[1;36m\]"; local zc4="\[\033[0;36m\]"
  elif [ "$zpcl" = "blue" ]; then
    local zc3="\[\033[1;34m\]"; local zc4="\[\033[0;34m\]"
  elif [ "$zpcl" = "green" ]; then
    local zc3="\[\033[1;32m\]"; local zc4="\[\033[0;32m\]"
  elif [ "$zpcl" = "red" ]; then
    local zc3="\[\033[1;31m\]"; local zc4="\[\033[0;31m\]"
  elif [ "$zpcl" = "purple" ]; then
    local zc3="\[\033[1;35m\]"; local zc4="\[\033[0;35m\]"
  elif [ "$zpcl" = "yellow" ]; then
    local zc3="\[\033[1;33m\]"; local zc4="\[\033[0;33m\]"
  elif [ "$zpcl" = "black" ]; then
    local zc3="\[\033[1;30m\]"; local zc4="\[\033[0;30m\]"
   elif [ "$zpcl" = "white" ]; then
    local zc3="\[\033[1;37m\]"; local zc4="\[\033[0;37m\]"
  else  # none (no colour)
    local zc3=""; local zc4=""; local zc1=""; local zc2=""
    zi0=""; zi1=""; zi2=""; zi3=""; zi4=""; zi5=""
  fi

  # set titlebar info if xterm/rxvt
  case $TERM in
    xterm*|rxvt*)
      local TITLEBAR='\[\033]0;\u (\w) [${COLUMNS}x${LINES}]\007\]';;
    *)
      local TITLEBAR="";;
  esac

# standard prompt
PS1="${TITLEBAR}\
$zc1$zci$zg2$zg1$zc3$zg1$zc4$zci$zg1$zg4$zi0\u$zi1@\h:\l$zc4$zci$zg5$zg1$zc2$zci$zg1$zg1$zc4$zci\
\$ZFILL$zc3$zg1$zg1$zg1$zg1$zc1$zg1$zg1$zg1$zc3$zg1$zg1$zc4$zci$zg1$zg4$zi2\
\$ZPWD$zc4$zci$zg5$zg1$zc2$zci$zg1
$zc3$zg3$zc4$zci$zg1$zg4$zi3\D{$ztime}$zci $zi5\\\$$zc4$zci$zg5$zi4\
\$ZEXIT$zc2$zci$zg1$zc3$zg6$zc0 "

# continuation prompt
PS2="$zc3$zci$zg3$zc4$zci$zg1$zg4$zi5\\\$$zc4$zci$zg5$zc2$zci$zg1$zc3$zg6$zc0 "
}