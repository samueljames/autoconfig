#!/bin/bash
#code by Samuel James
#copyright GPLv3

if [ $(id -u) != "0" ]; then
	echo "you are not root,please change to root and run this script"
 	exit 1
else

#install application 
read -p "install base application? (yes or no): " install
echo -e "\n"
if [ $install != "yes" ]; then
	echo "you need install base applications"
	exit 1
else


pacman -Syu xorg xorg-xinit xf86-video-nouveau alsa-utils firefox \
firefox-i18n-zh-cn openbox ibus-pinyin openssh xcompmgr rxvt-unicode \
flashplugin wqy-zenhei ttf-dejavu ttf-arphic-uming vim feh git sudo \
scrot gimp

fi

#check install base applications
if [ -f /var/cache/pacman/pkg/openbox*.tar.xz ]; then
	echo "you already install base applications"
	echo -e "\n"
else
	echo "you need install base applications"
	exit 1
fi

#alidit libpng debug
ln -sf /usr/lib/libpng /usr/lib/libpng12.so.0

#configure system
read -p "do you need auto configure system? (yes or no): " select
echo -e "\n"
if [ "$select" = "yes" ]; then

read -p "do you have a user? (yes or no): " haveuser
echo -e "\n"
else
	echo "may be you need create a user"
	echo -e "\n"
	read -p "do you need create a user? " createuser
	if [ "$createuser" = "yes" ]; then
	useradd -m -s /bin/bash $username
	exit 1
fi

if [ "$haveuser" = "yes" ]; then

	read -p "user name is? [default is samuel]: " username
	echo -e "\n"
else
	echo "you are using root"
	username="root"
fi

if [ "$username" = "" ]; then
	username="samuel"

	#initialization user space
	mkdir /home/$username/git 

	mkdir /home/$username/downloads 

	mkdir -p /home/$username/pictures/.background

	mkdir -p /home/$username/.config/openbox

	#configure system
	cp ./conf/init/.xinitrc /home/$username/.xinitrc

	cp ./conf/init/.bashrc /home/$username/.bashrc

	cp ./conf/init/.Xresources /home/$username/.Xresources

	cp ./conf/openbox/autostart /home/$username/.config/openbox/autostart

	cp ./conf/openbox/environment /home/$username/.config/openbox/environment

	cp ./conf/openbox/menu.xml /home/$username/.config/openbox/menu.xml

	cp ./conf/openbox/rc.xml /home/$username/.config/openbox/rc.xml

	cp ./img/pictures/.background/bg.jpg /home/$username/pictures/.background/bg.jpg

	cp ./conf/vim/.vimrc /home/$username/.vimrc

	cp ./conf/aliedit/libaliedit64.so /home/$username/.mozilla/plugins/libaliedit64.so

	cp ./conf/system/mkinitcpio.conf /etc/mkinitcpio.conf

	cp ./conf/system/rc.conf /etc/rc.conf

	#change file to user	
	chown -R $username:$usernmae /home/$username/.mozilla/plugins/libaliedit64.so

	chown -R $username:$usernmae /home/$username/.xinitrc

	chown -R $username:$usernmae /home/$username/git

	chown -R $username:$usernmae /home/$username/downloads

	chown -R $username:$usernmae /home/$username/pictures

	chown -R $username:$usernmae /home/$username/.Xresources

	chown -R $username:$usernmae /home/$username/.config/openbox/autostart

	chown -R $username:$usernmae /home/$username/.config/openbox/environment

	chown -R $username:$usernmae /home/$username/.config/openbox/menu.xml

	chown -R $username:$usernmae /home/$username/.config/openbox/rc.xml

	chown -R $username:$usernmae /home/$username/.vimrc

	chown -R $username:$usernmae /home/$username/pictures/.background/bg.jpg

	chown -R $username:$usernmae /home/$username/.bashrc

	#clear and exit install
	clear
	echo -e "\n"
	echo "your system is configure
maybe you need change to $username and run startx"

fi
fi
fi
