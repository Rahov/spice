# Arch Linux installation guide

Compiled from multiple sources and personalized.

* Source 1: 
* Source 2: 
* Source 3: 

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


