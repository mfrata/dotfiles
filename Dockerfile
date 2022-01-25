from ubuntu:latest

ARG USER=mfrata

RUN useradd -rm -d /home/${USER} -s /bin/bash -g root -G sudo -u 1000 ${USER}

RUN  echo "${USER}:password" | chpasswd

RUN apt update && apt install -y --no-install-recommends \
  sudo \
  git \
  ansible

USER ${USER}
WORKDIR /home/${USER}
