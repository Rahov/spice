# Useful Commands

```bash
# pacman 'n' stuff

$ pacman -Ss             # List packages
$ pacman -Scc       # Clear cache
$ pacman -Rns $(pacman -Qtdq)        # remove orphans
$ pacman-mirrors --fasttrack && sudo pacman -Syyu # manjaro exclusive
$ pacman -Qet # list explicetly packages
$ pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h      # list & sort installed


# copy to a USB
$ dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync

# make with number of cores
$ make -j$(nproc)           

# Debug
$ kwin_x11 --replace          # detect errors in kwin (KDE specific)
$ hwclock --debug        # corrects the system clock

# System Errors
$ systemctl --failed
$ journalctl -p 3 -xb

# Change shell (to dash)
$ ln -sfT dash /usr/bin/sh

# Optimization
$ vim /etc/makepkg.conf

COMPRESSXZ=(xz -c -T 4 -z -)
MAKEFLAGS="-j4"

# Clear cache
$ fc-cache -f -v
```

# Enable Trim
$ systemctl enable fstrim.timer

### Discord Keys 

```bash
$ gpg --recv-keys B6C8F98282B944E3B0D5C2530FC3042E345AD05D
$ gpg --recv-keys 474E22316ABF4785A88C6E8EA2C794A986419D8A
```
