#!/bin/bash

#initialization system
mkdir ~/git ~/downloads ~/pictures

#configure system
cp ./conf/init/* ~/
cp ./conf/openbox/* ~/.config/openbox/
cp ./img/pictures/ -r ~/
cp ./conf/vim/* ~/
cp ./conf/aliedit/* ~/.mozilla/plugins/
cp ./conf/system/* /etc/

#install applications
pacman -Syu xorg xorg-xinit xf86-video-nouveau alsa-utils firefox \
firefox-i18n-zh-cn openbox ibus-pinyin openssh xcompmgr rxvt-unicode \
flashplugin wqy-zenhei ttf-dejavu ttf-arphic-uming vim feh git sudo \
scrot gimp
