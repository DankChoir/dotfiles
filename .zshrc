# --- Oh My Zsh Setup ---
export ZSH="$HOME/.oh-my-zsh"

# Starship handles the theme
ZSH_THEME=""

# Plugins (zsh-syntax-highlighting must be LAST)
plugins=(
  git
  zsh-autosuggestions
  sudo
  extract
  fzf
  zsh-autopair
  fzf-tab
  zsh-syntax-highlighting
)

# Initialize Oh My Zsh (this handles compinit automatically)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

# --- History Configuration ---
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY          # Add to history, don't overwrite
setopt SHARE_HISTORY           # Share history between all open tabs
setopt HIST_IGNORE_ALL_DUPS    # Don't record the same command twice
setopt HIST_REDUCE_BLANKS      # Remove extra blanks from commands

# --- fzf-tab Configuration (Previews!) ---
# Give a preview of the directory/file when tabbing
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'

# --- General Completion Tweaks ---
zstyle ':completion:*' matcher-list 'm:{a-z1-2}={A-Z1-2}' # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Use terminal colors in completion menu

# --- Environment Variables ---
export EDITOR=nvim
export TERM=xterm-256color
export GEM_HOME=$(ruby -e 'puts Gem.user_dir' 2>/dev/null)
export DENO_INSTALL=$HOME/.deno
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDKMAN_DIR="$HOME/.sdkman"

# --- Path Configuration ---
path=(
    $HOME/.cargo/bin
    $HOME/bin
    $HOME/.local/bin
    $GEM_HOME/bin
    $DENO_INSTALL/bin
    node_modules/.bin
    $path
)
export PATH

# --- Source Unified Aliases ---
[[ -f ~/.aliases ]] && source ~/.aliases

# --- Tools Initialization ---
eval "$(starship init zsh)"
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"

# --- SDKMAN (This must be at the end!) ---
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
