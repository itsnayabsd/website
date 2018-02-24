---
layout: post
title: Adding GUI to LFS
category: linux
comments: true
google_adsense: false
excerpt: >-
  Adding graphical user interface to Linux from scratch. This involves adding
  windowing system, display managers, window managers and icons.
date: 2018-02-14T17:27:40.000Z
thumbnail: /assets/img/xorg_gui.png
rating: '4'
---
## Terminology
**Xorg** is the open source implementation of *X window system*.

**X window system** (or X11 or simply X) is a software the provides framework to implement GUI environment for individual applications. GUI environment in the sense, creating and moving windows on a display device (such as screen) and interacting with that GUI through hardware (mouse , keyboard etc) using client/server mechanism.

  {% if jekyll.environment == 'production' and page.google_adsense %}
  {% include goog_inart_2par.html %}
  {% endif %}

*X window manager* and *X display server* are the main components of X window system.

X window manager controls the placement and appearance of *windows within X window system*. This does not directly interact with video hardware, mice, or keyboards. Display server does that. The various features of window managers can be found [here](https://en.wikipedia.org/wiki/Window_manager#Features_and_facilities_of_window_managers).

**X server** is the display server in X window system. X server is also called *X compositor*.

Kernel receives input from attached input devices such as mouse, keyboard, touchscreen etc. X server receives this input from kernel and transmit it to correct client.

X was originally designed to use over network connections rather than attached display device. That means we can interact with the X program (runnign somewhere in the network) through X server graphical interface (running in our system), and this X server sends mouse or keyboard (or any input devices) events to the X program. This is *X client/server* mechanism.

**X terminal** runs X server. X terminal won't support any IO other than keyboard, mouse and display.

**Wayland** is being developed by X.org developers as a replacement for X.org.

An OS with a native Window system can host another Window system as a client. For example *Wayland window system* can host *X Window system* as a client and manages it's appearance through the Wayland window system.

**Desktop environment** includes set of applications that use consistent user interface along with X.
