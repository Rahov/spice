# Arch Linux installation guide

Please refer to the [Arch Linux](https://wiki.archlinux.org) wiki for additional details on the process.

## Pre-installation  

1. Pre-requisites 

For UEFI motherboards, verify UEFI mode:
```bash
$ efivar -l
```

Connecting to the network (if not wired):
```bash
$ wifi-menu
```

Review the partition names that will be used: 
```bash
$ lsblk
#or
$ fdisk -l
```

2. Partitioning

```bash
$ cfdisk /dev/nvme0n1pX 	#for nvme drives 
#or
$ cfdisk /dev/xdaX	#for ssd drives 
```
*Note:* _X denotes a number which you should have figured out from the previous command._

3. File systems

```bash
$ mkfs.fat -F32 /dev/nvme0n1p1
$ mkfs.ext4 /dev/nvme0n1p2
$ mount /dev/nvme0n1p2 /mnt
$ mkdir /mnt/boot
$ mount /dev/nvme0n1p1 /mnt/boot
```

*Note: I'm assuming nvme0n1p1 is the EFI system partition and nvme0n1p2 is the root partition. Addtioanlly, swap is not included.*

## Installation

1. Installing the system 

```bash
$ pacstrap /mnt base base-devel linux-lts linux-lts-headers zsh git dialog wpa_supplicant iw vim linux-firmware e2fsprogs exfatprogs ntfs-3g
```

*Note: Only base is needed for the system, however, base-devel is strongly recommended. Other applciations within the wrapper are optional and can be removed.*

2. Generating an fstab file

```bash
$ genfstab -U /mnt >> /mnt/etc/fstab
```

3. Entering into the system 

```bash
$ arch-chroot /mnt /bin/bash
```

4. Installing a bootloader

```bash
$ bootctl install
```

*Note: grub is a nice alternative to the bootctl installer, however, if you are using MBR, grub is requred.*

5. Creating a boot entry

```bash
$ vim /boot/loader/entries/arch.conf

title 	Arch Linux
linux 	/vmlinuz-linux
initrd  /intel-ucode.img	#only if you've installed intel-ucode
initrd	/initramfs-linux.img quiet splash
options root=/dev/sda2 rw quiet splash nvidia-drm.modset=1
```

*Note: linux-lts can be used as a boot entry instead* 

6. Setting the default entry

```bash
$ vim /boot/loader/loader.conf

timeout 3
default arch
console-mode auto
```

7. Enabling Network Manager

```bash
systemctl enable NetworkManger
```

8. Reboot and test

This phase is completely optional, however, it recommended to test wether any mistakes have been made and if the system will boot.

```bash
$ exit
$ umount /dev/sda1
$ umount /dev/sda2
$ reboot
```

## Post-installation

1. Setup a root password
```bash 
$ passwd
```

2. Setup a hostname
```bash 
$ echo host_name > /etc/hostname
```

4. Setup a user
```bash 
$ useradd -m -G wheel user_name
$ passwd user_name
```

5. Sudo privilage 
```bash 
vim /etc/sudoers

# uncomment to allow members of group...
%wheel ALL=(ALL) ALL
```

6. Generate Locales
```bash 
$ echo LANG=en_US.UTF-8 >> /etc/locale.conf
$ echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
$ echo LANG=en_GB.UTF-8 >> /etc/locale.conf
$ echo en_GB.UTF-8 UTF-8 >> /etc/locale.gen
$ locale-gen
$ localectl set-locale LANG=en_US.UTF-8
```

7. Timezone and hardware clock
```bash 
# timezone
$ tzselect
$ timedatectl set-timezone 'Europe/London'
$ timedatectl set-ntp true
$ hwclock --systohc --utc
```

8. Adding modules (specific for the system)
```bash 
vim /etc/mkinitcpio.conf

# Adding moduless
MODULES=(ext4 crc32c-intel nvidia nvidia_drm nvidia_modeset nvidia_uvm)

# Adding binaries
BINARIES=(fsck fsck.ext4)


#Regenerating an lts image:
$ mkinitcpio -p linux-lts
```
*Note: tools for finding the needed modules include: 
$ hwdetect --show-modules
$ mkinitcpio -M
Alternatively, refert to the Arch Linux Wiki for additional information.*

9. Updating the mirrorlist

```bash
$ reflector --latest 20 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```

10. Configuring pacman

```bash
$ vim /etc/pacman.conf

# multilib (32bit packages)
[multilib]
Include = /etc/pacman.d/mirrorlist

# misc
Color
CheckSpace
VerbosePkgLists
```

11. Video graphics

```bash
#OpenGL:
$ pacman -S mesa mesa-libgl lib32-mesa-libgl 

#Xorg
$ pacman -S xorg-server xorg-xinit

#Nvidia:
$ pacman -S nvidia lib32-nvidia-libgl nvidia-settings nvidia-utils
# alternatively use nvidia-lts
```

12. Desktop environment

```bash
$ pacman -S i3 lightdm lightdm-gtk-greeter

#Enable lightdm
$ systemctl enable lightdm 
```
