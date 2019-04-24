# T480 Manjaro/Archlinux

## Setup
- Lenovo T480
- Crucial 32 GB
- NVMe Toshiba RC 100 - 240G
- SSD Crucial MX500


## Install

```jshelllanguage
sudo pacman -Sy make git
git clone https://github.com/matteocrippa/dotfiles ~/.dotfiles
cd ~/.dotfiles
chmod +x *.sh
make gpt
make lvm
```

Then proceed with:

```jshelllanguage
vi /etc/locale.gen # uncomment en_US.UTF-8 UTF-8
locale-gen
ln -s /usr/share/zoneinfo/America/Denver /etc/localtime
hwlock --systohc --utc
echo 'hostname' > /etc/hostname
passwd # set root password
vi /etc/pacman.conf # uncomment multilib
vi /etc/pacman.d/mirrorlist # https://www.archlinux.org/mirrorlist/
pacman -S intel-ucode
pacman -S dialog wpa_supplicant # if install on wireless
```

And proceed with bootloader

```jshelllanguage
vi /etc/mkinitcpio.conf
# HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 filesystems fsck)
mkinitcpio -p linux
bootctl --path=/boot install
vi /boot/loader/loader.conf
# default arch
# editor 0
blkid # note UUID
```

Vi `/boot/loader/entries/arch.conf` and proceed with

```jshelllanguage
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options cryptdevice=UUID=<UUID_HERE>:cryptlvm root=/dev/mapper/foo_group-root quiet rw
```

Continue with

```jshelllanguage
exit
unmount -R /mnt
reboot
```

After boot

```jshelllanguage
pacman -S sudo
useradd -m -G wheel -s /bin/bash user
passwd user
visudo # uncomment wheel group
exit # login as user
sudo pacman -S openssh
sudo vi /etc/ssh/sshd_config # change a few things
sudo systemctl enable sshd
sudo systemctl start sshd
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
