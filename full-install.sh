#!/bin/bash

if [ -z "`groups $USER | grep -E "(^|\s)sudo(\s|$)"`" ]
then
	echo "Please add $USER to the \"sudo\" group and restart your session."
	echo "\"usermod -a -G sudo $USER\""
fi

read -p $'Have you upgraded your Debian to the latest unstable version yet ? (y/n)\n' upgraded
if [ ${upgraded,,} != "y" ]
then
	read -p $'Would you like to upgrade your Debian to the last unstable version ? (y/n)\n' upgrade
	if [ ${upgrad,,} == "y" ]
	then
		echo "Ok, bye !"
	else
		set -o xtrace # Show command before executing
		sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak && cp ./sources.list /etc/apt/sources.list && apt update && apt full-upgrade -y
		set +o xtrace
	fi
else
	read -p $'Are you sure you want to auto configure your Debian installation ? (y/n)\n' sure
	if [ ${sure,,} != "y" ]
	then
		echo "Ok, bye !"
	else
		set -o xtrace

		# apt install
		sudo apt install -y bash-completion git wget tmux vim-nox python3-pip fonts-powerline powerline firmware-linux-nonfree firmware-misc-nonfree python3-nautilus python3-gi plymouth plymouth-themes -y

		# bashrc
		cp ~/.bashrc ~/.bashrc.bak && cp ./bashrc ~/.bashrc
		
		# tmux
		if [ -f ~/.tmux.conf ]
		then
			cp ~/.tmux.conf ~/.tmux.conf.bak
		fi
		cp ./tmux.conf ~/.tmux.conf

		# Vim
		if [ -f ~/.vimrc ]
		then
			cp ~/.vimrc ~/.vimrc.bak
		fi
		#cp ./vrimrc ~/.vimrc

		# Python
		sudo ln -s `which python3` `dirname $(which python3)`/python
		pip install ipython
		#pip install --user git+git://github.com/powerline/powerline
		if [ -f ~/.ipython/profile_default/ipython_config.py ]
		then
			cp ~/.ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py.bak
		fi
		#cp ipython_config.py ~/.ipython/profile_default/ipython_config.py
		
		
		# Themes customization
		mkdir git_repos && cd git_repos
		git clone https://github.com/vinceliuice/Orchis-theme
		git clone https://github.com/vinceliuice/Tela-icon-theme
		git clone https://github.com/vinceliuice/Tela-circle-icon-theme
		git clone https://github.com/vinceliuice/Vimix-cursors
		git clone https://github.com/angela-d/nautilus-right-click-new-file
		git clone https://github.com/chr314/nautilus-copy-path
		git clone https://github.com/Teraskull/bigsur-grub2-theme
		cd Orchis-theme && sed s/"apt-get install"/"apt-get install -y"/g ./core.sh -i && ./install.sh
		cp -r ./src/firefox/configuration/user.js ~/.mozilla/firefox/*.default-esr/
		cp -r ./src/firefox/chrome/ ~/.mozilla/firefox/*.default-esr/
		cd ../Tela-icon-theme && ./install.sh
		cd ../Tela-circle-icon-theme && ./install.sh
		cd ../Vimix-cursor && ./install.sh
		cd ../nautilus-right-click-new-file && ./automate.sh
		cd ../nautilus-copy-path && make install
		cd ../bigsur-grub2-theme && ./install.sh
		cd ..
		sudo cp /etc/default/grub /etc/default/grub.bak
		sudo sed 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/g' /etc/default/grub -i
		sudo update-grub2

		git clone https://github.com/navisjayaseelan/apple-mac-plymouth.git
		sudo cp -r apple-mac-plymouth/apple-mac-plymouth/ /usr/share/plymouth/themes/
		set +o xtrace

		echo "DONE !"
		echo "You can select a splash screen with (for example : \"sudo plymouth-set-default-theme -R apple-mac-plymouth\")."
		echo "You may also want to install the Nvidia drivers with \"sudo apt install nvidia-detect nvidia-driver\"."
		echo "Do not forget to generate a SSH private key with ssh-keygen and to edit git email address \"git config user.email \"a@b.c\"\" and/or \"git config --global user.email \"a@b.c\"\"."
		echo "Add \"'PowerlineSymbols', \" to the beginning of the Editor:Font Family setting in VSCode".
	fi
fi

