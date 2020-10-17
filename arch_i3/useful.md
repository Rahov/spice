# Useful


### Pacman
```bash
# Pac-tools

pacman -Ss        # List packages
pacman -Scc       # Clear cache
pacman -Rns $(pacman -Qtdq)        # remove orphans
pacman -Qet # list explicetly packages
pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h      # list & sort installed
pacman -Sy archlinux-keyring && sudo pacman -Syu # update procedure after prolonged absence

# Mirror Lists
reflector --verbose --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
```
## Nvidia hook
```
$ vim /etc/pacman.d/hooks/nvidia.hook

[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
# Change the linux part above and in the Exec line if a different kernel is used

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```


### Misc
```bash 
# copy to a USB
dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync

# Debug
kwin_x11 --replace          # detect errors in kwin (KDE specific)
hwclock --debug        # corrects the system clock

# System Errors
systemctl --failed
journalctl -p 3 -xb

# Disable screen saver
xset s off
xset -dpms

# view what shell is linked
ls -l /bin/sh

# Change shell (to dash)
ln -sfT dash /usr/bin/sh

# Optimization
$ vim /etc/makepkg.conf

COMPRESSXZ=(xz -c -T 4 -z -)
MAKEFLAGS="-j4"

# Clear cache
fc-cache -f -v

# Enable trim
systemctl enable fstrim.timer
```


### Internet
```bash
# figure out the name of the device
ip link

# Set that interface up
ip link set wlp6s0 up

# connect via iw
sudo iw dev wlp6s0 scan | grep -iEA15 talktalk

# Effective PCI print (example: networking)
lspci -nnk | grep -iEA3 "(network|ethernet)"
```

### Thumbnailer webp
```bash
$ vim /usr/share/thumbnailers/webp.thumbnailer

[Thumbnailer Entry]
Version=1.0
Encoding=UTF-8
Type=X-Thumbnailer
Name=webp Thumbnailer
MimeType=image/webp;
Exec=/usr/bin/convert -thumbnail %s %i %o
```
### Thunar 'Open with vim' problem
```
$ vim /usr/share/applications/vim.desktop
TryExec=vim
Exec=alacritty -e "vim" %F # alacritty or any other terminal of choice
Terminal=false
