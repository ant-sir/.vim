
wget https://dl.google.com/linux/direct/google-chrome-unstable_current_x86_64.rpm
sudo dnf install ./google-chrome-unstable_current_x86_64.rpm -y
rm google-chrome-unstable_current_x86_64.rpm

sudo dnf copr enable librehat/shadowsocks -y

echo '[Settings]' > $HOME/.config/gtk-3.0/settings.ini
echo 'gtk-application-prefer-dark-theme = true' >> $HOME/.config/gtk-3.0/settings.ini

echo "PS1='[\[\033[32;32m\]\u@\h\[\033[00m\]:\[\033[34;34m\]\w\[\033[00m\]]\$ '" >> $HOME/.bashrc

sudo dnf update -y
sudo dnf install vim ctags global the_silver_searcher powerline-fonts gcc-c++ cmake clang clang-libs clang-devel python3-devel shadowsocks-libev wireshark qt5 qt-creator qt5-designer qt5-qtbase-doc qt5-qtbase-examples qt-creator-translations autoconf automake bison byacc ibus-table-chinese-wubi-jidian python3-qt5 python3-lxml -y

sudo usermod -a -G wireshark $USER

#gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

export LANG=en
xdg-user-dirs-gtk-update
export LANG=zh_CN
xdg-user-dirs-gtk-update

#{
#    "server":"13.115.145.175",
#    "server_port":443,
#    "local_port":1080,
#    "password":"zyl198879",
#    "timeout":60,
#    "method":"aes-256-cfb"
#}
