Download Raspberry Pi imager from https://www.raspberrypi.com/software/. Follow onboard instructions to flash Raspberry Pi OS Lite 32 bit. Press `Ctrl` + `Shift` + `X` to open secret menu through which SSH can be enabled.

Get the RPi IP from router UI. SSH into the device.

Log into https://mystnodes.com/ or register first. Click on `Get Started` button.

Follow the instructions on-screen to install myst. Run the displayed commands.

If you see the error while following the steps like following, add the key using the next commands.

```
The following signatures couldn't be verified because the public key is not available: NO_PUBKEY XXXXXXXXXXXXXXXXXX
```
Run the following commands to solve above error.
```bash
gpg --keyserver keyserver.ubuntu.com --recv-keys XXXXXXXXXXXXXXXXXXXX
```
```bash
gpg -a --export XXXXXXXXXXXXXXXXXXXXXXX | sudo apt-key add -
```
Claim the node manually. This step involves noting down API key, opening RPi Mysterium UI, buying Myst tokens, selecting the option to claim the node on mystnodes.com website and finally claiming the node.
