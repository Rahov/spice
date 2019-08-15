# Useful Commands

```bash

# pacman 'n' stuff

pacman -Ss             # List packages
pacman -Scc       # Clear cache
pacman -Rns $(pacman -Qtdq)        # remove orphans
pacman-mirrors --fasttrack && sudo pacman -Syyu # manjaro exclusive
pacman -Qet # list explicetly packages
pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h      # list & sort installed

# syncronising mirror-list via reflector
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist


# copy to a USB
dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync

# make with number of cores
make -j$(nproc)           

# Debug
kwin_x11 --replace          # detect errors in kwin (KDE specific)
hwclock --debug        # corrects the system clock

# System Errors
systemctl --failed
journalctl -p 3 -xb

# view what shell is linked
ls -l /bin/sh

# Change shell (to dash)
ln -sfT dash /usr/bin/sh

# Optimization
vim /etc/makepkg.conf

COMPRESSXZ=(xz -c -T 4 -z -)
MAKEFLAGS="-j4"

# Clear cache
fc-cache -f -v

```

# Enable Trim

```bash

systemctl enable fstrim.timer

```

# Looking for drivers
```bash

# Effective PCI print (example: networking)
lspci -nnk | grep -iEA3 "(network|ethernet)"

```
# internet
```bash
# figure out the name of the device
ip link

# Set that interface up
ip link set wlp6s0 up

# connect via iw
sudo iw dev wlp6s0 scan | grep -iEA15 talktalk

```
### Discord Keys 

```bash

gpg --recv-keys B6C8F98282B944E3B0D5C2530FC3042E345AD05D
gpg --recv-keys 474E22316ABF4785A88C6E8EA2C794A986419D8A

```
