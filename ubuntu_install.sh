
is_dpkg_installed() {
  return $(dpkg-query -W -f='${Status}' ${1} 2>/dev/null | grep -c "ok installed")
}

apt_install() {
  if [ ! is_installed_ ${1} ]; then
    sudo apt install -y ${1};
  else
    echo "${1} is already installed. Skipping..."
  fi   
}


install_pre_prerequisites() {
  # These are prerequisite for the add_apt_repos
  apt_install curl
  apt_install apt-transport-https 
  apt_install ca-certificates
  apt_install software-properties-common
}

add_apt_repos() {
  # Spotify
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

  # Docker
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
}

post_install() {
  # Docker without sudo
  sudo usermod -aG docker ${USER}
  su - ${USER};
}

create_dirs_n_files() {
  # Code dir: Where the sources live
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
}

extra_install() {
  # Ripgrep
  RG_VERSION=11.0.1
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep_${RG_VERSION}_amd64.deb
  sudo dpkg -i ripgrep_${RG_VERSION}_amd64.deb | sudo apt install -f
  rm ripgrep_${RG_VERSION}_amd64.deb
  
  # oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  
  # Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  
  # Aws cli
  pip3 install awscli --upgrade --user
}

main () {

  cd && sudo apt update
  install_pre_prerequisites

  add_apt_repos && sudo apt update

  PACKAGES="
    net-tools \
    git \
    vim \
    zsh \
    tmux \
    make \
    build-essential \
    openvpn \
    python3 \
    python3-pip \
    tree \
    chromium-browser \
    jq \
    gnome-tweaks \
    spotify-client \
    docker-ce \
  "
  for PACKAGE in ${PACKAGES}; do
    apt_install ${PACKAGE};
  done

  create_dirs_n_files

  extra_install

  post_install

  echo "Done!"
}

main


