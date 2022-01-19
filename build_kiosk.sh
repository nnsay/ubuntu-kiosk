#!/usr/bin/env bash

##################################################################
# All script base on ubuntu 18.04.3 chinese minimal installation.
# default account
#  user name: ngiq
#  password:  123456
##################################################################
set -e

KIOSKSPACE=$(pwd)
export KIOSKSPACE
export DESKTOP=桌面
if [ ! -e ~/Desktop ]; then
  DESKTOP=Desktop
fi

echo "----install helpful tools: START----"
sudo apt install openssh-server -y
echo "----install helpful tools: END----"

echo "----remove pre-install software: START----"
sudo apt autoremove firefox -y
sudo apt autoremove gnome-software -y
sudo apt autoremove update-notifier -y
sudo apt autoremove gnome-shell-extension-ubuntu-dock -y
echo "----remove pre-install software END----"

echo "----home desktop configuration: START----"
# control center
cd /home/$USER/$DESKTOP
rm -rf control_center.desktop
touch control_center.desktop
cat >control_center.desktop <<EOF
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=gnome-control-center
Name[en_US]=control center
Icon[zh_CN]=gnome-control-center
Name[zh_CN]=控制中心
Exec=gnome-control-center network
Name=控制中心
Icon=gnome-control-center
EOF
chmod +x control_center.desktop
gio set control_center.desktop "metadata::trusted" yes
# application
mkdir -p ~/.app
cp $KIOSKSPACE/app/app.AppImage ~/.app/
cp $KIOSKSPACE/image/app-logo.png ~/.app/
rm -rf app.desktop
touch app.desktop
cat >app.desktop <<EOF
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=/home/$USER/.app/app-logo.png
Name[en_US]=Neural Galaxy
Icon[zh_CN]=/home/$USER/.app/app-logo.png
Name[zh_CN]=优脑银河
Exec=/home/$USER/.app/app.AppImage
Name=优脑银河
Icon=/home/$USER/.app/app-logo.png
EOF
chmod +x ~/.app/app.AppImage
chmod +x app.desktop
gio set app.desktop "metadata::trusted" yes
cp -R $KIOSKSPACE/tools ~/.app/
chmod +x ~/.app/tools/config_server_ip.sh
cd $KIOSKSPACE
echo "----home desktop configuration: END---"

echo "----gnome configuration: START----"
# set timezone
sudo timedatectl set-timezone Asia/Shanghai
# desktop icon
gsettings set org.gnome.nautilus.desktop trash-icon-visible false
gsettings set org.gnome.nautilus.icon-view default-zoom-level largest
# hide trash icon
gsettings set org.gnome.nautilus.desktop trash-icon-visible false
# disable top bar
echo 'echo "#panel, #panel * {
    height: 0px;
    color: rgba(0,0,0,0);
}" >>/usr/share/gnome-shell/theme/ubuntu.css' | sudo bash
# copy all background image
sudo cp $KIOSKSPACE/image/lock_screen.jpg /usr/share/backgrounds/lock_screen.jpg
sudo cp $KIOSKSPACE/image/home_background.jpg /usr/share/backgrounds/home_background.jpg
sudo cp $KIOSKSPACE/image/ng_logo.png /usr/share/plymouth/themes/ubuntu-logo/ng_logo.png
# set lock background image
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/lock_screen.jpg'
# set desktop background image
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/home_background.jpg'
# change purple background
sudo sed -i "s/44,0,30/0,0,0/" /usr/share/plymouth/themes/default.grub
sudo sed -i "s/44,0,30/0,0,0/" /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub
sudo sed -i "s/44,0,30/0,0,0/" /boot/grub/grub.cfg
# change theme picture
sudo sed -i "s/0.16, 0.00, 0.12/0, 0, 0/" /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
sudo sed -i "s/ubuntu-logo.png/ng_logo.png/" /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
sudo sed -i "s/ubuntu-logo16.png/ng_logo.png/" /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
# disable clock on lock screen
sudo sed -i 's/72pt;/0pt;/' /usr/share/gnome-shell/theme/ubuntu.css
sudo sed -i 's/28pt;/0pt;/' /usr/share/gnome-shell/theme/ubuntu.css
echo "----gnome configuration: END----"

echo "----system configuration: START----"
# auto start applicaton
mkdir -p ~/.config/autostart
cp ~/$DESKTOP/app.desktop ~/.config/autostart
# auto login
echo "echo \"# GDM configuration storage
#
# See /usr/share/gdm/gdm.schemas for a list of available options.

[daemon]
# Uncoment the line below to force the login screen to use Xorg
#WaylandEnable=false

# Enabling automatic login
AutomaticLoginEnable=true
AutomaticLogin=$USER

[security]

[xdmcp]

[chooser]

[debug]
\">/etc/gdm3/custom.conf" | sudo bash
# disable auto upgrade
sudo sed -i "s/1/0/" /etc/apt/apt.conf.d/20auto-upgrades
# lock screen time second
gsettings set org.gnome.desktop.session idle-delay 900
# disable switch user
gsettings set org.gnome.desktop.lockdown disable-user-switching true
gsettings set org.gnome.desktop.screensaver user-switch-enabled false
# disable unlock screen
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
# input method, english can ignore this
gsettings set org.gnome.desktop.input-sources sources "[('ibus', 'libpinyin')]"
# disbale notification
gsettings set org.gnome.desktop.notifications show-in-lock-screen false
# disbale keybinding:
gsettings set org.gnome.shell.keybindings toggle-message-tray []
gsettings set org.gnome.shell.keybindings open-application-menu []
gsettings set org.gnome.shell.keybindings toggle-application-view []
gsettings set org.gnome.shell.keybindings focus-active-notification []
gsettings set org.gnome.shell.keybindings toggle-overview []
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left []
gsettings set org.gnome.desktop.wm.keybindings unmaximize []
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu []
gsettings set org.gnome.desktop.wm.keybindings cycle-windows []
gsettings set org.gnome.desktop.wm.keybindings cycle-panels-backward []
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up []
gsettings set org.gnome.desktop.wm.keybindings cycle-group-backward []
gsettings set org.gnome.desktop.wm.keybindings begin-move []
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down []
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu []
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right []
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last []
gsettings set org.gnome.desktop.wm.keybindings cycle-panels []
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 []
gsettings set org.gnome.desktop.wm.keybindings switch-panels []
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward []
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward []
gsettings set org.gnome.desktop.wm.keybindings switch-applications []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left []
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized []
gsettings set org.gnome.desktop.wm.keybindings begin-resize []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last []
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward []
gsettings set org.gnome.desktop.wm.keybindings switch-group []
gsettings set org.gnome.desktop.wm.keybindings cycle-group []
gsettings set org.gnome.desktop.wm.keybindings close []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right []
gsettings set org.gnome.desktop.wm.keybindings show-desktop []
gsettings set org.gnome.settings-daemon.plugins.media-keys logout []
gsettings set org.gnome.settings-daemon.plugins.media-keys screenreader []
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot []
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal []
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip []
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier []
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-in []
gsettings set org.gnome.settings-daemon.plugins.media-keys video-out []
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip []
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip []
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-out []
gsettings set org.gnome.settings-daemon.plugins.media-keys screencast []
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver []
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot []
gsettings set org.gnome.Terminal.Legacy.Keybindings:/ new-tab ''
gsettings set org.gnome.Terminal.Legacy.Keybindings:/ new-window ''
gsettings set org.gnome.mutter overlay-key ""
# delete user password: 1. keyrings requrie for chromium; 2. auto login after pressing power button for long time
sudo passwd -d $USER
seahorse # delete keyrings password
echo "----system configuration: END----"

echo "----machine id: START----"
if [ ! -f /ng/version ]
then
    echo 'create version:'
    sudo mkdir -p /ng/
    echo "uuidgen > /ng/version" | sudo bash
else
    echo "verion exist:"
fi
cat /ng/version
echo "----machine id: END----"

echo "----reboot----"
reboot
