#!/bin/bash


username=""
repoUrl="https://github.com/crypticraccoon/dotfiles"


rootPackages="alacritty tmux vim networkmanager grub efibootmgr base-devel openssh"
chipSpecificPackages="amd-ucode"
userPackages="man-db fzf wayland hyprland neovim alacritty firefox tmux docker docker-compose git brightnessctl pulseaudio pipewire-jack pipewire-bluetooth hyprpaper xdg-desktop-portal-hyprland"
fontPackages="ttf-fira-sans ttf-noto-nerd ttf-fira-mono ttf-firacode-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols adobe-source-han-sans-cn-fonts"

rootSetup(){}

userSetup() {
	 userAdd -mG wheel $username
	 passwd
}


mkdir ${HOME}/trash 
cd 
git clone $repoUrl

sed 'i/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g'

