# T480 Manjaro/Archlinux

## Setup
- Lenovo T480
- Crucial 32 GB
- NVMe Toshiba RC 100 - 240G
- SSD Crucial MX500


## Install

```shell
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
git clone https://github.com/nelsonmestevao/spells   ~/.spells
```

Then proceed with

```shell
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
cd ~/.dotfiles
chmod +x *.sh
sudo pacman -Sy make
sudo su 
make gpt
```

System will autoreboot

```shell
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
cd ~/.dotfiles
chmod +x *.sh
sudo pacman -Sy make
sudo su
make lvm
```

Once installation has finished and laptop rebooted:

```shell
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
git clone https://github.com/nelsonmestevao/spells   ~/.spells
cd ~/.dotfiles
chmod +x *.sh
make install
```

## Uninstall

```shell
cd ~/.dotfiles
make uninstall
cd ~
rm -rf ~/.dotfiles
rm -rf ~/.spells
```

## Disclaimer

As you probably know, you shouldn't just run my Makefile without reading it
first. And if you read it, you will understand that it calls other scripts like
`install.sh` which depend on `helpers.sh`. Read those, it's the only way that
you can trust what it is doing.

## License

This repository is licensed under the [WTFNMFPL](LICENSE.txt).
