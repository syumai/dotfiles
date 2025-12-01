# zplug

# At first, install `zplug` using the command below.
# $ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "mafredri/zsh-async", from:github
zplug "plugins/kubectl", from:oh-my-zsh
zplug "lib/async_prompt", from:oh-my-zsh
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


export ESMETA_HOME="$HOME/go/src/github.com/es-meta/esmeta" # IMPORTANT!!!
export PATH="$ESMETA_HOME/bin:$PATH" # for executables `esmeta` and etc.
source $ESMETA_HOME/.completion # for auto-completion

# Go
export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)
export GOBIN=$(go env GOPATH)/bin

# PATH
paths=(
  "/bin"
  "/usr/local/bin"
  "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"
  "$(brew --prefix)/opt/llvm/bin"
  "$(brew --prefix)/opt/python/libexec/bin"
  "$(brew --prefix)/opt/openjdk/bin"
  "$HOME/.deno/bin"
  "$HOME/.cargo/bin"
  "$HOME/.cargo/env"
  "$HOME/.wasmer/bin"
  "$GOROOT/bin"
  "$GOPATH/bin"
  "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"
  "/usr/local/tinygo/bin"
  "$HOME/bin"
  "$HOME/.local/bin"
  "$GOROOT/lib/wasm"
  "$HOME/.rbenv/bin"
  "$(brew --prefix)/bin"
  "$HOME/go/src/github.com/WebAssembly/binaryen/bin"
  "$HOME/zls"
  "$HOME/.bun/bin"
  "$GOROOT/misc/wasm"
  "$HOME/.jsvu/bin"
)
joined_paths=$PATH
for p in $paths; do
  export PATH=$p:$PATH
done

# Android
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# Editor
export EDITOR="vim"
export GIT_EDITOR="${EDITOR}"

# Aliases
if [[ $OSTYPE == "linux-gnu" ]]; then
  alias open=xdg-open
fi
alias vimrc="$EDITOR $HOME/.vim/vimrc"
alias zshrc="$EDITOR $HOME/.zshrc"
alias history="fc -l 1"
alias gs="git branch -l | fzf | xargs git switch"
alias :q=exit

# rbenv
eval "$(rbenv init -)"

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
export FZF_ALT_C_COMMAND="$FD_COMMAND --exclude node_modules --type=d -I . $(ghq root)"
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

# kube-ps1
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
export PS1='$(kube_ps1)'$PS1

# Prompt
export PROMPT=$PROMPT'$(kube_ps1) '
kubeoff

# global env
source $HOME/.env

# gcloud

## The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

## The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

alias rm=gomi

# mise
source /opt/homebrew/share/zsh/site-functions
eval "$(mise activate zsh)"

