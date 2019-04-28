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
  neovim

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
#  evernote
#  gitahead
#  charles
#  clockify-desktop
#  postman
# vlc
# wireshark-qt
# franz
# blueman

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
  pulseaudio
  pulseaudio-bluetooth
  alsa-utils
  grive

  # coding
  python
  python-pip
  go
  nodejs


#    pcmanfm
#    mupdf
#    remmina
#    sxhkd
#    streamlink
#  diff-so-fancy
#  diffpdf
#  redshift
#  zeal-git
#  odt2txt
#  zathura-pdf-mupdf
#  z-dir-jump-git

)

export LENOVO=(
  lenovo-throttling-fix-git
)
