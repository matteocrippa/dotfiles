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

  xf86-input-libinput

  # desktop
  polybar
  nitrogen
  rofi
  dmenu
  dunst

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


#  pulseaudio
#  alsa-utils
#  adobe-source-code-pro-fonts
#  noto-fonts
#  diff-so-fancy
#  diffpdf
#  lolcat

#  numlockx
#  odt2txt
#  playerctl
#  pulseaudio
#  pulseaudio-bluetooth
#  rclone
#  redshift
#  shfmt
#  tldr
#  wmctrl
#  xcape
#  xclip
#  zathura-pdf-mupdf
#  zeal
#  betterlockscreen
#  clipit
#  direnv
#  franz
#  insect
#  mailspring
#  neovim
#  rainbow
#  sc-im
#  screenkey
#  watchexec
#  z-dir-jump-git
#  android-studio
#  intellij-idea-ultimate-edition
#
#  virtualbox
#  docker-git
#  kitematic
#  enpass-bin
#  grive
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
