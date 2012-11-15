#!/bin/bash
#code by Samuel James
#copyright GPLv3

if [ $(id -u) != "0" ]; then
	echo "you are not root,please change to root and run again this script"
 	exit 1
else

applications="xorg xorg-xinit alsa-utils openbox ntpd wqy-zenhei ttf-dejavu ttf-arphic-uming \ 
aria2 chromium openssh  rxvt-unicode flashplugin vim feh sudo scrot \"

select selectd in "install-base-applications" "just-fix-bug" \
"create-a-user" "auto-configure-system" \
"clear-and-exit-install" "uninstall"; do

	case $selectd in

		install-base-applications)

#install application 
pacman -Syu --noconfirm $applications

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
ln -sf /usr/lib/libpng.so /usr/lib/libpng12.so.0
;;

		create-a-user)
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
if [ "$username" = "" ]; then
	username="samuel"
        useradd -m -s /bin/bash $username

fi

#initialization user space
mkdir /home/$username/sources

mkdir /home/$username/downloads 

mkdir -p /home/$username/pictures/.background

mkdir -p /home/$username/.config/openbox

#configure system
cp ./config/user/init/.xinitrc /home/$username/.xinitrc

cp ./config/user/init/.bashrc /home/$username/.bashrc

cp ./config/user/init/.Xresources /home/$username/.Xresources

cp ./config/user/openbox/autostart /home/$username/.config/openbox/autostart

cp ./config/user/openbox/environment /home/$username/.config/openbox/environment

cp ./config/user/openbox/menu.xml /home/$username/.config/openbox/menu.xml

cp ./config/user/openbox/rc.xml /home/$username/.config/openbox/rc.xml

cp -r ./config/images/pictures/.background/bg.jpg /home/$username/pictures/.background/bg.jpg

cp ./config/user/init/.vimrc /home/$username/.vimrc

cp ./config/system/slim.conf /etc/slim.conf

cp ./config/system/inittab /etc/inittab

#change file to user	
chown -R $username:$usernmae /home/$username/.xinitrc

chown -R $username:$usernmae /home/$username/sources

chown -R $username:$usernmae /home/$username/downloads

chown -R $username:$usernmae /home/$username/pictures

chown -R $username:$usernmae /home/$username/.Xresources

chown -R $username:$usernmae /home/$username/.config

chown -R $username:$usernmae /home/$username/.config/openbox/autostart

chown -R $username:$usernmae /home/$username/.config/openbox/environment

chown -R $username:$usernmae /home/$username/.config/openbox/menu.xml

chown -R $username:$usernmae /home/$username/.config/openbox/rc.xml

chown -R $username:$usernmae /home/$username/.vimrc

chown -R $username:$usernmae /home/$username/pictures/.background/bg.jpg

chown -R $username:$usernmae /home/$username/.bashrc

#add user to group
gpasswd -a $username disk

gpasswd -a $username wheel

gpasswd -a $username network

gpasswd -a $username video

gpasswd -a $username audio

gpasswd -a $username storage

gpasswd -a $username dbus
;;

		clear-and-exit-install)

#clear and over install
clear
echo "your system is configure
maybe you need change to $username and run startx"
exit 1
;;

uninstall)
	read -p "warning! you sure uninstall all install application?(yes or no) " uninstall
	if [ "$uninstall" = "yes" ]; then
	pacman -Rscd --noconfirm $applications
	echo "uninstall complete"
else
	echo "not uninstall"
fi
;;

*) echo "error! not a number"
	exit 1
;;

esac
done
fi
