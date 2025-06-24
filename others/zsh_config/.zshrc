# ─────────────────────────────────────────────
# Oh My Zsh Setup
# ─────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="okiban-nosobi"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)

source "$ZSH/oh-my-zsh.sh"

# ─────────────────────────────────────────────
# Custom Functions
# ─────────────────────────────────────────────
# 'y' function to open Yazi and change to last visited dir
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(<"$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ─────────────────────────────────────────────
# Aliases and Additional Config
# ─────────────────────────────────────────────
# Load bash aliases if present
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# ─────────────────────────────────────────────
# Environment Variables
# ─────────────────────────────────────────────
export EDITOR="nvim"
export KUBE_EDITOR="nvim"

export ANDROID_HOME="$HOME/Android/sdk"

# Deduplicated and ordered PATH additions
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/go/bin:$ANDROID_HOME/emulator:$PATH"

# ─────────────────────────────────────────────
# Plugins and Completions
# ─────────────────────────────────────────────
# 'thefuck' alias
eval "$(thefuck --alias)"

# pipx autocomplete
[ -f "$HOME/.zsh_autocomplete" ] && source "$HOME/.zsh_autocomplete"
eval "$(register-python-argcomplete pipx)"

