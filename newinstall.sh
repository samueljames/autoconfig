#!/bin/bash
#code by Samuel James
#copyright GPLv3

if [ $(id -u) != "0" ]; then
	echo "you are not root,please change to root and run this script"
 	exit 1
else

select var in "no run it,debug" "install base applications" "just fix bug" "create a user" "auto configure system" "clear and exit install"; do

	while [ "$return" ]; do
	if [ "$return" = "0" ]; then

	break
fi
done
done

#install application 
if [ $var != "install base applications" ]; then
	echo "you need install base applications"
	exit 1
else

pacman -Syu xorg xorg-xinit xf86-video-nouveau alsa-utils firefox \
firefox-i18n-zh-cn openbox ibus-pinyin openssh xcompmgr rxvt-unicode \
flashplugin wqy-zenhei ttf-dejavu ttf-arphic-uming vim feh git sudo \
scrot gimp openntpd slim slim-themes conky sysstat unrar unzip

fi

#check install
if [ -f /var/cache/pacman/pkg/openbox*.tar.xz ]; then
	echo "you already install base applications"
else
	echo "you need install base applications"
	exit 1
fi

#fix bug
#alidit libpng fixbug
if [ "$var" = "just fix bug" ]; then
ln -sf /usr/lib/libpng /usr/lib/libpng12.so.0

#touch xorg configure file
Xorg -configure
mv /root/xorg.conf.new /etc/X11/xorg.conf.d/xorg.conf

fi

#check have a user
if [ "$var" = "create a user" ]; then

	read -p "user name is? [default is samuel]: " username
	echo "create user complete"

if [ "$username" = "" ]; then
	username="samuel"
	useradd -m -s /bin/bash $username

fi
fi

#auto configure system
if [ "$var" = "auto configure system" ]; then

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

	cp ./conf/init/.conkyrc  /home/$username/.conkyrc

	cp ./conf/system/mkinitcpio.conf /etc/mkinitcpio.conf

	cp ./conf/system/rc.conf /etc/rc.conf

	cp ./conf/system/slim.conf /etc/slim.conf

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
fi

	#clear and exit install
	if [ "$var" = "clear and exit install" ]; then
	clear
	echo "your system is configure
maybe you need change to $username and run startx"
	return="0"
fi
fi
