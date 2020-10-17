BASEDIR=$(dirname "$0")

sudo apt-get update
sudo apt-get install -y build-essential
$BASEDIR/init-quick-vimrc.sh
$BASEDIR/init-tmux.sh
$BASEDIR/upgrade-tmux.sh
cp $BASEDIR/.quick-vimrc $HOME/.vimrc
cp $BASEDIR/.tmux.conf $HOME/.tmux.conf
