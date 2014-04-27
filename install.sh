# !/bin/bash
# code by Samuel James
# copyright GPLv3

if [ $(id -u) != "0" ]; then
	echo "you are not root,please change to root and run again this script"
 	exit 1
else

applications="xorg xorg-xinit alsa-utils openbox ntp wqy-microhei ttf-dejavu ttf-arphic-uming
wget chromium openssh rxvt-unicode flashplugin vim feh sudo scrot \
rsync cronie dnsmasq numlockx xcompmgr encfs"

select selectd in "install-base-applications" "just-fix-bug" \
"create-a-user" "auto-configure-system" \
"clear-and-exit-install" "uninstall"; do

	case $selectd in

		install-base-applications)

# install application 
pacman -Syu --noconfirm $applications

# check install
if [ -f /var/cache/pacman/pkg/openbox*.tar.xz ]; then
	echo "you already install base applications"
else
	echo "you need install base applications"
	exit 1
fi
;;

		just-fix-bug)
# fix bug
# alidit libpng fixbug
ln -sf /usr/lib/libpng.so /usr/lib/libpng12.so.0
echo "fix bug complete"
;;

		create-a-user)
# check have a user
read -p "user name is? [default is samuel]: " username

if [ "$username" = "" ]; then
	username="samuel"
	useradd -m -s /bin/bash $username
	echo "create user complete"
fi
;;

		auto-configure-system)
# auto configure system
if [ "$username" = "" ]; then
	username="samuel"
        useradd -m -s /bin/bash $username

fi

# select background image
echo "select your background image"
select selectimage in "notebook" "computer"; do

	case $selectimage in

		notebook)
cp ./config/images/notebook.jpg /home/$username/pictures/.background/bg.jpg
break
;;

		computer)
cp ./config/images/computer.jpg /home/$username/pictures/.background/bg.jpg
break
;;

		*)

echo "not a valid number"
;;

esac
done

# initialization user space
mkdir /home/$username/document

mkdir /home/$username/downloads 

mkdir /home/$username/pictures/

mkdir /home/$username/.config/openbox

mkdir /home/$username/.config/openbox/background

# configure system
cp ./config/user/init/.xinitrc /home/$username/.xinitrc

cp ./config/user/init/.bashrc /home/$username/.bashrc

cp ./config/user/init/.Xresources /home/$username/.Xresources

cp ./config/user/openbox/autostart /home/$username/.config/openbox/autostart

cp ./config/user/openbox/environment /home/$username/.config/openbox/environment

cp ./config/user/openbox/menu.xml /home/$username/.config/openbox/menu.xml

cp ./config/user/openbox/rc.xml /home/$username/.config/openbox/rc.xml

cp ./config/user/init/.vimrc /home/$username/.vimrc

cp ./config/user/applications/.muttrc /home/$username/.muttrc

# change file to user	
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

chown -R $username:$usernmae /home/$username/.config/openbox/background/bg.jpg

chown -R $username:$usernmae /home/$username/.bashrc
;;

		clear-and-exit-install)

# clear and over install
clear
echo "system configure complete"
exit 1
;;

        uninstall)
    read -p "warning! you sure uninstall $applications? (yes or no) " uninstall
	if [ "$uninstall" = "yes" ]; then
	pacman -Rscd --noconfirm $applications
	echo "uninstall complete"
else
	echo "not uninstall"
fi
;;

*) 
    echo "not a valid number"
;;

esac
done
fi
