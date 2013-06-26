autoload -U compinit promptinit colors vcs_info
# Autocompletion
compinit
# Prompt
promptinit
# Colours (obviously)
colors

# Auto-complete command line switches for aliases
setopt completealiases

setopt prompt_subst

# Emacs mode (I find vim mode too slow on command line)
bindkey -e

# Make up and down complete based on currently typed text
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Formatting for VCS
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}


# Theme
if [ "$(hostname)" = "imac" ]; then
  function collapse_pwd {
      echo $(pwd | sed -e "s,^$HOME,~,")
  }
  PS1='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}$(collapse_pwd) %{$fg_bold[blue]%}$(vcs_info_wrapper)%{$fg_bold[blue]%} % %{$reset_color%}'
else
  prompt walters
fi

# Common
. ~/.profile_common
