# zplug

# At first, install `zplug` using the command below.
# $ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/kube-ps1", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "themes/simple", from:oh-my-zsh, as:theme
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "~/.zsh", from:local

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Go
export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)

# PATH
paths=(
  "/bin"
  "/usr/local/bin"
  "$HOME/.deno/bin"
  "$HOME/.cargo/env"
  "$GOROOT/bin"
  "$GOPATH/bin"
  "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"
  "$HOME/bin"
)
joined_paths=$PATH
for p in $paths; do
  export PATH=$PATH:$p
done

# Editor
export EDITOR="vim"
export GIT_EDITOR="${EDITOR}"

# Aliases
if [[ $OSTYPE == "linux-gnu" ]]; then
  alias open=xdg-open
fi
alias cat=ccat
alias vimrc="$EDITOR $HOME/.vim/vimrc"
alias zshrc="$EDITOR $HOME/.zshrc"
alias history="fc -l 1"
alias gs="git branch -l | fzf | xargs git switch"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# direnv
eval "$(direnv hook zsh)"

# fd
if [[ $OSTYPE == "linux-gnu" ]]; then
  FD_COMMAND=fdfind
else
  FD_COMMAND=fd
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--extended --ansi --multi"
export FZF_ALT_C_COMMAND="$FD_COMMAND --type=d -I . ~"
export FZF_CTRL_T_COMMAND="$FD_COMMAND -I . ~"
export INTERACTIVE_FILTER="fzf"

# Language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export LISTMAX=50

# Do not add in root
if [[ $UID == 0 ]]; then
    unset HISTFILE
    export SAVEHIST=0
fi

# Prompt
export PROMPT=$PROMPT'$(kube_ps1) '
kubeoff

# global env
source $HOME/.env

