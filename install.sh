#!/bin/bash
#code by Samuel James
#copyright GPLv3

if [ $(id -u) != "0" ]; then
	echo "you are not root,please change to root and run this script"
 	exit 1
else

select selectd in "install-base-applications" "just-fix-bug" "create-a-user" "auto-configure-system" "clear-and-exit-install"; do

	case $selectd in

		install-base-applications)

#install application 
pacman -Syu xorg xorg-xinit xf86-video-nouveau alsa-utils firefox \
firefox-i18n-zh-cn openbox ibus-pinyin openssh xcompmgr rxvt-unicode \
flashplugin wqy-zenhei ttf-dejavu ttf-arphic-uming vim feh git sudo \
scrot gimp openntpd slim slim-themes conky sysstat unrar unzip

#check install
if [ -f /var/cache/pacman/pkg/openbox*.tar.xz ]; then
	echo "you already install base applications"
else
	echo "you need install base applications"
	exit 1
fi
;;

	just-fix-bug)
#fix bug
#alidit libpng fixbug
ln -sf /usr/lib/libpng /usr/lib/libpng12.so.0

#touch xorg configure file
Xorg -configure
mv /root/xorg.conf.new /etc/X11/xorg.conf.d/xorg.conf

;;

	have-a-user)
#check have a user
	read -p "user name is? [default is samuel]: " username

if [ "$username" = "" ]; then
	username="samuel"
	useradd -m -s /bin/bash $username
	echo "create user complete"

fi
;;

	auto-configure-system)
#auto configure system

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
;;

	clear-and-exit-install)
	#clear and exit install
	clear
	echo "your system is configure
maybe you need change to $username and run startx"

;;

*) echo "error";exit 1;;
esac
