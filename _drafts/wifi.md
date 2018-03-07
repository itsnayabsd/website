---
layout: post
title: WLAN Interface
excerpt: All wifi related information for wlan interface programmers
category: networking
comments: false
google_adsense: false
---
## WiFi Authentication Process

Client sends probe request to layer 2 of all APs in the proximity networks. This `probe request` has the information about data rates supported by the client and 802.11 capabilities of the client (like 802.11n or ac or a etc).

The APs receiving this probe request checks whether the client has common supported data rate. If the client supports atleast one compatible data rate, then the AP replies with `probe response` packet, which has information like SSID, supported data rates and encryption types.

The client discovers all the compatible networks from all probe resposes. The client now sends the `authentication frame` to the AP by keeping authentication open. The AP responds with another authentication frame which is open. This authentication (called low level 802.11 authentication) process is always success.

If the elements of association request (coming from client) match the AP capabilities, the AP responds with a association ID. Now the client is successfully `associated`.

WPA/WPA2 or 802.1X authentication comes after 802.11 association. Client won't be able to send or receive data through network unless 802.1X authentication (if not open authentication) is completed.

**[Association Process Explained](https://documentation.meraki.com/MR/WiFi_Basics_and_Best_Practices/802.11_Association_process_explained)**

## PMK and OKC
### Pairwise Master Key

When a client authenticates using 802.1x authentication, EAP exchange takes place, followed by a 4 way handshake to verify encryption keys. Pairwise master key (PMK) cahing is a methodology in which when a client connects to an AP, PMK identifier is cached in that AP. When the client roams to different AP and then reassociates to the first AP, EAP exchange is skipped, directly goes to 4-way handshake and then saves authentication time.

### Opportunistic Key Caching

It's an extension to PMK caching. In this method, all APs of same layer 2 network recieves a copy of PMK ID. Thus when client roams between APs, the 802.1x authentication latency will be decreased by skipping EAP exchange.

**[PMK Caching and OKC](https://documentation.meraki.com/MR/WiFi_Basics_and_Best_Practices/Pairwise_Master_Key_and_Opportunistic_Key_Caching_-_PMK_and_OKC)**
