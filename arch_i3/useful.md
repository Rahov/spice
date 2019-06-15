## Useful Commands

```bash
# pacman

$ pacman -Ss             # List packages
$ sudo pacman -Scc       # Clear cache
$ sudo pacman -Rns $(pacman -Qtdq)        # remove orphans
$ sudo pacman-mirrors --fasttrack && sudo pacman -Syyu # manjaro exclusive
$ sudo pacman -Qet # list explicetly packages
$ sudo pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h      # list & sort installed


# copy to a USB
dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync

# make with number of cores
make -j$(nproc)           

# Debug
kwin_x11 --replace          # detect errors in kwin (KDE specific)
sudo hwclock --debug        # corrects the system clock

# System Errors
sudo systemctl --failed
sudo journalctl -p 3 -xb

# Change shell
ln -sfT dash /usr/bin/sh
```

### Discord codes 

```bash
$ gpg --recv-keys B6C8F98282B944E3B0D5C2530FC3042E345AD05D
$ gpg --recv-keys 474E22316ABF4785A88C6E8EA2C794A986419D8A
```
