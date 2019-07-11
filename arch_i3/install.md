# Arch Linux installation guide

Compiled from multiple sources and personalized.

If there is any misunderstanding or mistakes within the guide, please do let me know. Alternatively, refer to the soruces below:

* Source 1: Arch Linux Wiki 
* Source 2: plasma guide 
* Source 3: medium guide
* Source 4:  

#### Preview

![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "placeholder")

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
$ mkfs.fat -F32 /dev/sda1
$ mkfs.ext4 /dev/sda2
$ mount /dev/sda2 /mnt
$ mkdir /mnt/boot
$ mount /dev/sda1 /mnt/boot
```

*Note: I'm assuming sda1 is the EFI system partition and sda2 is the root partition. Addtioanlly, swap is not included.*

## Installation

1. Installing the system 

```bash
$ pacstrap /mnt base base-devel linux-headers linux-lts linux-lts-headers zsh git dialog wpa_supplicant iw vim 
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
options root=/dev/'sda2' rw quiet splash nvidia-drm.modset=1
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


# if the ntp server lags again (20 sec issue) 
# consider installing the ntp package and 
# using the ntp daemon
# instead:

$ systemctl enable ntpd.service

```

Details at: [arch wiki](https://wiki.archlinux.org/index.php/Network_Time_Protocol_daemon)


8. Adding modules (specific for the system)
```bash 
vim /etc/mkinitcpio.conf

# Adding moduless
MODULES=(ext4 crc32c-intel nvidia nvidia_drm)

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
$ reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
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
$ pacman -S xorg-server xorg-xinit xorg-server-utils

#Intel:
$ pacman -S xf86-video-intel lib32-mesa-libgl 

#Nvidia:
$ pacman -S nvidia lib32-nvidia-libgl nvidia-settings nvidia-utils lib32-nvidia-libgl
# alternatively use nvidia-lts
```

12. Desktop environment

```bash
$ pacman -S i3 lightdm lightdm-gtk-greeter

#Enable lightdm
$ systemctl enable lightdm 
```
