#!/bin/zsh

# Exit when any command fails
set -e

# USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
USER_RECORD="$(getent passwd $SUDO_USER)"
USER_GECOS_FIELD="$(echo "$USER_RECORD" | cut -d ':' -f 5)"
USER_HOME="$(echo "$USER_RECORD" | cut -d ':' -f 6)"
USER_FULL_NAME="$(echo "$USER_GECOS_FIELD" | cut -d ',' -f 1)"


pushd $USER_HOME

echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Updating Linux\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
pamac update && \
pamac upgrade --no-confirm
echo -e "Done"

echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Installing software\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"

function installApp() {
	[ -n "$2" ] && desc=" ($2)" || desc=""
	read -k 1 -r "install?Install $1$desc? (y/n) "
	echo -e ""
	if [[ $install =~ ^[Yy]$ ]]
	then
		echo Installing $1
		pamac install --no-confirm $1
	fi
}

function buildApp() {
	[ -n "$2" ] && desc=" ($2)" || desc=""
	read -k 1 -r "build?Install $1$desc? (y/n) "
	echo -e ""
	if [[ $build =~ ^[Yy]$ ]]
	then
		echo Installing $1
		pamac build --no-confirm $1
	fi
}

pamac install --no-confirm git
pamac install --no-confirm curl
pamac install --no-confirm stow
pamac install --no-confirm neovim
pamac install --no-confirm xclip
pamac install --no-confirm ripgrep
pamac install --no-confirm fd
pamac install --no-confirm alacritty
pamac install --no-confirm timeshift
pamac install --no-confirm tmux
pamac install --no-confirm btop
pamac install --no-confirm unzip
pamac install --no-confirm feh
pamac install --no-confirm neofetch
pamac install --no-confirm zoxide
pamac install --no-confirm partitionmanager

# FROM: https://wiki.archlinux.org/title/Activating_numlock_on_bootup
# Turns on numlock in X11, need to add entry into .xinitrc
pamac install --no-confirm numlockx


installApp brave-browser
installApp redshift "Nightlight, Fluxx alternative"
installApp signal-desktop
installApp discord
installApp timeshift-autosnap-manjaro
installApp flameshot "Screenshot utility"
installApp docker
installApp docker-compose
installApp docker-scan
installApp playerctl "Control audio player using commandline/keyboard"

installApp freerdp "RDP support for Remmina"
installApp remmina "Remote desktop client"
# https://wiki.archlinux.org/title/Remmina
# buildApp remmina-plugin-rdesktop "Remmina plugin for RDP" DO NOT INSTALL THIS!!!!!!

installApp perl-anyevent-i3 "Dependency for i3-save-tree utility"
installApp python-pip
installApp aws-cli
installApp dnsutils "nsllookup"
installApp bluez "Bluetooth protocol stack"
installApp bluez-utils "Bluetooth utilities like bluetoothctl"
installApp blueman "Bluetooth Manager"
installApp pavucontrol "Pulseaudio mixer/volume control"
installApp sshfs "Mount a remote disk over ssh"
installApp vifm
installApp zathura "PDF Viewer (Application)"
installApp zathura-pdf-poppler "PDF Support for zathura"
installApp libvirt "Virtualization framework"
installApp qemu "QEMU emulator"
installApp virt-manager "Virtualization manager"
installApp virt-viewer "Virtualization viewer"

# DEV TOOLS
installApp nuget
installApp mono
installApp mono-msbuild
installApp kdiff3
installApp dotnet-sdk
installApp postgresql
installApp jq


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Install 1Password\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
read -k 1 -r "build?Install 1Password? (y/n) "
echo -e ""
if [[ $build =~ ^[Yy]$ ]]
then
	echo Installing 1Password
	curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import && \
	git clone https://aur.archlinux.org/1password.git && \
	cd 1password && \
	makepkg -si
fi


buildApp xrdp

gpg --keyserver keys.gnupg.net --recv-keys 61ECEABBF2BB40E3A35DF30A9F72CDBC01BF10EB
buildApp xorgxrdp

buildApp rslsync
buildApp azuredatastudio-bin "SQL Server client"
# WHEN TRYING TO INSTALL THE postgresql EXTENSION AND YOU RUN INTO TROUBLE, YOU MAY NEED TO RUN
# THIS: sudo pamac build libffi6

# buildApp forticlient-vpn
buildApp openfortivpn "Fortigate VPN client"
buildApp icaclient "Citrix workspace app/Citrix receiver"
buildApp powershell-bin
buildApp winbox-xdg "Winbox, xdg compliant version"
buildApp virt-v2v "Convert virtual machines (vhd) to run on KVM"
buildApp nbdkit "Network Block Device (NBD) server, needed by virt-v2v"

# --------------------------------------------------
# SNAP PACKAGES
# --------------------------------------------------
#pamac install snapd --no-confirm
#systemctl enable --now snapd.socket
#ln -s /var/lib/snapd/snap /snap
#echo -e "Done"
# snap install google-chat-electron
# snap install remmina
# snap install spotify
# snap install teams

# THIS DOESNT WORK
# buildApp powershell
# sudo snap install powershell --classic
# --------------------------------------------------




echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Configure SSH Keys\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
[ ! -d "$USER_HOME/.ssh" ] && mkdir $USER_HOME/.ssh && ssh-keygen -q -N "" -f $USER_HOME/.ssh/id_rsa
chown -R $SUDO_USER $USER_HOME/.ssh
echo -e "Done"


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Configure Git\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
read  -r "git_email?Enter Git email address: "
git config --global user.email $git_email
git config --global user.name $USER_FULL_NAME
echo -e "Done"


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Config xrdp to start with i3\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
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

	sed -Ei.bak 's|test -x /etc/X11/Xsession \&\& exec /etc/X11/Xsession|# test -x /etc/X11/Xsession \&\& exec /etc/X11/Xsession|' /etc/xrdp/startwm.sh
	sed -Ei.bak 's|exec /bin/sh /etc/X11/Xsession|# exec /bin/sh /etc/X11/Xsession|' /etc/xrdp/startwm.sh
	#echo "/usr/bin/i3" >> /etc/xrdp/startwm.sh # DOES NOT WORK FOR SUDO.. USE BELOW
	echo "/usr/bin/i3" | tee -a /etc/xrdp/startwm.sh
fi
echo -e "Done"


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Running stow\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
STOW_FOLDERS=alacritty,bashrc,dmenurc,dosbox,fonts,gitconfig,i3-manjaro,inputrc,nvim-lua,oh-my-posh,tmux,zshrc
pushd $USER_HOME/.dotfiles
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
	read -k 1 -r "stow_current_folder?Stow $folder? (y/n) "
	echo ""
	if [[ $stow_current_folder =~ ^[Yy]$ ]]
	then
		[[ -a $USER_HOME/.$folder ]] && echo "Move existing file to $USER_HOME/.$folder.stowbak" && mv $USER_HOME/.$folder $USER_HOME/.$folder.stowbak
		echo Running stow $folder
		stow -D $folder
		stow $folder
	fi
done
popd
echo -e "Done"


# echo -e "\033[32m ----------------------------------------\033[0m"
# echo -e "\033[32m Now install the VIM plugins\033[0m"
# echo -e "\033[32m ----------------------------------------\033[0m"
# echo Installing Vim Plug
# curl -fLo $USER_HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# chown -R $SUDO_USER $USER_HOME/.local/share/nvim
# echo Running PlugInstall
# source $USER_HOME/.zshrc
# export XDG_CONFIG_HOME=$USER_HOME/.config
# export XDG_DATA_HOME=$USER_HOME/.local/share
# nvim -u $USER_HOME/.config/nvim/init.vim --headless +PlugInstall +qall
# chown -R $SUDO_USER $XDG_CONFIG_HOME
# chown -R $SUDO_USER $XDG_DATA_HOME
# echo -e "Done"


# echo -e "\033[32m ----------------------------------------\033[0m"
# echo -e "\033[32m Build fzf for use in Telescope\033[0m"
# echo -e "\033[32m ----------------------------------------\033[0m"
# pushd $USER_HOME/.local/share/nvim/plugged/telescope-fzf-native.nvim
# make
# popd
# echo -e "Done"


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Install oh-my-posh\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
chmod +x /usr/local/bin/oh-my-posh
echo -e "Done"


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Install nvm to manage NodeJS\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source $USER_HOME/.zshrc
nvm install --lts
nvm use --lts
echo -e "Done"


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Change default shell to zsh\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
chsh -s /bin/zsh root
chsh -s /bin/zsh albert
echo -e "Done"

echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Generate a host specific config file for i3\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
pushd ~/.dotfiles/i3-manjaro/.config/i3/
./generateHostConfig.sh
popd
echo -e "Done"


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m Configure Mouse\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
# https://www.reddit.com/r/linux4noobs/comments/98kicg/set_mouse_speed_sensitivity_in_manjaro_i3/
# https://wiki.archlinux.org/title/Libinput#Via_xinput
# https://www.reddit.com/r/linux4noobs/comments/hnhehw/change_pointer_speed_in_manjaro/
sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee <<'EOF' /etc/X11/xorg.conf.d/35-mouse.conf 1> /dev/null
Section "InputClass"
	Identifier "My Mouse"
	MatchIsPointer "yes"
	Option "AccelerationProfile" "-1"
	Option "AccelerationScheme" "none"
	Option "AccelSpeed" "1"
	Option "ScollMethodEnabled" "0, 0, 1"
	Option "ScrollingPixelDistance" "30"
EndSection
EOF


echo -e "\033[32m ----------------------------------------\033[0m"
echo -e "\033[32m KILL X USING CTRL+ALT+BACKSPACE\033[0m"
echo -e "\033[32m ----------------------------------------\033[0m"
# https://unix.stackexchange.com/a/445
# Modify /etc/X11/xorg.conf or a .conf file in /etc/X11/xorg.conf.d/ with the following.
sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee <<'EOF' /etc/X11/xorg.conf.d/10-terminate-using-ctrl-alt-bs.conf 1> /dev/null
Section "ServerFlags"
    Option "DontZap" "false"
EndSection

Section "InputClass"
    Identifier      "Keyboard Defaults"
    MatchIsKeyboard "yes"
    Option          "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection
EOF




popd





# NOTES

# ----------------------------------------
# DISPLAY LAYOUT
# ----------------------------------------
## Display layout
# https://stackoverflow.com/questions/56618874/how-can-i-permanently-setting-the-screen-layout-arandr-in-manjaro-i3
# 1. Use: xrandr --output DVI-D-0 --off --output HDMI-0 --mode 3840x2160 --pos 2560x0 --rotate normal --output DP-0 --mode 2560x1440 --pos 0x467 --rotate normal --output DP-1 --off --output HDMI-1 --mode 2560x1440 --pos 6400x467 --rotate normal
# OR re-generate
# 2. Open arandr
# 3. Set your desired layout
# 4. Export it (See: ~/.dotfiles/hosts/ganderson/arandr-layout.sh)
# 5. sudo vim /etc/lightdm/Xsession
# 6. Add the exported code *before* the last line
# 7. Reboot


# ----------------------------------------
# NVIDIA DRIVERS
# ----------------------------------------
# LOOKS LIKE THIS COMES WITH THE PROPRIETY INSTALL OF MANJARO i3
# https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-manjaro-linux
# sudo mhwd -a pci nonfree 0300
# sudo reboot
# nvidia-settings
# then enable composition pipeline, this helps with tearing (Not tried "Enable full composition pipeline" yet)


# ----------------------------------------
# redshift
# ----------------------------------------
# -37.793342:175.134606 10 harihari lat, long
# redshift -l -37.793342:175.134606 -t 6500:4000 -g 0.8 -m randr -v
# PLACE IN ~/.dotfiles/i3-manjaro/.config/i3/config.allHosts


# ----------------------------------------
# DEFAULT BROWSER
# ----------------------------------------
# FROM: https://archived.forum.manjaro.org/t/how-can-i-change-the-default-browser-in-i3/60715
# try edit the browser entry in
# /home/$USER/.profile
# then find and replace all Pale Moon entries in
# /home/$USER/.config/mimeapps.list


# ----------------------------------------
# RESILIO SYNC
# ----------------------------------------
# REVISED 26 Oct 2022
# https://wiki.archlinux.org/title/Resilio_Sync
# AFTER: buildApp rslsync (sudo pamac build rslsync)
# sudo systemctl enable rslsync
# sudo systemctl start rslsync
# sudo usermod -aG albert rslsync && \
# sudo usermod -aG rslsync albert && \
# sudo chmod g+rx ~
# sudo chmod g+rw ~/GBox
# sudo chmod g+rw ~/resilio-sync
# LOGIN in http://localhost:8888 and set up username and password
# --
# https://wiki.archlinux.org/title/Resilio_Sync
# mkdir ~/build
# git clone https://aur.archlinux.org/rslsync.git
# cd rslsync
# less PKBUILD # TO MAKE SURE YOURE HAPPY
# mkpkg -sirc
# sudo systemctl enable resilio-sync
# sudo systemctl start resilio-sync
# LOGIN in http://localhost:8888 and set up username and password
# sudo usermod -aG albert rslsync && \
# sudo usermod -aG rslsync albert && \
# sudo chmod g+rx ~
# sudo chmod g+rw ~/GBox
# sudo chmod g+rw ~/resilio-sync


# ----------------------------------------
# Bluetooth Setup
# ----------------------------------------
# UPDATE 1 Nov 2022
# Reboot, 
# Ran: `bluetoothctl`, WITHOUT SUDO,
# https://cri.dev/posts/2021-01-04-Pair-AirPods-with-Linux-Ubuntu/#:~:text=Now%20either%20through%20the%20Bluetooth,bluetooth%20devices%20to%20the%20AirPods.
# entered `scan on`,
# found the device straight away,
# `pair 00:F3:9F:79:68:4B`

# AUTOMATIC PROFILE SELECTION
# https://wiki.archlinux.org/title/PipeWire#Automatic_profile_selection

# https://wiki.archlinux.org/title/bluetoothctl
# sudo systemctl enable bluetooth
# sudo systemctl start bluetooth
# sudo bluetoothctl
# power on
# default-agent
# scan on
# pair 00:F3:9F:79:68:4B
# trust 00:F3:9F:79:68:4B
# connect 00:F3:9F:79:68:4B

# Add to /etc/pulse/default.pa
### Automatically switch to newly-connected devices
#load-module module-switch-on-connect

# ----------------------------------------
# AUDIO Setup
# ----------------------------------------
# https://wiki.archlinux.org/title/PipeWire
# Pipewire may support switching bluebooth profiles for us!

# install_pulse # in manjaro as per help file
# pamac install pipewire-pulse
# 
# Install wireplumber
# pamac install wireplumber



# ----------------------------------------
# RDP
# ----------------------------------------
# FROM: https://rajasekaranp.medium.com/how-to-setup-xrdp-in-manjaro-linux-e176b22bd347
#sudo systemctl enable xrdp.service
#sudo systemctl enable xrdp-sesman.service


# ----------------------------------------
# Wake On Lan, WOL
# ----------------------------------------
# FROM: https://wiki.archlinux.org/title/Wake-on-LAN#Enable_WoL_on_the_network_adapter
# pamac install ethtool
# sudo ethtool enp42s0
# look for Wake-on:.  If it's d, then it's disabled, we're looking for `g`
# ethtool -s interface wol g
# This may not make it persistent!

# sudo nmcli con show
# nmcli c show "Wired connection 1" | grep 802-3-ethernet.wake-on-lan
# sudo nmcli c modify "Wired connection 1" 802-3-ethernet.wake-on-lan magic
