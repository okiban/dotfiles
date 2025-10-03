#!/bin/bash

set -e

echo "Installing okiban dotfiles..."

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Check if we're on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo "This script is designed for Arch Linux"
    exit 1
fi

# Update the system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# =============================================================================
# PACKAGE INSTALLATION
# =============================================================================

echo "Installing packages..."

# Check if yay is installed, install it if not
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd - > /dev/null
fi

# Install packages
echo "Installing packages..."
PACKAGES=(
    "7zip"
    "android-tools"
    "bat"
    "bitwarden"
    "bluetui"
    "bluez"
    "bluez-utils"
    "brave-bin"
    "breeze-icons"
    "brightnessctl"
    "btop"
    "chafa"
    "cups"
    "discord"
    "distroav"
    "dnsmasq"
    "dunst"
    "dust"
    "dysk"
    "emacs-wayland"
    "fastfetch"
    "fd"
    "freeze-bin" 
    "fzf"
    "ghostscript"
    "ghostty"
    "gimp"
    "gnome-calculator"
    "gnome-calendar"
    "go"
    "gpu-usage-waybar"
    "graphicsmagick"
    "gthumb"
    "gvfs-mtp"
    "gvfs-smb"
    "heroic-games-launcher-bin"
    "hypridle"
    "hyprlock" 
    "hyprpaper"
    "hyprpolkitagent"
    "hyprshot"
    "imagemagick"
    "jadx"
    "jdownloader2"
    "jmtpfs"
    "lazygit"
    "libreoffice-still"
    "linux-wifi-hotspot"
    "localsend"
    "lsb-release"
    "lsd"
    "lxappearance"
    "man-db"
    "moonlight-qt"
    "mtpfs"
    "ncdu"
    "neovim"
    "network-manager-applet"
    "networkmanager"
    "noto-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"
    "noto-fonts-extra"
    "ntfs-3g"
    "ntfsprogs"
    "nvtop"
    "nwg-displays"
    "nwg-look"
    "openrazer-daemon"
    "otf-font-awesome"
    "pacseek"
    "pavucontrol"
    "pipewire-alsa"
    "pipewire-pulse"
    "proton-vpn-gtk-app"
    "python-distutils-extra"
    "python-openrazer"
    "python-pipx"
    "rate-mirrors-bin"
    "ripgrep"
    "rofi-wayland"
    "satty"
    "scrcpy"
    "seahorse"
    "simple-scan"
    "slides"
    "slurp"
    "smbclient"
    "starship"
    "swaync"
    "tectonic"
    "tldr"
    "ttf-jetbrains-mono-nerd"
    "ttf-nerd-fonts-symbols"
    "ttf-nerd-fonts-symbols-common"
    "ueberzugpp"
    "unzip"
    "v4l2loopback-dkms"
    "viu"
    "vlc"
    "vlc-plugins-all"
    "waybar"
    "wf-recorder-gui"
    "whitesur-gtk-theme"
    "wireplumber"
    "wl-clipboard"
    "xcursor-breeze"
    "yazi"
    "zen-browser-bin"
    "zenity"
    "zip"
    "zoxide"
    "zsh"
)

# I don't remember why i need this font but for now, it's broken
# "otf-apple-sf-pro"

yay -S --needed --noconfirm "${PACKAGES[@]}"

# Remove unwanted packages
echo "Removing unwanted packages..."
UNWANTED_PACKAGES=(
    "dolphin"
    "kitty"
    "polkit-kde-agent"
    "wofi"
)

for pkg in "${UNWANTED_PACKAGES[@]}"; do
    if pacman -Qi "$pkg" &> /dev/null; then
        echo "Removing $pkg..."
        yay -R --noconfirm "$pkg" || echo "Unable to remove $pkg"
    else
        echo "$pkg is not installed"
    fi
done

# =============================================================================
# ANDROID SDK 
# =============================================================================
mkdir -p $HOME/Android/sdk/cmdline-tools
cd $HOME/Android/sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
unzip commandlinetools-linux-13114758_latest.zip
mkdir -p cmdline-tools/latest
mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true
rm commandlinetools-linux-13114758_latest.zip

# Install oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# =============================================================================
# DOTFILES CONFIGURATION
# =============================================================================

echo "Configuring dotfiles..."

# Execute your existing configuration script
if [ -f "$SCRIPT_DIR/hyprland/do-symbolic-links.sh" ]; then
    echo "Running your symbolic links script..."
    cd hyprland && ./do-symbolic-links.sh --force && cd -
else
    echo "Script hyprland/do-symbolic-links.sh not found"
fi

# =============================================================================
# POST-INSTALLATION
# =============================================================================

echo "Post-installation configuration..."

# Install oh-my-zsh plugins
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh plugins..."
 
    # zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    fi
 
    # zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    fi
else
    echo "oh-my-zsh is not installed, skipping plugins"
fi

# Change shell
sudo chsh -s /usr/bin/zsh

# Add user to plugdev group (for OpenRazer)
echo "Adding $USER to plugdev group..."
sudo usermod -aG plugdev "$USER"

# Enable services
echo "Enabling services..."
SERVICES=(
    "bluetooth"
    "cups"
    "NetworkManager"
)
sudo systemctl enable "${SERVICES[@]}"

reboot
