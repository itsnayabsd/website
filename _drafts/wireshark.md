---
layout: post
excerpt: Usage and Commands for better capturing of traffic using wireshark
category: linux-tools
title: Wireshark Usage
comments: false
google_adsense: false
---
* Enable packet capture for non-root users
{% highlight bash %}
$ sudo dpkg-reconfigure wireshark-common
$ sudo usermod -a -G wireshark $USER
$ sudo adduser $USER wireshark
{% endhighlight %}
Re-login for these changes to take effect.

Layer 1 -> Physical -> Copper
Layer 2 -> Data Link -> Ethernet -> Frame
Layer 3 -> Network -> IPv4 -> Packet
	-> Data delivery
		-> Routes data packets
	-> Layer 3 switches
		-> Routers
		-> Slects best path to deliveer
			-> OSPF, BGP, IS-IS
Layer 4 -> Transport -> TCP -> Segment
Layer 7 -> Application -> HTTP, Telnet, FTP etc.

Layer 6 -> Presentation layer -> Makes sure data is in format the can be recognized by two systems.
Layer 5 -> Session layer -> Makes sure two different systems can establish connection. ex:- RPCs, NetBIOS, PPTP (Peer ro Peer Tunneling Protocol)

The process of encoding the data bits for transmission across the media occurs at Layer 1, the physical layer. The formatting of data so it can be interpreted by the network connection in your laptop or phone is described at Layer 2, the data link layer

Sender side
-----------
User data moves from application layer to all way down to physical layer.

Layer 7 -> User data
Layer 6 -> Layer 6 header + User data
Layer 5 -> Layer 5 header + Layer 6 header + User data
.
.
Layer 2 -> Layer 2 header + Layer 3 data (ie. Layer 3 header +  Layer 4 header + Layer 5 header + Layer 6 header + User data).

Receiver side
-------------
Flow is opposite to above.

The Hybrid model
----------------
TCP/IP Model:
Application, presentation and session layers are combinbed into a single layer called Application layer.

Application -> Transport -> Internet -> Network access layer.

Network access layer is equivalent of Physical layer + Data link layer of OSI model.

Hybrid Model:
Application, presentation and session layers are combinbed into a single layer called Application layer.

Application -> Transport -> Network -> Data Link -> Physical

Network engineers only need to deal with Transport, Network, Data link and Physical layers.

So don't think much about OSI/TCPIP models. Concentrate on only Hybrid model.

How does the receiver system knows what type of layer 3/layer4 protocols present in the traffic arrived at layer 2? How does it interpret it?
-------------------
When the bytes are received of the physical layer of NIC, it reads Data Link Layer frame. In that frame, if it's using Ethernet 2, there is *Type* field which denotes whether the layer 3 is using IPv4 or IPv6.

At layer 3, the *protocol* numbers informs the device whether it is using TCP or UDP at layer 4 and sends the traffic to respective layer.

At layer 4, the *port* number specifies the application in use.

## Wireshark display filters
When wireshark is running in the monitor mode, the traffic being captured is huge. We can apply filters to live traffic also to minimize the capturing traffic. Use *Capture using this filter option* on the spcific interface.

Reading telnet data
---------------------
- Open capture using wireshark.
- Filter using *telnet*
- Right click on any packet -> Follow -> TCP Stream

Reading tftp data
-----------------
TFTP uses UDP. So Follow -> UDP Stream.

When something like router configuration is pushed using tftp to the tftp server, command like *tftp put file* pushed entire file to the tftp server. Wireshark capture entire file content.

Reading ftp data
----------------
TCP Stream

Capturing HTTP
--------------
HTTP Stream

Capturing VoIP
--------------
GNS3 makes capturing virtual VoIP calls easy. But to capture in the physical network, the VoIP port need to be mirrored or we need to use some kind of hub to connect a wireshark running client to capture traffic.
