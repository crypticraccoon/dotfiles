#!/bin/bash

aurMangerUrl="https://aur.archlinux.org/paru.git"
userPackages="man-db fzf wayland hyprland neovim firefox docker docker-compose git brightnessctl pulseaudio pipewire-jack pipewire-bluetooth hyprpaper xdg-desktop-portal-hyprland pavucontrol dunst grim slurp wl-clipboard jq yazi evtest eza ripgrep rofi-wayland tree-sitter wev wl-clip-persist"
webDevSpecific="go typescript"
fontPackages="ttf-fira-sans ttf-noto-nerd ttf-fira-mono ttf-firacode-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols adobe-source-han-sans-cn-fonts"
aurPackages="btm eww"



getPackages(){
	 sudo pacman -S $userPackages $webDevSpecific $fontPackages 
}

installAur() {
	 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh &&
	 cd ${home}/personal/programs
	 cd paru && makepkg -si && paru -S $aurPackages
}

setupTmux(){
	 git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}


setupDots(){
	 #Services
	 sudo ln -sr ${HOME}/personal/dotfiles/services/toggle_keyboard.service /etc/systemd/system/toggle_keyboard.service
	 ln -sr ${HOME}/personal/dotfiles/dots/.alias ${HOME}/.alias
	 ln -sr ${HOME}/personal/dotfiles/dots/.bashrc ${HOME}/.bashrc
	 ln -sr ${HOME}/personal/dotfiles/dots/.bash_profile ${HOME}/.bash_profile
	 ln -sr ${HOME}/personal/dotfiles/dots/.tmux ${HOME}/.tmux

	 ln -sr ${HOME}/personal/dotfiles/confs/alacritty ${HOME}/.config/alacritty
	 ln -sr ${HOME}/personal/dotfiles/confs/hypr ${HOME}/.config/hypr
	 ln -sr ${HOME}/personal/dotfiles/confs/rofi ${HOME}/.config/rofi
	 ln -sr ${HOME}/personal/dotfiles/confs/nvim ${HOME}/.config/nvim
	 ln -sr ${HOME}/personal/dotfiles/confs/fzf ${HOME}/.config/fzf
	 ln -sr ${HOME}/personal/dotfiles/confs/dunst ${HOME}/.config/dunst
}

setupBar(){
	 ln -sr ${HOME}/personal/dotfiles/confs/eww/bars/overlay ${HOME}/.config/eww
}

getPackages && installAur && setupTmux && setupDots && setupBar

