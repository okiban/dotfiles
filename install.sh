#!/bin/bash

set -e

echo "🚀 Installing okiban dotfiles..."

# Check if we're on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo "❌ This script is designed for Arch Linux"
    exit 1
fi

# Update the system
echo "📦 Updating system..."
sudo pacman -Syu --noconfirm

# =============================================================================
# PACKAGE INSTALLATION
# =============================================================================

echo "📥 Installing packages..."

# Check if yay is installed, install it if not
if ! command -v yay &> /dev/null; then
    echo "🔧 Installing yay..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd - > /dev/null
fi

# Remove unwanted packages
echo "🗑️ Removing unwanted packages..."
UNWANTED_PACKAGES=(
    "dolphin"
    "kitty"
    "polkit-kde-agent"
    "wofi"
)

for pkg in "${UNWANTED_PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo "Removing $pkg..."
        yay -R --noconfirm "$pkg" || echo "⚠️ Unable to remove $pkg"
    else
        echo "📝 $pkg is not installed"
    fi
done

# Install official packages
echo "📥 Installing official packages..."
OFFICIAL_PACKAGES=(
    "bat"
    "bluez"
    "bluez-utils"
    "breeze-icons"
    "btop"
    "chafa"
    "cups"
    "dunst"
    "fzf"
    "ghostscript"
    "gimp"
    "gnome-calculator"
    "graphicsmagick"
    "gthumb"
    "gvfs-smb"
    "hypridle"
    "imagemagick"
    "libreoffice-still"
    "lxappearance"
    "neovim"
    "noto-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"
    "noto-fonts-extra"
    "nvtop"
    "nwg-look"
    "pavucontrol"
    "procs"
    "ripgrep"
    "smbclient"
    "starship"
    "tldr"
    "vlc"
    "xcursor-breeze"
    "zenity"
    "zoxide"
    "zsh"
)

sudo pacman -S --needed --noconfirm "${OFFICIAL_PACKAGES[@]}"

# Install AUR packages
echo "📥 Installing AUR packages..."
AUR_PACKAGES=(
    "bitwarden"
    "bluetui"
    "bluetuith"
    "brave-bin"
    "gpu-usage-waybar"
    "grimshot-bin-sway"
    "heroic-games-launcher-bin"
    "hyprlux"
    "hyprpolkitagent"
    "lazygit"
    "lsb-release"
    "nwg-displays"
    "oh-my-zsh"
    "openrazer"
    "otf-apple-sf-pro"
    "pacseek"
    "swaync"
    "tectonic"
    "ttf-jetbrains-mono-nerd"
    "ttf-nerd-fonts-symbols"
    "ttf-nerd-fonts-symbols-common"
    "ueberzugpp"
    "viu"
)

yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

# =============================================================================
# DOTFILES CONFIGURATION
# =============================================================================

echo "⚙️ Configuring dotfiles..."

# Execute your existing configuration script
if [ -f "hyprland/do-symbolic-links.sh" ]; then
    echo "🔧 Running your symbolic links script..."
    cd hyprland && ./do-symbolic-links.sh --force && cd -
else
    echo "❌ Script hyprland/do-symbolic-links.sh not found"
    exit 1
fi

# =============================================================================
# POST-INSTALLATION
# =============================================================================

echo "🎉 Post-installation configuration..."

# Install oh-my-zsh plugins
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "📥 Installing oh-my-zsh plugins..."
 
    # zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    fi
 
    # zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    fi
else
    echo "⚠️ oh-my-zsh is not installed, skipping plugins"
fi

# Add user to plugdev group (for OpenRazer)
echo "👤 Adding $USER to plugdev group..."
sudo usermod -aG plugdev "$USER"

# Enable services
echo "🔧 Enabling services..."
sudo systemctl enable bluetooth cups openrazer-daemon

reboot
