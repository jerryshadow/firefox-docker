#!/bin/bash
rm -f /tmp/.X1-lock
rm -f /tmp/.X11-unix/*
vncserver -kill :1
rm -f /root/.vnc/*.log
rm -f /root/.vnc/*.pid

vncserver -geometry 1920x1080 -SecurityTypes=None

export DISPLAY="`hostname`:1"
export XMODIFIERS=@im=SCIM
export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
#export XMODIFIERS GTK_IM_MODULE
scim -d

while true  
do  
    firefox
    sleep 1
done
