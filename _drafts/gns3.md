## Installing
### Installing gns3 gui and server
```bash
sudo add-apt-repository ppa:gns3/ppa
```
```bash
sudo apt update                                
sudo apt install gns3-gui gns3-server
```
### Install docker-ce
Remove older packages if any.
```bash
sudo apt remove docker docker-engine docker.io
```
Install the packages
```bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```
Import docker gpg key
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Add the docker repo
```bash
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"
```
Install docker-ce
```bash
sudo apt update
sudo apt install docker-ce
```
### Add current user to the respective groups
```bash
sudo chmod +x /usr/bin/ubridge
ubridge libvirt kvm wireshark docker # The prompt "iniparser: cannot open ubridge.ini" is normal.
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
sudo usermod -aG wireshark $USER
sudo usermod -aG docker $USER
```
Now restart/logout the system and login again.
## Configuration of server
Click on GNS3 icon in the launcher. Follow the setup wizard for GNS3 server. My GNS3 server config is as follows.
```
Server Type -> Local
Path -> /usr/bin/gns3server
Host -> localhost
Port -> 3080
```
## Downloading Cicso IOS images
File -> Import appliance -> Browser for the downloaded *gns3a* configuration file. And then import the downloaded image.

### Cisco Routers
Cisco IOSv -> Cisco IOSv 15.6(2)T

### Cisco Switches
Cisco vIOU L2 -> Cisco IOSvL2 15.2.4055

## Cisco cml
```bash
sudo apt install openconnect
sudo openconnect lab_network_address
```
