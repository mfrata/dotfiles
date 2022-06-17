from ubuntu:latest

ARG USER=mfrata
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -rm -d /home/${USER} -s /bin/bash -g root -G sudo -u 1000 ${USER}

RUN  echo "${USER}:password" | chpasswd

RUN apt update && apt install -y --no-install-recommends \
  sudo \
  git \
  ansible \
  python3-apt python3-setuptools python3-pip

USER ${USER}
WORKDIR /home/${USER}
