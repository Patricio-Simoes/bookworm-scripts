FROM archlinux:latest

RUN groupadd --gid 1000 dev \
  && useradd --uid 1000 --gid dev --shell /bin/bash --create-home dev

RUN pacman -Syu --noconfirm \
  && pacman -S --noconfirm python tk python-virtualenv \
  && pacman -Scc --noconfirm

USER dev

WORKDIR /home/dev
