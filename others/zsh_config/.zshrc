# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="okiban-nosobi"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)

source $ZSH/oh-my-zsh.sh

# User configuration
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

export ANDROID_HOME="$HOME/Android/sdk"
export PATH=$PATH:"$HOME/.cargo/bin:$HOME/.local/bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/go/bin:$ANDROID_HOME/emulator/:/opt/sonar-scanner/bin/"
export EDITOR=nvim
export KUBE_EDITOR=nvim
eval $(thefuck --alias)

# auto completion for pipx
source $HOME/.zsh_autocomplete

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source /usr/share/nvm/init-nvm.sh

# Created by `pipx` on 2025-03-07 16:51:56
export PATH="$PATH:/home/gwe/.local/bin"

eval "$(register-python-argcomplete pipx)"

