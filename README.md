T480 Manjaro Setup

## Pre install

On pre-install follow those steps, my T480 has 2 disk (NVME + SSD).

- Partition NvME in 2 disk (256M EFI + LVM)
- NvME LVM need to be split in 2 parts ( 32G Swap + Rest as ROOT)
- SSD is LVM with 100% partition as HOME

## Install

I follow a very modular approach. If you don't want something you can just
remove it's folder. Imagine you don't want Neovim. You can just delete `nvim`
folder. It's that simple.


Start by cloning my `dotfiles` into `~/.dotfiles`. You should do the same with
my `spells` repository. Some scripts needed are there.

```shell
git clone https://github.com/nelsonmestevao/dotfiles ~/.dotfiles
git clone https://github.com/nelsonmestevao/spells   ~/.spells
```

Depending on your Linux distribution you should change the `distro.sh`
accordingly.

```shell
cd ~/.dotfiles
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
