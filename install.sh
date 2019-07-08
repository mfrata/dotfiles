
is_installed_() {
  return $(dpkg-query -W -f='${Status}' ${1} 2>/dev/null | grep -c "ok installed")
}

install_() {
  if [ ! is_installed_ ${1} ]; then
    sudo apt install -y ${1};
  else
    echo "${1} is already installed. Skipping..."
  fi   
}

sudo apt update

cd

# Basic tools
install_ net-tools # ifconfig
install_ git
install_ vim
install_ zsh
install_ curl
install_ tmux
install_ make
install_ openvpn
install_ python3
install_ python3-pip


# ripgrep
if [ ! is_installed_ ripgrep ] then;
  RG_VERSION=11.0.1
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep_${RG_VERSION}_amd64.deb
  sudo dpkg -i ripgrep_${RG_VERSION}_amd64.deb | sudo apt install -f
  rm ripgrep_${RG_VERSION}_amd64.deb
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Code dir: Where the source lives
if [ ! -d ~/code ]; then
  mkdir code
fi

# dotfiles
if [ ! -d ~/code/dotfiles ]; then
  git clone https://github.com/mfrata/dotfiles.git code/dotfiles
  make -C code/dotfiles install
fi

# company aliases
if [ ! -f .work_aliases ]; then
  touch .work_aliases
fi

# Spotify
if [! is_installed_ spotify-client ]; then
  # 1. Add the Spotify repository signing keys to be able to verify downloaded packages
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
  # 2. Add the Spotify repository
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  # 3. Update list of available packages
  sudo apt-get update
  # 4. Install Spotify
  sudo apt-get install spotify-client
fi

# Docker
if [ ! is_installed_ docker ]; then
  sudo apt install apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  sudo apt update
  sudo apt install docker-ce -y
  # Docker without sudo
  sudo usermod -aG docker ${USER}
  su - ${USER};
fi

# Docker Compose
if [ ! is_installed_ docker-compose ]; then
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi
sudo apt install tree n
