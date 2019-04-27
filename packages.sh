#!/bin/bash

export DESKTOP=(
  xorg-server
  xorg-xinit
  xorg-xrandr
  xf86-video-intel
  i3
  i3lock
  polybar
)

export PKG=(
  # AUR
  yay

  # drivers
  acpi
  numlockx
  xf86-input-libinput

  # desktop
  polybar
  nitrogen
  rofi
  dmenu
  dunst
  betterlockscreen

  # utils
  unzip
  unrar
  p7zip

  # apps cli
  ranger
  git
  feh
  playerctl

  # apps x
  firefox
  clipit
#  android-studio
#  intellij-idea-ultimate-edition
#  virtualbox
#  docker-git
#  kitematic
#  enpass-bin
# mailspring

  # system
  bind-tools
  net-tools
  nmap
  wget
  curl
  tcpdump
  tcpreplay
  rxvt-unicode-terminfo
  tmux
  vim
  tree
  htop
  scrot
  bat
  neofetch
  tldr
  rainbow
  #pulseaudio
  #  pulseaudio-bluetooth
#  alsa-utils
# grive

  # coding
  python
  python-pip
  go
  nodejs

  # fonts
#  adobe-source-code-pro-fonts
#  noto-fonts

#    pcmanfm
#    mupdf
#    remmina
# wireshark-qt
# vlc
#    sxhkd
#    streamlink
#  diff-so-fancy
#  diffpdf
#  redshift
#  zeal
#  neovim
# franz
#  screenkey


#  odt2txt
#  zathura-pdf-mupdf
#  z-dir-jump-git


#  evernote
#  gitahead
#  charles
#  clockify
#  postman
)

export LENOVO=(
  lenovo-throttling-fix-git
)
