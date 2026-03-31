# If you come from bash you might have to change your $PATH.


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

export VISUAL=nvim
export EDITOR="$VISUAL"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Pyenv environment variables
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Pyenv initialization
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init --path)"
# fi
#eval "$(pyenv init --path)"
#eval "$(pyenv virtualenv-init -)"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  docker-compose
  node
  npm
  pip
  python
  sudo
  tmux
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
# pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
#fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# use dotfiles' configuration for rebuild
alias update='nixos-rebuild switch --flake /home/violin/projects/dotfiles/nixos#nixos'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias smartapi="cd ~/projects/smarttakst/smarttakst-api/"
alias smartweb="cd ~/projects/smarttakst/smarttakst-sharing-platform/"
alias smartadmin="cd ~/projects/smarttakst/smarttakst-web/"

# api
alias cieapi="cd ~/projects/cakeiteasy/web.api/"
# bakery admin
alias ciebakeryadmin="cd ~/projects/cakeiteasy/web.bakery-admin/"
# bakery page
alias ciebakerypage="cd ~/projects/cakeiteasy/web.bakery-page/"
# packages
alias ciepackages="cd ~/projects/cakeiteasy/web.packages/"
# marketplace
alias ciemarketplace="cd ~/projects/cakeiteasy/web.marketplace/"
# emails
alias ciemails="cd ~/projects/cakeiteasy/emails/"
# procurement
alias cieprocurement="cd ~/projects/cakeiteasy/web.procurement/"
# texterify
alias cietexterify="cd ~/projects/cakeiteasy/texterify-cli/"
# Old admin
alias cieoldadmin="cd ~/projects/cakeiteasy/web.admin/"
# mobile admin
alias ciemobileadmin="cd ~/projects/cakeiteasy/mobile.bakery-admin/"
# Download poeditor translations


alias screen_record_section='wf-recorder -g "$(slurp)"'


# Lazy-load NVM for faster shell startup
export NVM_DIR="$HOME/.nvm"
_lazy_nvm() {
  unset -f nvm node npm npx ng yarn pnpm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { _lazy_nvm; nvm "$@"; }
node() { _lazy_nvm; node "$@"; }
npm() { _lazy_nvm; npm "$@"; }
npx() { _lazy_nvm; npx "$@"; }
ng() { _lazy_nvm; ng "$@"; }
yarn() { _lazy_nvm; yarn "$@"; }
pnpm() { _lazy_nvm; pnpm "$@"; }

setopt auto_cd
cdpath=($HOME/projects/cakeiteasy $HOME/projects/cakeiteasy/web.marketplace)

# tmuxifiers settings
# export PATH="$HOME/.tmuxifier/bin:$PATH"
# eval "$(tmuxifier init -)"

# yazi path
export PATH="$HOME/yazi/target/release:$PATH"


if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


export BROWSER=/usr/bin/google-chrome

export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
# Cached output of `fzf --zsh`
# If you update fzf in the future, regenerate the cache with: fzf --zsh > ~/.fzf-completion.zsh
[ -f ~/.fzf-completion.zsh ] && source ~/.fzf-completion.zsh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# For devbox
# eval "$(devbox global shellenv)"
# eval "$(devbox global shellenv --preserve-path-stack -r)"

export EMACSDIR="$HOME/.config/emacs"
export PATH="$HOME/.local/bin:$PATH"


# Angular CLI autocompletion — removed: `ng completion script` is not supported
# by the installed Angular CLI version and was erroring on every shell start.

# opencode
export PATH=/home/violin/.opencode/bin:$PATH

# pnpm
export PNPM_HOME="/home/violin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
