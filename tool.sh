sudo dnf remove firefox -y
rm -rf ~/.mozilla
rm -rf ~/.cache/mozilla

export LANG=en
xdg-user-dirs-gtk-update
export LANG=zh_CN
xdg-user-dirs-gtk-update

wget https://dl.google.com/linux/direct/google-chrome-unstable_current_x86_64.rpm
sudo dnf install ./google-chrome-unstable_current_x86_64.rpm -y
rm google-chrome-unstable_current_x86_64.rpm

sudo dnf copr enable librehat/shadowsocks -y

echo '[Settings]' > $HOME/.config/gtk-3.0/settings.ini
echo 'gtk-application-prefer-dark-theme = true' >> $HOME/.config/gtk-3.0/settings.ini

echo "PS1='[\[\033[32;32m\]\u@\h\[\033[00m\]:\[\033[34;34m\]\w\[\033[00m\]]\$ '" >> $HOME/.bashrc

sudo dnf update -y
sudo dnf install gcc-c++ cmake clang clang-libs clang-devel python3-devel shadowsocks-libev wireshark qt5 qt-creator qt5-designer qt5-qtbase-doc qt5-qtbase-examples qt-creator-translations autoconf automake bison byacc libtool flex ltrace oprofile strace valgrind indent ccache ibus-table-chinese-wubi-jidian python3-qt5 python3-lxml -y

sudo usermod -a -G wireshark $USER

sudo dnf install vim ctags global the_silver_searcher powerline-fonts -y

# for /etc/default/grub
#GRUB_TIMEOUT=5
#GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
#GRUB_DEFAULT=saved
#GRUB_DISABLE_SUBMENU=true
##GRUB_TERMINAL_OUTPUT="console"
#GRUB_CMDLINE_LINUX="resume=/dev/mapper/fedora_localhost--live-swap rd.lvm.lv=fedora_localhost-live/root rd.lvm.lv=fedora_localhost-live/swap rhgb quiet"
#GRUB_DISABLE_RECOVERY="true"
#GRUB_BACKGROUND="/boot/grub2/themes/system/background.png"

# for /etc/grub.d/40_custom
#set color_highlight=green/black

