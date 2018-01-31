---
date: 2017-09-14 11:31:29 +5:30
title: Wireless Glossary
layout: post
excerpt: Terms and it's definitions related to Wi-Fi, Bluetooth and other wireless technologies
category: networking
comments: true
google_adsense: false
---
<h2 id="wep">WEP</h2>
Wired Equivalent Privacy. IEEE80211 standard defined this algorithm to protect wireless networks. But this protocol was proved to be insufficient to provide enough security.

<h2 id="tkip">TKIP</h2>
Temporal Key Integrity Protocol.

## WPA
Wi-Fi Protected Access. This is a subset of security enhancements was defined by Wi-Fi Alliance based on `IEEE 802.11i draft 3.0` as WEP proved to be insufficient. It replaces <a href="#wep">WEP Protocol</a> with <a href="#tkip">TKIP</a> protocol.

## WPA2
Subset of security enhancements that is based on `completed IEEE 802.11i standard` is called WPA2. Also known as `RSN`/`IEEE 802.11i`. This has support for more robust encryption algorithm `CCMP` to replace TKIP. It also has support for PMKSA caching. WPA2 authentication are of two types. <a href="#wpa2p">`WPA2-Personal`</a> and <a href="#wpa2e">`WPA2-Enterprise`</a>.

<h2 id="eap">EAP</h2>
Extensible Authentication Protocol.

<h2 id="eapol">EAPOL</h2>
<a href="#eap">EAP</a> over LAN.

<h2 id="wpa2p">WPA2-Personal</h2>
Also known as `WPA2-PSK`. PSK for `Pre Shared Key`. It requires a single password to access Wi-Fi.

<h2 id="wpa2e">WPA2-Enterprise</h2>
WPA2 can use the external authentication server (ex: RADIUS) and EAP to authenticate user.

## RSA Message Digest Algorithm MD5

<h2 id="pmk">PMK</h2>
Pairwise Master Key

<h2 id="pmksa">PMKSA</h2>
<a href="#pmk">PMK</a> Securtiy Association. This is the collection of information (Station MAC Address, AP MAC Address, PMK and the label "PMK Name") used to derive PMKID.
~~~
PMKID = HMAC-SHA1-128(PMK, "PMK Name" | MAC_AP | MAC_STA)
~~~
