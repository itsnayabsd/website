## Checking virtualization
```bash
egrep "(vmx|svm)" /proc/cpuinfo
```
If no output, enable in the BIOS.

Quick Emulator (QEMU) + Kernel-based Virtual Machine (KVM).

QEMU -> To emulate hardware. KVM -> Software that lets instructions pass through to supported processors.

The software which allows the Linux kernel to act as a hypervisor is called KVM.

## Installing QEMU/KVM
```bash
sudo apt install qemu qemu-kvm
```
## Documentation
```bash
man qemu-system
```
## Creating a disk image
QEMU needs a disk image file to emulate as an actuall disk. A scalable disk image can be created with QCOW2.

For example if you create a 60GB disk image file with QCOW2, it's not actually used entire 60GB on an actual disk. Instead it uses as per the data in that. It's called thin provisioning.

```bash
qemu-img create -f qcow2 linkedin.qcow2 10G
```

For thick provisioning, replace *-f qcow2* with *-f raw* in the abovce command.

We can even resize images using *qemu-* commands.

## INstalling OS on the disk
```bash
qemu-system-x86_64 -cdrom ~/Zorin-OS-15.3-Lite-32-bit.iso ~/virtualization/linkedin.qcow2 -m 2G -enable-kvm
```
*-m* to specify the RAM. Default is 64MB. *-enable-kvm* tells the hypervisor (here qemu?) to use kvm on the intel machines.

Once installation is complete, start the Zorin-OS with the following..
```bash
qemu-system-x86_64 ~/virtualization/linkedin.qcow2 -m 2G -enable-kvm
```
Need to mention RAM value and -enable-kvm in the above command every time after installation too.

To start the OS with more resolution options, pass *-vga qxl* option to the above command.
```bash
qemu-system-x86_64 ~/virtualization/linkedin.qcow2 -m 4G -enable-kvm -net none -vga qxl
```
qxl -> para virtualize driver. With qxl, we can change the resolution of the screen.

## Using virt-manager
Installing command
```bash
sudo apt install virt-manager
```
### Installing using virt-manager
```bash
virt-install --name elementary --memory 2048 --disk size=60 --cdrom ~/elementaryos-6.1-stable.20211218-rc.iso
```
By default it uses thin provisioning (qcow2) and qxl para virtualize driver for display.

--memory is given in MB. --disk size is given in GB. Networking works fine by default. The *qcow2* disk image will be created in the path */var/lib/libvirt/images* directory.
## Controlling virtual machines with virsh
### List all virtual machines (domains)
```bash
virsh list --all
```
```
 Id   Name         State
-----------------------------
 -    elementary   shut off
```
### virsh commands to control virtual machines
```bash
virsh start elementary # And then use virt-viewer to access the domain
virsh pause elementary
virsh resume elementary
virsh stop elementary  # You probably won't need this command
virsh shutdown elementary
```
### Access the virtual machine
```bash
virt-viewer elementary
```
