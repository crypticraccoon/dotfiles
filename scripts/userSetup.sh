#!/bin/bash

aurMangerUrl="https://aur.archlinux.org/paru.git"
userPackages="man-db fzf wayland hyprland neovim firefox docker docker-compose git brightnessctl pulseaudio pipewire-jack hyprpaper xdg-desktop-portal-hyprland pavucontrol dunst grim slurp wl-clipboard jq yazi evtest eza ripgrep rofi-wayland tree-sitter wev wl-clip-persist"
webDevSpecific="go typescript"
fontPackages="ttf-fira-sans ttf-noto-nerd ttf-fira-mono ttf-firacode-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols adobe-source-han-sans-cn-fonts ttf-jetbrains-mono-nerd"
aurPackages="bottom eww"



getPackages(){
	 sudo pacman -S $userPackages $webDevSpecific $fontPackages 
}

installAur() {

   if [[ -d ${HOME}/personal/programs/paru
 ]]
	 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh &&
	 git clone https://aur.archlinux.org/paru.git ${HOME}/personal/programs/paru
	 cd ${HOME}/personal/programs/paru && makepkg -si && paru -S $aurPackages
}


setupDots(){
	 #Services
	 rm ${HOME}/{.bashrc,.bash_profile}
	 sudo ln -sr ${HOME}/personal/dotfiles/services/toggle_keyboard.service /etc/systemd/system/toggle_keyboard.service
	 ln -sr ${HOME}/personal/dotfiles/dots/.alias ${HOME}/.alias
	 ln -sr ${HOME}/personal/dotfiles/dots/.bashrc ${HOME}/.bashrc
	 ln -sr ${HOME}/personal/dotfiles/dots/.bash_profile ${HOME}/.bash_profile
	 ln -sr ${HOME}/personal/dotfiles/dots/.tmux ${HOME}/.tmux.conf

	 ln -sr ${HOME}/personal/dotfiles/confs/alacritty ${HOME}/.config/alacritty
	 ln -sr ${HOME}/personal/dotfiles/confs/hypr ${HOME}/.config/hypr
	 ln -sr ${HOME}/personal/dotfiles/confs/rofi ${HOME}/.config/rofi
	 ln -sr ${HOME}/personal/dotfiles/confs/nvim ${HOME}/.config/nvim
	 ln -sr ${HOME}/personal/dotfiles/confs/fzf ${HOME}/.config/fzf
	 ln -sr ${HOME}/personal/dotfiles/confs/dunst ${HOME}/.config/dunst
	 ln -sr ${HOME}/personal/dotfiles/confs/tmux ${HOME}/.config/tmux
}


setupTmux(){
	 git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
}

setupBar(){
	 ln -sr ${HOME}/personal/dotfiles/confs/eww/bars/overlay ${HOME}/.config/eww
}

getPackages && installAur && setupDots && setupTmux && setupBar

