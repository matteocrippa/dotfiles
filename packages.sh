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

  # apps x
  firefox
  clipit

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

  # coding
  python
  python-pip
  go


# TO REVIEW
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
# mailspring
#  neovim
# franz
#  screenkey


#  pulseaudio
#  alsa-utils
#  adobe-source-code-pro-fonts
#  noto-fonts


#  odt2txt
#  playerctl
#  pulseaudio
#  pulseaudio-bluetooth
#  zathura-pdf-mupdf
#  z-dir-jump-git
#  android-studio
#  intellij-idea-ultimate-edition
#
#  virtualbox
#  docker-git
#  kitematic
#  enpass-bin
#  grive
#  rclone

#
#  evernote
#  gitahead
#  charles
#  clockify
#  postman
)

export LENOVO=(
  lenovo-throttling-fix-git
)
