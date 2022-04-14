#!/bin/bash
pushd ~
echo -e "\032[31m ----------------------------------------\032[0m"
echo -e "\032[31m Adding Neovim package repository\032[0m"
echo -e "\032[31m ----------------------------------------\032[0m"
sudo add-apt-repository -y ppa:neovim-ppa/unstable


echo -e "\032[31m ----------------------------------------\032[0m"
echo -e "\032[31m Updating Linux\032[0m"
echo -e "\032[31m ----------------------------------------\032[0m"
sudo apt update
sudo apt -y upgrade


echo -e "\032[31m ----------------------------------------\032[0m"
echo -e "\032[31m Installing software\032[0m"
echo -e "\032[31m ----------------------------------------\032[0m"
sudo apt install -y git && \
sudo apt install -y xrdp && \
sudo apt install -y i3 && \
sudo apt install -y curl && \
sudo apt install -y stow && \
sudo apt install -y neovim && \
sudo apt install -y xclip && \
sudo apt install -y nodejs && \
sudo apt install -y npm && \
sudo apt install -y ripgrep && \
sudo apt install -y fd-find && \
sudo apt install -y feh


# echo Installing Chrome
# echo ----------------------------------------
# if [ $(dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed") -eq 0 ];
# then
# 	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
#     sudo dpkg -i google-chrome-stable_current_amd64.deb &&
#     rm -f google-chrome-stable_current_amd64.deb
# else
# 	echo "Chrome found, not adding it"
# fi


# echo Clone dotfiles
# echo ----------------------------------------
# git clone https://github.com/KiLLeRRaT/.dotfiles.git


echo -e "\032[31m ----------------------------------------\032[0m"
echo -e "\032[31m Config xrdp to start with i3\032[0m"
echo -e "\032[31m ----------------------------------------\032[0m"
# EDIT /etc/xrdp/startwm.sh
# COMMENT OUT THIS LINE
#exec /bin/sh /etc/X11/Xsession
# ADD THIS LINE
#/usr/bin/i3
if grep -q "/usr/bin/i3" "/etc/xrdp/startwm.sh" ; then
	# exists
	echo "/usr/bin/i3 found, not adding it"
else
	# not exist

	sudo sed -Ei.bak 's|test -x /etc/X11/Xsession \&\& exec /etc/X11/Xsession|# test -x /etc/X11/Xsession \&\& exec /etc/X11/Xsession|' /etc/xrdp/startwm.sh
	sudo sed -Ei.bak 's|exec /bin/sh /etc/X11/Xsession|# exec /bin/sh /etc/X11/Xsession|' /etc/xrdp/startwm.sh
	#sudo echo "/usr/bin/i3" >> /etc/xrdp/startwm.sh # DOES NOT WORK FOR SUDO.. USE BELOW
	echo "/usr/bin/i3" | sudo tee -a /etc/xrdp/startwm.sh
fi

echo -e "\032[31m ----------------------------------------\032[0m"
echo -e "\032[31m Running stow\032[0m"
echo -e "\032[31m ----------------------------------------\032[0m"
STOW_FOLDERS=i3,nvim,bashrc,oh-my-posh,tmux
pushd ~/.dotfiles
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo Running stow $folder in $PWD
    stow -D $folder
    stow $folder
done
popd

echo -e "\032[31m ----------------------------------------\032[0m"
echo -e "\032[31m Now install the VIM plugins\032[0m"
echo -e "\032[31m ----------------------------------------\032[0m"
nvim --headless +PlugInstall +q

echo -e "\032[31m ----------------------------------------\032[0m"
echo -e "\032[31m Install oh-my-posh\032[0m"
echo -e "\032[31m ----------------------------------------\032[0m"
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

popd
