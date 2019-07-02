RG_VERSION=11.0.1
sudo apt update

cd

# Basic tools
sudo apt install net-tools -y # ifconfig
sudo apt install git -y
sudo apt install vim -y
sudo apt install zsh -y
sudo apt install curl -y
# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep_${RG_VERSION}_amd64.deb
sudo dpkg -i ripgrep_${RG_VERSION}_amd64.deb | sudo apt install -f
rm ripgrep_${RG_VERSION}_amd64.deb
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt install tmux -y
sudo apt install make -y

# dotfiles
mkdir code
git clone https://github.com/mfrata/dotfiles.git code/dotfiles
make -C code/dotfiles install

# company aliases
touch .work_aliases

# Spotify
# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
# 3. Update list of available packages
sudo apt-get update
# 4. Install Spotify
sudo apt-get install spotify-client


