## Bandwidth and Throughput
Bandwidth -> My ISP connection is 200 Mbps Unlimited data plan. Here 200 Mbps is the bandwidth my ISP provided for me. Official def: Bandwidth is capacity of medium to carry data. Measured in Bits per second.
Throughput -> The number of bits carried from one point to another for given fixed amount of time. Throughput varies based on type of traffic, latency created by other network devices

## Types of cables
### Ethernet cable
Twisted pair cable. 8 copper wires. 4 pairs in the cable. RJ45 connector.
#### Straight through cable
Two unlike-devices. When two devices have different pin layouts for transmitting and receiving the data.
#### Crossover cable
When two like-devices such as two PCs need crossover Ethernet cable to transmit/receive data.

### Co-axial cable
Cable TV/xfinity broadband cables. BNC type connector, Screw on F type connector.

### Fibre optic cable
For longer distances.

## Traceroute
Traceroute displays all the routers (hops) present in between while traffic reaches the destination.

## Ethernet Addressing - MAC

## Ethernet Frame
Ethernet is for NIC to NIC on the same network.

Ethernet frame max size is 1518 bytes (excluding preamle and start frame delimiter as this indicates the start of the frame).

Ethernet statndards define how the frames are encoded onto channel (physical medium) either as electric signals or as light signals. Different standards for either of these.

### Fields
PreAmble -> It is used just to be the receiving NIC in sync with the bits coming from sending NIC. - 7 Bytes

Start frame delimiter -> After this delimiter is the actual data. - 1 Byte

Destination MAC address -> 6 bytes

Source mac address -> 6 bytes

Length/Type -> The length of the data followed by this field/The type of data if it is IPv4/IPv6. -> 2 bytes

Data -> Can be IPv4 or IPv6. Along with IPv4 there can be other protocol headers. Example -> IPv4 with TCP header with HTTP header with data. -> Varies 46 bytes to 1500 Bytes 

Frame check sequence -> Receiving device does some error checking here.

## Addresses
 * Physical -> MAC address
 * Logical -> IP address

Source and destination IP addresses won't change when packet travels from one network to other/many.

Ethernet MAC addresses change when packet goes to other network. When packet moves from network A to network B, the source MAC is the MAC of some system in the network A and the destination MAC is the MAC of the router. Here router removes the Ethernet frame and looks for the IP address. Based on it's routing table, it formulates the Ethernet frame with src MAC addr is it's own MAC addr and the destination MAC is the MAC of the desired system.

## Ethernet HUBs
Ethernet HUBs are the devices with multiple Ethernet ports. Network devices are connected to these ports. When one network device sends a message, the HUB simply recieves the message from one port and retransmits the message to all other ports. Only one message can be transmitted at a time. When two network devices send a message, the electronics signals might collide and the message need to be retransmitted again. This slows down the network. And hence these devices are obsolete.

## Ethernet Switches
The Ethernet switches are the devices with Ethernet ports and it knows the MAC addressess of devices connected to the ports. It maintains this MAC address table. When a device sends a message, the Ethernet switch receives the Ethernet frame, looks into Ethernet header for destination MAC address. Thus it only sends the traffic to the port to which the destination device is connected unlike the HUB which sends the traffic to all other ports.
Ethernet switches operate at layer 2 (data link layer) as it looks into Ethernet header for operation.
Collisions won't happen because the switches build separate circuits between hosts for every conversation.

### How Ethernet switches build MAC address table
 - Assume there are 4 devices A, B, C and D connected to the ports 0, 1, 2, 3 of switch respectevily.
 - Assume the MAC addresses of the devices are aa:aa:aa:aa:aa:aa, bb:bb:bb:bb:bb:bb, cc:cc:cc:cc:cc:cc and dd:dd:dd:dd:dd:dd respectively.
 - When the device A wants to send the Ethernet frame to device D, the switch receives the data at port 0.
 - It decodes the Ethernet frame and looks for src MAC address. It searches if that MAC address is present in it's MAC address table. If the MAC is not present, it updates the MAC address for incoming port i.e. port 0.
 - Now the switch looks for dest MAC address and checks if that MAC address is mapped to any of its ports. If the MAC address is not found, then it simply transmits the Ethernet frame to all ports except the incoming port.
 - Next time when the host C wants to send the frame to host A. The switch searches for the src MAC in it's MAC address table. Since it is not found, it maps the MAC address to corresponding port i.e. port 2.
 - Now it searches for the destination MAC. The dest MAC is already present in the table. So switch directly sends the frame from host C to host A.

### The Ethernet broadcast address
The Ethernet broadcast address is ff:ff:ff:ff:ff:ff. When a host sends broadcast frame, the switch transmits that frame to all connected hosts. However if there is a router connected to switch, the router won't broadcast the frame to other network.

## Communication between hosts
The NIC only accepts the frame when the physical address is either broadcast address or it's own MAC address. But the network applications use logical (IP) address to identify the destination servers/clients. So how does the sending host knows the MAC address of destination host? It uses the ARP (for IPv4) or Neighbor discovery (for IPv6) to find the MAC associated with the IP address.

### ARP
Suppose PC1 tries to access some ftp server 192.168.1.10, and it needs the MAC address of FTP server to fill the destination MAC in the Ethernet frame. It first checks it's arp table for the MAC address corresponding to the IP address 192.168.1.10. If it doesn't find the MAC, then it sends the ARP request (it's an Ethernet broadcast) to the network. The FTP server checks for the IP address and replies back with it's MAC address.

## Routing between networks
Ways to divide a larger LAN into small networks ->
 - Using routers -> Each interface of a router is a different network or a different broadcast domain. The broadcast frames won't reach the other interface of the router or the network.

Routing is the process of identifying best path to reach to destination.

Routers make their forwarding decisions based on IP addresses where as switches make their forwarding decisions based on MAC addresses. The traffic reaching at layer 3 are called packets.

When a host on one network, say for 10.1.1.0 needs to send a message to 5.5.5.0, then the host forwards the message to a router. The router decapsulates the Ethernet frame for destination IP address information and then determines where to forward the message based on it's routing table. Before forwarding the message, the router re-encapsulates the message into frame.

Routers can have multiple NICs for each network physically connected to it.
## Routing table
The router table basically has network IP address along with the associated router port. It also has information about routes, that used to reach other remote networks which not connected to the router physically to one of it's ports.

|Network address|Interface|
|-|-|
|192.168.1.0/24| port 0|
|10.0.0.0/24|port 1|

How does a host knows whether to send the packet to the router? It checks the destination IP address, see the network portion of the IP address and the subnet mask (yes subnet mask to determine the range/network), and then if the destination IP address is not in the current network, the host sends the packet to the router.

## Path selection
Assume the following network architecture

```
192.168.1.10/24                     192.168.2.10/24
        Host1                       Host2
            \        NIC1           /
            Switch - Router - Switch
            /          NIC2         \
        Host3                       Host4
192.168.1.20/24                     192.168.2.20/24
```
Let us assume the following MAC address for the above network devices.

|Device|IP addr|MAC addr|
|-|-|-|
|Host1|192.168.1.10|11:11:11:11:11:11|
|Host2|192.168.2.10|22:22:22:22:22:22|
|Host3|192.168.1.20|33:33:33:33:33:33|
|Host4|192.168.2.20|44:44:44:44:44:44|
|NIC1|192.168.1.1|AA:AA:AA:AA:AA:AA|
|NIC2|192.168.2.1|BB:BB:BB:BB:BB:BB|

### Messages within network.
Let us assume the Host1 wants to send a message to Host3.

 - The Host1 knows src IP addr, dest IP addr and src MAC addr.
 - Host1 checks if the destination IP address is on same network or on different network based on it's subnet mask. Here Host1 has subnet mask of 255.255.255.0. So the destination IP 192.168.1.20 is on the same network.
 - It now needs the MAC address of Host3. It checks it's ARP table. If it didn't find the MAC of Host3 in its ARP table, it sends the ARP broadcast.
 - Once it knows the dest MAC, it now have complete Ethernet fram and sends the frame directly to the Host2 through the switch. Switch has its own MAC address table to send the packet directly to Host3.

## Messages between networks
Let us assume the Host1 wants to send message to Host2.

 - The Host 1 checks if the Host2 belongs to same network or not. It belongs to other network.
 - At this point, the Host1 has src and dest IP addresses, src MAC address.
 - The Host1 wants to send the frame to the gateway (router). It needs router's MAC address. It checks it's ARP table for the MAC address associated with gateway IP address (192.168.1.1).
 - Now the dest and src MAC addresses are AA:AA:AA:AA:AA:AA and 11:11:11:11:11:11. The dest and src IP addresses are 192.168.2.10 and 192.168.1.10.
 - It creates the Ethernet frame such as the following.
    |AA:AA:AA:AA:AA:AA|11:11:11:11:11:11|192.168.2.10|192.168.1.10|data|check|
 - The switch sends the frame to router.
 - The router decapsulates the frame, checks for the destination IP address to find the network address it belongs to. It then checks its routing table to find the port associated with that network address.
 - The router finds the MAC address associated with the destination IP address based on it's ARP table.
 - It rewrites the Ethernet frame with it's MAC address (NIC2) as src MAC addr, dest MAC address associated with the dest IP addr.
 - The frame is sent to Host2 through the switch.

## Router forwarding packets to other routers
When a router received a packet, it looks at the destination IP addr and it searches in it's routing table for the network address that packet belongs to. If it doesn't find the network address in its routing table, the router drops the packet.

To avoid dropping a packet, often the routers will have default routing entry (or port interface) to which all packets with unknown IP addresses will be forwarded.

## Local area network

A single or group of local networks under one administration control. Often the term *intranet* is used for LAN for an organization.

## The Internet Protocol
### Caluclating network, broadcast, first usable host and last usable host addresses
Lets assume the host is configured with 192.168.20.30/22 address. Here the host address is 192.168.20.30 and the subnet mask is 255.255.252.0

Network portion is first 22 bits and the host portion is last 10 bits.

#### Calculating network address.
Take the host IP address and do bitwise ANDing with the subnet mask. 192.168.20.30 bitwise ANDing with 255.255.252.0.
```
11000000 10101000 00010100 00011110
11111111 11111111 11111100 00000000
-----------------------------------
11000000 10101000 00010100 00000000
```
The network address is 192.168.20.0

#### Calculating broadcast address
Take the network address from above. Replace the host portion (10 bits) of the network address with all 1s.
```
11000000 10101000 00010111 11111111
```
The broadcast address is 192.168.23.255.

#### Calculating the number of hosts in the network.

Total number of hosts in the network = (2^num of host portion bits - 2)
                                     = 2^10 - 2
                                     = 1022
#### Calcualting the starting IP address in the network
Take the network address. Replace host portion with all 0s except the LSB. LSB is 1.
```
11000000 10101000 00010100 00000001
```
The starting address of any usable host is 192.168.20.1

#### Calculating the ending IP address in the network.
Take the network address. Replace host portion with all 1s except the LSB. LSB is 0.
```
11000000 10101000 00010111 11111110
```
The ending address of any usable host is 192.168.23.254

## Private IP addresses
 - 10.0.0.0/8 -> host part 24 bits. -> Range 10.0.0.0 to 10.255.255.255.255
 - 172.16.0.0/12 -> host part is 20 bits -> 172.16.0.0 to 172.31.255.255
 - 192.168.0.0/16 -> host part 16 bits -> 192.168.0.0 to 192.168.255.255

Local/Private IP addresses will be converted to public IP by router using NAT.


## Unicast, Multicast and Broadcast addresses
### Unicast
Message originated from src IP address is destined for only one host.

Unicast IP address range -> 0.0.0.0 to 223.255.255.255
### Broadcast
Destined for all hosts in a network except for the incoming host.

Broadcast address -> 255.255.255.255. It's a limited braodcast address.

And there are network specific broadcast addresses such 172.16.4.0/24 network has 172.16.4.255 as the broadcast address. It's a directed broadcast address.

### Multicat
Range 224.0.0.0 to 239.255.255.255.

From a single host to group of network devcies.

224.0.0.0 to 224.0.0.255 addresses are only intended to use for local network multicasting. It won't get forwarded by router.

There are reserved multicast addresses too. For ex: 224.0.0.9 used by routing information protocol (RIP) of routers to communicate with the other routers.

## IP address asignment
Minimum configuration settings required during IP address asignemtn are IP address, subnet mask and default gateway.

Wireless router acts as both DHCP client and server. Router gets IP address from ISP dhcp server. Router gives IP addresses to the home clients.

DHCPv6 is similar to DHCPv4 except it won't provide default gateway address. This need to be obtained from router advertisement message.

### DHCPv4 working
 - (After the host authentication in case of wireless) The host sends DHCP Discover packet as a broadcast message (dest ip 255.255.255.255 and dest MAC ff:ff:ff:ff:ff:ff) to the available DHCP servers in the network.
 - The DHCP server sends the DHCPOFFER packet. This has the IP configuration settings. The IP address, subnet mask and the default gateway (in case of DHCPv4).
 - The host receives the DHCP settings and sends the DHCPREQUEST (it's also a broadcast packet) back to the network that it will use the offered IP address. It tells the DHCP server that it's accepting the configuration and it tells the other DHCP servers in the network (if any) that their offers were rejected.
 - Server sends back DHCPACK packet that tells the host that the DHCP server is storing this IP address in it's table along with the associated MAC address.
 - The host sends a DHCPRELEASE message when its lease expires to the dhcp server.

## NAT
The local/private IP addresses in the packet will be replaced by public IP address assigned to the router. This is called network address translation. One single public IP can be used for multiple local network hosts. But how does router know to which internal host the incoming traffic belongs to?

## IPv4 Limitations
 - Running out of addresses
 - NATing is slower. Created latency for P2P applications.

## IPv6
 - 16 bytes -> 128 bits
 - Has address resolution and auto configuration capabilities. What are these?
 - Every device on the earth can have its own global unicast IPv6 address.
 - When an IPv6 device boots up, it assigns itself a *Link Local IPv6* address. The address is local to the network and won't get forwarded through router. Device uses this address to talk to other IPv6 device on the same network.
 - There are three ways, the host gets the IPv6 configuration settings.
   - Router sends ICMPv6 router advertisement packet peridicallay. It has prefix, prefix length and the default gateway address. Or the host sends a multicast packet to all IPv6 routers on the network for the advertisement packet. Using this info the IPv6 host generates a global unicast IPv6 for itself (creates only host part), configure DNS server and default gateway. The router's link local IPv6 is the default gateway address for this host. DHCPv6 server is not needed. This is called SLAAC (stateless address auto configuration)
   - Router sends ICMPv6 router advertisement packet peridicallay. It has prefix, prefix length and the default gateway address. But DNS servers details will be fetched from the DHCPv6 server. This is called SLAAC with DHCPv6 for DNS servers.
   - Router sends only gateway address in router ICMPv6 router advertisement packet. Remaining configuration (includes global IPv6 address) the host will fetch from the DHCPv6 server. It's called stateful DHCPv6 server.
   - By default IPv6 encrypts data and checks integrity of packet (regardless of tcp/udp as in IPv4??).

### IPv6 special addresses
Loopback address            ::1
Link local address          starts generally with fe80          fe80::2310:cd10:66d2
Multicast address           starts generally with ff            ff02::2
Global unicast              All other addresses are global unicast addresses.

## IPv4 subnetting vs IPv6 prefixing
 - IPv6 doesn't have subnetting. It has prefix.
 - For example -> The IPv6 address 2001:db7:7bd:1c:2119::fe:e238/64
    - Lets expand the above address first. 2001:0db7:07bd:001c:0000:00fe:e238/64. First 64 bits is the network address. Remaining part is for hosts.

## TCP
TCP segments have sequence numbers along with the src and dest port numbers. So segments travel to the other network in sequence

When dest receives all the sequenced segments, it acknowledges back to src. This happens constantly for reliable communication. And hence th overhead compared to the UDP connection.

Each application over the network runs on it's own application layer protocol. But beneath those sevices, at transport layer level commonly there are either TCP or UDP. So basically it's like *client server model* over the network through socket communication.

Segments are assembled into packets. These packets in turn assembled into frames.

Only the portion of message that is lost(a few segments) will be re-transmitted by TCP if the part of the message is lost.

## Application services
The servers which provide services to client runs on specific port. There are well known ports 1 to 1024. For example, ftp server runs on port 21 on the host. ftp client can run on any random port on another host.

TCP segments when transmitted to ftp/https servers, the dest port would be 21 for ftp or 80 for http. The src port can be anything.

### Port classification
 - 0 to 1023 -> Well known ports assiciated with common network applications such as ftp (21), ssh (22), telnet(23), dns(53) etc.
 - 1024 to 49151 -> Registered ports. Organisations need to register the ports to use with their apps such as IM applications (user applications or services).
 - 49152 to 65535 -> Priver ports. Can be used by anybody.

### Port table
|Port   |   Application |   TCP/UDP?    |
|-------|---------------|---------------|
|21     |   FTP         |   TCP         |
|22     |   SSH         |   TCP         |
|23     |   Telnet      |   TCP         |
|25     |   SMTP        |   TCP         |
|53     |   DNS         |   TCP/UDP     |
|67     |   DHCP Server |   UDP         |
|68     |   DHCP Client |   UDP         |
|69     |   TFTP        |   UDP         |
|80     |   HTTP        |   TCP         |
|110    |   POP3        |   TCP         |
|143    |   IMAP        |   TCP         |
|161    |   SNMP        |   UDP         |
|443    |   HTTPS       |   TCP         |

Most information on IANA website

## Socket
The combination of IP address along with the port number is called socket

## netstat
To find out which TCP connections are open in the system.
```bash
netstat -n
```
## FTP
ftp.cdc.com free server.

## SSH
oslab.cis.cabrillo.edu

## SMTP
SMTP is used by email client when it's want to send a mail. It sends the mail to it's local mail server. If the destination mail doens't belong to local mails server it uses SMTP to send the message to other mail server the message belongs to.

For example, gmail first checkes in it's mail servers. If the mail is not belong to local mail server, it sends to other mail server using SMTP.

### POP3
Mail servers which supports POP3 will store the messages for it's users. Once user reads the message, the message gets deleted from the server.

### IMAP
Same as POP3 except the message won't get deleted unless user specifically deletes it.

## Wireless channels
Devices operating in a single radio frequency can create interference. As long as the adjacent APs operate in different channels, they function fine.

2.4GHz channels -> 1, 6 etc.
5GHz channels -> More channels combined into a wider channel to provide more bandwidth.

### Collision detection over network
The Ethernet network protocol detects when two or more hosts send the message at the same time. In case of wireless networks, it follows a different approach called Carrier Sense Multiple Access with Collision Avoidance (CSMA/CA).

When a device wants to use a channel, it sends Request to Send (RTS) packet to the AP. If the channel is free the router replies with Clear To Send (CTS) packet. Meanwhile all other devices waits for their turn. CTS is broadcast packet. When device done with the use of channel it sends ACK packet to the AP/router and all other devcies in the network. ACK is braodcast. Now network devices know the channel is free.
