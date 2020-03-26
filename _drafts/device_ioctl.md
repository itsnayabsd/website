---
layout : post
---
First create the char device in /dev/ directory..

We can create ioctl calls for this device to perform operations like getting data, writing data or erasing etc. We have to pass the file descriptor of the device opened to ioctl first argument.
