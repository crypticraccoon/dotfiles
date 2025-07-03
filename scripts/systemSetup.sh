#!/bin/bash


username=""


rootPackages="base linux linux-firmware alacritty tmux vim networkmanager grub efibootmgr base-devel openssh ninja net-tools"
chipSpecificPackages="amd-ucode"

rootSetup(){}

userSetup() {
	 userAdd -mG wheel $username
	 passwd
	 mkdir -p /home/${username}/{personal/programs,trash}
	 sed 'i/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g'
}


#mkdir ${HOME}/trash 
#cd 
#git clone $repoUrl


