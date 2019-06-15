# Arch Linux installation guide

Compiled from multiple sources and personalized.

If there is any misunderstanding or mistakes within the guide, please do let me know. Alternatively, refer to the soruces below:

* Source 1: Arch Linux Wiki 
* Source 2: plasma guide 
* Source 3: medium guide
* Source 4:  

#### Preview

![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "placeholder")

## Core Install 

1. Pre-requesets 

For UEFI motherboards, verify UEFI mode:
```bash
efivar -l
```

Connecting to the network (if not wired):
```bash
wifi-menu
```

Review the partition names that will be used: 
```bash
lsblk
#or
fdisk -l
```

2. Partitioning

The easiest way I've found for partitioning the disk is:
```bash
cfdisk /dev/nvme0n1pX 	#for nvme drives 
#or
cfdisk /dev/xdaX 	#for ssd drives 
```
*Note:* _X denotes a number which you should have figured out from the previous command._

3. Filesystems

Please do keep in mind this is for a EFI system:
```bash
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

*Note:* _I'm assuming sda1 is the EFI system partition and sda2 is the root partition. Addtioanlly, swap is not included._ 
