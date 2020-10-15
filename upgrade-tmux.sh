# Make sure gcc is installed!
sudo apt-get -y remove tmux
sudo apt-get -y install wget tar libevent-dev libncurses-dev
VERSION=3.1
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
tar xf tmux-${VERSION}.tar.gz
rm -f tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure
make
sudo make install
cd -
sudo rm -rf /usr/local/src/tmux-\*
sudo mv tmux-${VERSION} /usr/local/src
sudo killall -9 tmux

