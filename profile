export PROFILE_DIR=$HOME/.bashenv

# Load environment specific functions
export FUNCTIONS="$PROFILE_DIR/functions"
source $FUNCTIONS

# Don't store duplicates or empty commands in history
HISTCONTROL=ignoredups:ignorespace:erasedups

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history size
HISTSIZE=10000
HISTFILESIZE=100000

# Check the window size after each command
shopt -s checkwinsize

# Set the terminal title
case "$TERM" in
    xterm*|rxvt* )
        PS1="\[\e]0;\u@\h: \w\$TITLE\a\]$PS1" ;;
    screen )
        PS1="\[\033]2;\u@\h: \w\$TITLE\a\]$PS1" ;;
esac

# Set path to custom input configuration
export INPUTRC="$PROFILE_DIR/inputrc"
bind -f $INPUTRC

export EDITOR=vim
export VISUAL=vim


# 'reload' reloads bash environment with new client
function reload() {
    source $PROFILE_DIR/profile
}

# Set display color based on hostname
BGCOLOR=''
TXTCOLOR="\[\033[1;35m\]"
NOCOLOR="\[\033[0m\]"
GREY="\[\033[1;30m\]"

#STARTFGCOLOR='\[\033[0;34m';
#STARTBGCOLOR="\[\033[47m"
#export PS1="$STARTFGCOLOR$STARTBGCOLOR\u@\h \w> $ENDCOLOR"

ps1="${GREY}-- [\$?] \d \t ${NOCOLOR}\n${BGCOLOR}${TXTCOLOR}[\u@\h]$NOCOLOR\[\033[1;36m\]\w $NOCOLOR$ ";
alias :D='export PS1="\033[1;35m\][\u@\h]\033[1;36m\]\w \033[1;37m\]$ "';
alias :ND='export PS1="\033[1;35m\][\u@\h]\033[1;36m\]\w \033[0m\]$ "';
alias psoff='export PS1="[\u@\h \W] $ "; ';
alias pson='export PS1="$ps1"';
export PS1="$ps1";
# easy copy paste
# PS1="\[\033[1;35m\][\u@\h]\[\033[1;36m\]\w \[\033[0m\]$ ";

# Shortcuts to vim
alias e=vim
alias :e=vim

alias cpu="grep 'processor\|model name' /proc/cpuinfo;echo ''; cat /proc/meminfo | grep 'MemTotal' | awk '{print \"MemTotal:\", int(\$2/1024), \"MB\"}'"
alias htop="export TERM=xterm-color; /usr/bin/htop; export TERM=screen"

# Correcting common mistakes
#alias p='pwd'
alias cd..="cd .."
alias ..="cd .."
alias :q="exit"
alias :ls="ls"
alias ll='ls -l -h --color=tty' 2>/dev/null
alias lla='ls -l -a -h --color=tty' 2>/dev/null

# super mysql command prompt
alias mysql='/usr/bin/mysql --auto-rehash --auto-vertical-output --prompt="\\u@\\h [\\d]>\\_"'
alias mysql1='/usr/bin/mysql --auto-rehash --prompt="\\u@\\h [\\d]>\\_"'

alias grep='/bin/grep --color=auto'
alias UTC='TZ=UTC date'
alias whatshell="ps -p $$"

# Use tty for input and output to function shortcuts
tty=`tty`


# Keep history of past directories
source $PROFILE_DIR/cd_hist.sh
