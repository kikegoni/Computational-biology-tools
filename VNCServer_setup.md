## Set up the VNC and open IGV on it. 

 &nbsp;
 
 #Requirements to be done only the first time:  
In Stiletto:   
   
1)) Set the [VNCserver](https://davetang.github.io/listerlab/vnc.html):  

- Set password for your VNCserver:  
```console
[eecheverria@PEB-SRVNIX-STILETTO ~]$ vncpasswd
```    

- Edit ~/.vnc/xstartup file:

```console
[eecheverria@PEB-SRVNIX-STILETTO ~]$ vim ./vnc/xstartup
```  
Delete everything and write this:  
```console
#!/bin/sh
##unset SESSION_MANAGER
#unset DBUS_SESSION_BUS_ADDRESS

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources

xsetroot -solid grey
vncconfig -iconic &
xterm -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &

#twm &
metacity &
#nautilus &
```    

- Go to your local PC and download [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)   
