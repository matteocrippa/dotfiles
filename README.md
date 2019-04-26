# T480 Manjaro

## Setup
- Lenovo T480
- Crucial 32 GB
- NVMe Toshiba RC 100 - 240G
- SSD Crucial MX500


## Install

```jshelllanguage
sudo pacman -Sy git make
git clone https://github.com/matteocrippa/dotfiles
cd dotfiles
sudo make setup
```

Once ended exec `setup` and proceed with visual selecting:

- mount partition (no format)
- mount /boot as boot (not efi)
- prepare pacman
- install linux 5.0 + yay
- install i3
- install minimal
- install video driver
- install systemd-boot
- fstab uefi

Proceed chrooting and:

```jshelllanguage
cd /tmp
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
cd dotfiles
make chroot
exit
reboot
```

Continue now



Once the prompt is finished, you are _chrooted_ in your env, so proceed with:

```jshelllanguage
sudo pacman -Sy make git
cd /tmp
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
cd dotfiles
make chroot
mv /keyfile /root/keyfile
exit
umount -R /mnt
reboot
```

On restart proceed with

```jshelllanguage
pacman -Sy sudo
useradd -m -G wheel -s /bin/bash matteo
passwd matteo
visudo # uncomment wheel group
exit # login as user
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
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
