---
layout: post
---
BeagleBone Black is manufactured and warranted by Circuitco LLC. 
Download beaglebone system reference manual from official source

https://github.com/CircuitCo/BeagleBone-Black/

From the system reference manual, note down the hardware details.

Processor model number: AM3358BZCZ100
Download datasheet and technical reference manual (user guide) for the processor. Texas Instruments website is a good place to get these documents.

Power required : 5V 1A adaptor through power jack. Board can also be powered with miniusb port. The mini usb to type A usb can be used to power the board through system USB or power adaptor.

Serial debug : USB serial cable is required. The system reference manual has the `Serial Header` section that shows the pin details of serial connection.
    Pin 1 - Ground (pin closest to power jack)
    Pin 4 - Rx
    Pin 5 - Tx
Install serial communication program.
sudo apt install picocom
Run the program with `sudo picocom -b 115200 /dev/ttyUSB0`. To exit picocom, Ctrl+A and then Ctrl+X.

Login details : Once the login console shows up through serial console, the default login credentials are displayed on the screen.

## Update the u-boot
Update u-boot as per instructions given in https://raw.githubusercontent.com/bootlin/training-materials/master/lab-data/common/bootloader/beaglebone-black/README.txt

This update enables the commands like `saveenv`.

## TFTP communication
In u-boot console,

Set up ethernet address, ipaddr and serverip
<!--setenv ethaddr f8:dc:7a:00:00:02-->
set ipaddr 192.168.1.5
set serverip 192.168.1.15
saveenv

Configure Ethernet over usb
setenv ethact usb_ether
setenv usbnet_devaddr f8:dc:7a:00:00:02
setenv usbnet_hostaddr f8:dc:7a:00:00:01

IN the host network, create an ethernet interface with the serverip
nmcli con add type ethernet ifname enxf8dc7a000001 ip4 192.168.1.15/24

Test the network.
ping ${serverip}
tftp 0x81000000 <file_in_tftpboot_folder>
md 0x81000000
