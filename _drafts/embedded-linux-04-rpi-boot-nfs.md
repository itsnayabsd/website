---
layout : post
---
## Booting the RPI through NFS
### Setting NFS server on host system
```
sudo apt install nfs-kernel-server
```
Add the following line to `/etc/exports` file.
```
<path_to_busybox_install_directory> <ip_address_of_board>(rw,no_root_squash,no_subtree_check)
```
ex : `/home/nayab/rpi/fs/nfs 192.168.1.115(rw,no_root_squash,no_subtree_check)`

Restart the NFS server
```
sudo service nfs-kernel-server restart
```

### Set bootargs env in the baord U-boot console.
**Note** : You may need to change the device tree from `bcm2710-rpi-3-b.dtb` to `bcm2837-rpi-3-b.dtb` in the config.txt file to stop in the U-boot console.

Set the `bootargs` env using following command
```
setenv bootargs # Reset bootargs
setenv bootargs root=/dev/nfs console=ttyAMA0,115200 console=tty1 root=/dev/nfs ip=<board_ip>:::::eth0 nfsroot=<host_ip>:<path_to_busybox_on_host>,nfsvers=3 rw
```
ex: `editenv bootargs root=/dev/nfs console=ttyAMA0,115200 console=tty1 root=/dev/nfs ip=192.168.1.115:::::eth0 nfsroot=192.168.1.15:/home/nayab/rpi/fs/nfs,nfsvers=3 rw`
```
saveenv
```
**Note** : Don't forget to revert back device tree.
