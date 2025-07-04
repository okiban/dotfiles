# ─────────────────────────────────────────────
# Oh My Zsh Setup
# ─────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
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
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/go/bin:$ANDROID_HOME/emulator::$HOME/bin:/lib/qt6/bin"

# ─────────────────────────────────────────────
# Plugins and Completions
# ─────────────────────────────────────────────
# 'thefuck' alias
if command -v thefuck &> /dev/null; then
    eval "$(thefuck --alias)"
fi

[ -f "$HOME/.zsh_autocomplete" ] && source "$HOME/.zsh_autocomplete"
# nvm init
[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source "/usr/share/nvm/init-nvm.sh"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# pipx autocomplete
if command -v pipx &> /dev/null && command -v register-python-argcomplete &> /dev/null; then
    eval "$(register-python-argcomplete pipx)"
fi

# zoxide init
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# starship init
if command -v starship &> /dev/null; then
    # Set config path if the file exists, otherwise let starship use defaults
    if [[ -f "$HOME/.config/starship/starship.toml" ]]; then
        export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
    fi
    eval "$(starship init zsh)"
fi
