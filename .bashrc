# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Append to history file and set limits.
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
# Don't save duplicates in the history file.
HISTCONTROL=ignoreboth

# Adjust properly to changes in window size.
shopt -s checkwinsize

# Activate `**` for shell globbing arbitrary levels of directories.
shopt -s globstar

# Enable colour support for common commands.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Enable programmable completion features.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Personalized settings and aliases.
if [[ $(id -u) -ne 0 ]] ; then
    export PS1="\n\[\e[7m\]\u@\h \w \\$\[\e[0m\] "
    export PS2="\[\e[7m\]>\[\e[0m\] "
else
    export PS1="\n\[\e[7m\]\[\e[31m\]\u@\h \w \\$\[\e[39m\]\[\e[27m\] "
    export PS2="\[\e[7m\]\[\e[31m\]>\[\e[39m\]\[\e[27m\] "
fi
source ~/.aliases
export PATH="${PATH}:/usr/lib/dart/bin:$HOME/.pub-cache/bin:$HOME/bin:$HOME/.local/bin"

# Stop Ctrl-s from freezing the terminal.
stty -ixon

# Set Vim to be the default editor.
export VISUAL=vim
export EDITOR="$VISUAL"

echo "We’ve got to start thinking of the Internet as something more than a glow-in-the-dark newspaper."
echo "    Jon Bois"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
