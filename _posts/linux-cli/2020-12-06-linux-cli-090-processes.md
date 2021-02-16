---
title : Processes and Controlling
layout : linux-cli-post
category : linux-cli
date : 2020-12-06 20:38:08 +5:30
comments : true
google_adsense: true
excerpt : This post explains how to monitor, control, terminate the processes, run process in the background , pause the process and brigh back the same process to foregroud in Linux along with the examples.
keywords : Linux top command, Linux ps command, Send process in the background, brigh process to foreground, Linux terminate process, Linux pause process, Linux fg command, Linux top command cpu usage, Linux kill command, Linux killall command, Linux ps aux, Linux ps pid, Linux top ps fg kill killall examples.
image : /assets/img/linux-cli-processes.png
toc : true
---
## Introduction
Starting the moment the computer is turned on, whatever you see is on the screen is a running process. Running a shell is a process. Running web browser is a process. Running a command is a process. Playing movie is a process. Every running program (whether it is running in the background as daemon or not) is a process.

{% include image.html url="linux-cli-processes.png" description="Controlling Linux Processes" %}

## Monitoring Processes

There are two commands for monitoring processes. ***ps*** and ***top***.

### Monitoring Processes with ps command

Run *ps* command in terminal.

```bash
me@linux ~ $ ps
  PID TTY          TIME CMD
 1864 pts/0    00:00:00 bash
 1927 pts/0    00:00:00 ps
```
There are currently two processes/programs running. Shell (bash) and ps itself. Every running process is assigned a process id (PID). Here PID for *bash* is 1864 and PID for *ps* is 1927. PIDs differs from system to system and time to time.

The second field *TTY* stands for teletype terminal. pts/0 is the controlling terminal 0. If we open second terminal and execute same commands there, TTY value would be pts/1.

However, programs opened through GUI won't display in terminal using ps command because there is no terminal controlling those. There are other more processes run in background called demon processes. To view all these processes, ps x is used.

```bash
me@linux ~ $ ps x
  PID TTY      STAT   TIME COMMAND
 1311 ?        Ssl    0:00 cinnamon-session --session cinnamon
 1390 ?        Ss     0:00 /usr/bin/ssh-agent /usr/bin/dbus-launch --exit-with-s
 1393 ?        S      0:00 /usr/bin/dbus-launch --exit-with-session /usr/bin/im-
 1394 ?        Ss     0:00 //bin/dbus-daemon --fork --print-pid 6 --print-addres
 1404 ?        Sl     0:00 /usr/lib/at-spi2-core/at-spi-bus-launcher
 1408 ?        S      0:00 /bin/dbus-daemon --config-file=/etc/at-spi2/accessibi
 1411 ?        Sl     0:00 /usr/lib/at-spi2-core/at-spi2-registryd --use-gnome-s
 1421 ?        Sl     0:01 /usr/lib/cinnamon-settings-daemon/cinnamon-settings-d
 1426 ?        Sl     0:00 /usr/bin/gnome-keyring-daemon --start --components=se
 1433 ?        S<l    0:00 /usr/bin/pulseaudio --start --log-target=syslog
 1508 ?        Sl     0:00 /usr/lib/gvfs/gvfsd
 1539 ?        Sl     0:00 /usr/lib/gvfs//gvfsd-fuse -f /run/user/1000/gvfs
 1624 ?        Sl     0:00 /usr/bin/python /usr/bin/cinnamon-launcher
 1642 ?        Sl     0:00 /usr/lib/cinnamon-settings-daemon/csd-printer
 1647 ?        Sl     0:14 cinnamon --replace
 1655 ?        Sl     0:00 /usr/lib/cinnamon-settings-daemon/cinnamon-fallback-m
 1656 ?        Sl     0:04 nemo -n
 1657 ?        Sl     0:00 nm-applet
 1661 ?        Sl     0:00 /usr/lib/policykit-1-gnome/polkit-gnome-authenticatio
 1667 ?        Sl     0:00 /usr/lib/gvfs/gvfs-udisks2-volume-monitor
 1685 ?        Sl     0:00 /usr/lib/gvfs/gvfs-mtp-volume-monitor
 1689 ?        Sl     0:00 /usr/lib/gvfs/gvfs-gphoto2-volume-monitor
 1693 ?        Sl     0:00 /usr/lib/gvfs/gvfs-afc-volume-monitor
 1707 ?        S      0:00 /usr/lib/i386-linux-gnu/gconf/gconfd-2
 1710 ?        Sl     0:00 /usr/lib/gvfs/gvfsd-trash --spawner :1.11 /org/gtk/gv
 1764 ?        Sl     0:00 cinnamon-screensaver
 1765 ?        S      0:00 /usr/bin/python /usr/bin/mintupdate-launcher
 1768 ?        S      0:00 sh -c /usr/lib/linuxmint/mintUpdate/mintUpdate.py
 1769 ?        Sl     0:00 python /usr/lib/linuxmint/mintUpdate/mintUpdate.py
 1812 ?        Sl     0:00 /usr/lib/gvfs/gvfsd-metadata
 1820 ?        Sl     0:00 /usr/lib/libreoffice/program/oosplash --writer file:/
 1841 ?        Sl     0:05 /usr/lib/libreoffice/program/soffice.bin --writer fil
 1858 ?        Rl     0:01 gnome-terminal
 1862 ?        S      0:00 gnome-pty-helper
 1864 pts/0    Ss     0:00 bash
```
TTY value ***?*** means there is no terminal controlling these processes. TIME field indicates time taken by CPU to execute this process.

More detailed description of processes can be obtained by `ps aux` command.

```bash
me@linux ~ $ ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.1  0.0   4044  2316 ?        Ss   21:45   0:01 /sbin/init
root         2  0.0  0.0      0     0 ?        S    21:45   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        S    21:45   0:00 [ksoftirqd/0]
root         4  0.0  0.0      0     0 ?        S    21:45   0:00 [kworker/0:0]
root         5  0.0  0.0      0     0 ?        S<   21:45   0:00 [kworker/0:0H]
root         7  0.0  0.0      0     0 ?        S    21:45   0:00 [migration/0]
root         8  0.0  0.0      0     0 ?        S    21:45   0:00 [rcu_bh]
root         9  0.0  0.0      0     0 ?        S    21:45   0:00 [rcu_sched]
root        10  0.0  0.0      0     0 ?        S    21:45   0:00 [watchdog/0]
root        11  0.0  0.0      0     0 ?        S    21:45   0:00 [watchdog/1]
root        12  0.0  0.0      0     0 ?        S    21:45   0:00 [migration/1]
root        13  0.0  0.0      0     0 ?        S    21:45   0:00 [ksoftirqd/1]
root        15  0.0  0.0      0     0 ?        S<   21:45   0:00 [kworker/1:0H]
root        16  0.0  0.0      0     0 ?        S    21:45   0:00 [watchdog/2]
root        17  0.0  0.0      0     0 ?        S    21:45   0:00 [migration/2]
root        18  0.0  0.0      0     0 ?        S    21:45   0:00 [ksoftirqd/2]
root        20  0.0  0.0      0     0 ?        S<   21:45   0:00 [kworker/2:0H]
root        21  0.0  0.0      0     0 ?        S    21:45   0:00 [watchdog/3]
root        22  0.0  0.0      0     0 ?        S    21:45   0:00 [migration/3]
root        23  0.0  0.0      0     0 ?        S    21:45   0:00 [ksoftirqd/3]
root        25  0.0  0.0      0     0 ?        S<   21:45   0:00 [kworker/3:0H]
root        26  0.0  0.0      0     0 ?        S<   21:45   0:00 [khelper]
root        27  0.0  0.0      0     0 ?        S    21:45   0:00 [kdevtmpfs]
root        28  0.0  0.0      0     0 ?        S<   21:45   0:00 [netns]
root        29  0.0  0.0      0     0 ?        S<   21:45   0:00 [writeback]
root        30  0.0  0.0      0     0 ?        S<   21:45   0:00 [kintegrityd]
root        31  0.0  0.0      0     0 ?        S<   21:45   0:00 [bioset]
root        32  0.0  0.0      0     0 ?        S<   21:45   0:00 [kworker/u9:0]
root        33  0.0  0.0      0     0 ?        S<   21:45   0:00 [kblockd]
root        34  0.0  0.0      0     0 ?        S<   21:45   0:00 [ata_sff]
root        35  0.0  0.0      0     0 ?        S    21:45   0:00 [khubd]
root        36  0.0  0.0      0     0 ?        S<   21:45   0:00 [md]
root        37  0.0  0.0      0     0 ?        S<   21:45   0:00 [devfreq_wq]
root        38  0.1  0.0      0     0 ?        R    21:45   0:02 [kworker/0:1]
root        40  0.0  0.0      0     0 ?        S    21:45   0:00 [khungtaskd]
root        41  0.0  0.0      0     0 ?        S    21:45   0:00 [kswapd0]
root        42  0.0  0.0      0     0 ?        SN   21:45   0:00 [ksmd]
root        43  0.0  0.0      0     0 ?        SN   21:45   0:00 [khugepaged]
root        44  0.0  0.0      0     0 ?        S    21:45   0:00 [fsnotify_mark]
root        45  0.0  0.0      0     0 ?        S    21:45   0:00 [ecryptfs-kthre
root        46  0.0  0.0      0     0 ?        S<   21:45   0:00 [crypto]
root        58  0.0  0.0      0     0 ?        S<   21:45   0:00 [kthrotld]
root        62  0.0  0.0      0     0 ?        S    21:45   0:00 [kworker/1:1]
root        63  0.0  0.0      0     0 ?        S    21:45   0:00 [kworker/2:1]
root        82  0.0  0.0      0     0 ?        S<   21:45   0:00 [deferwq]
root        83  0.0  0.0      0     0 ?        S<   21:45   0:00 [charger_manage
root        85  0.0  0.0      0     0 ?        S    21:45   0:00 [kworker/3:1]
root       154  0.0  0.0      0     0 ?        S    21:45   0:00 [scsi_eh_0]
root       155  0.0  0.0      0     0 ?        S    21:45   0:00 [scsi_eh_1]
root       157  0.0  0.0      0     0 ?        S    21:45   0:00 [scsi_eh_2]
root       158  0.0  0.0      0     0 ?        S    21:45   0:00 [scsi_eh_3]
root       159  0.0  0.0      0     0 ?        S    21:45   0:00 [scsi_eh_4]
root       160  0.0  0.0      0     0 ?        S    21:45   0:00 [scsi_eh_5]
root       163  0.0  0.0      0     0 ?        S    21:45   0:00 [kworker/u8:5]
root       167  0.0  0.0      0     0 ?        S    21:45   0:00 [scsi_eh_6]
root       168  0.0  0.0      0     0 ?        S    21:45   0:00 [usb-storage]
root       191  0.0  0.0      0     0 ?        S<   21:45   0:00 [ttm_swap]
root       250  0.0  0.0      0     0 ?        S    21:45   0:00 [jbd2/sda7-8]
root       251  0.0  0.0      0     0 ?        S<   21:45   0:00 [ext4-rsv-conve
root       252  0.0  0.0      0     0 ?        S<   21:45   0:00 [ext4-unrsv-con
root       375  0.0  0.0   2904   608 ?        S    21:46   0:00 upstart-udev-br
root       379  0.0  0.0  11912  1824 ?        Ss   21:46   0:00 /lib/systemd/sy
root       412  0.0  0.0      0     0 ?        S    21:46   0:00 [irq/51-mei_me]
root       424  0.0  0.0      0     0 ?        S<   21:46   0:00 [kworker/u9:1]
root       439  0.0  0.0      0     0 ?        S<   21:46   0:00 [kpsmoused]
root       452  0.0  0.0      0     0 ?        S<   21:46   0:00 [kmpathd]
root       453  0.0  0.0      0     0 ?        S<   21:46   0:00 [kmpath_handler
root       461  0.0  0.0      0     0 ?        S<   21:46   0:00 [hd-audio0]
root       501  0.0  0.0      0     0 ?        S    21:46   0:00 [kworker/3:2]
root       537  0.0  0.0   2884   652 ?        S    21:46   0:00 upstart-socket-
root       538  0.0  0.0      0     0 ?        S<   21:46   0:00 [cfg80211]
root       542  0.0  0.0      0     0 ?        S    21:46   0:00 [kworker/2:2]
root       579  0.0  0.0      0     0 ?        S<   21:46   0:00 [kvm-irqfd-clea
root       655  0.0  0.1  23372  4700 ?        Ss   21:46   0:00 smbd -F
root       695  0.0  0.0   2896   600 ?        S    21:46   0:00 upstart-file-br
syslog     698  0.0  0.0  31096  1376 ?        Sl   21:46   0:00 rsyslogd -c5
102        703  0.0  0.0   4296  1892 ?        Ss   21:46   0:00 dbus-daemon --s
root       743  0.0  0.0   7624  2892 ?        Ss   21:46   0:00 /usr/sbin/modem
root       745  0.0  0.0   4864  1700 ?        Ss   21:46   0:00 /usr/sbin/bluet
root       756  0.0  0.0      0     0 ?        S<   21:46   0:00 [krfcommd]
root       765  0.0  0.0   3968  1632 ?        Ss   21:46   0:00 /lib/systemd/sy
avahi      768  0.0  0.0   3492  1496 ?        S    21:46   0:00 avahi-daemon: r
avahi      769  0.0  0.0   3492   436 ?        S    21:46   0:00 avahi-daemon: c
root       788  0.0  0.0   7856  3056 ?        Ss   21:46   0:00 /usr/sbin/cupsd
root       791  0.0  0.1  44256  5916 ?        Ssl  21:46   0:00 NetworkManager
root       795  0.0  0.0  23888  1620 ?        S    21:46   0:00 smbd -F
root       813  0.0  0.1  37032  4904 ?        Sl   21:46   0:00 /usr/lib/policy
root       830  0.0  0.0   8420  2732 ?        Ss   21:46   0:00 /usr/sbin/cups-
root       864  0.0  0.0      0     0 ?        S    21:46   0:00 [kworker/1:2]
root       888  0.0  0.0   6696  2104 ?        Ss   21:46   0:00 /sbin/wpa_suppl
root      1028  0.0  0.0   4668   860 tty4     Ss+  21:46   0:00 /sbin/getty -8
root      1031  0.0  0.0   4668   872 tty5     Ss+  21:46   0:00 /sbin/getty -8
root      1037  0.0  0.0   4668   860 tty2     Ss+  21:46   0:00 /sbin/getty -8
root      1038  0.0  0.0   4668   864 tty3     Ss+  21:46   0:00 /sbin/getty -8
root      1042  0.0  0.0   4668   860 tty6     Ss+  21:46   0:00 /sbin/getty -8
root      1063  0.0  0.0   2216   644 ?        Ss   21:46   0:00 acpid -c /etc/a
root      1097  0.0  0.0   3168   976 ?        Ss   21:46   0:00 cron
root      1114  0.0  0.0  20756  3424 ?        Ss   21:46   0:00 mdm
root      1128  0.0  0.0   3964   744 ?        Ss   21:46   0:00 /usr/sbin/irqba
root      1200  0.0  0.0   4668   868 tty1     Ss+  21:46   0:00 /sbin/getty -8
root      1223  0.0  0.0  23324  3872 ?        S    21:46   0:00 mdm
root      1233  1.8  1.0 167912 41356 tty7     Ssl+ 21:46   0:24 /usr/bin/X :0 -
root      1238  0.0  0.0      0     0 ?        S    21:46   0:00 [kauditd]
root      1240  0.0  0.0  34532  3384 ?        Sl   21:46   0:00 /usr/sbin/conso
me        1311  0.0  0.2  52456  8784 ?        Ssl  21:46   0:00 cinnamon-sessio
me        1390  0.0  0.0   4144   204 ?        Ss   21:46   0:00 /usr/bin/ssh-ag
me        1393  0.0  0.0   3872   532 ?        S    21:46   0:00 /usr/bin/dbus-l
me        1394  0.0  0.0   4600  1656 ?        Ss   21:46   0:00 //bin/dbus-daem
me        1404  0.0  0.0  46596  3748 ?        Sl   21:46   0:00 /usr/lib/at-spi
me        1408  0.0  0.0   3808  1688 ?        S    21:46   0:00 /bin/dbus-daemo
me        1411  0.0  0.0  17288  3032 ?        Sl   21:46   0:00 /usr/lib/at-spi
me        1421  0.1  0.4 337648 17600 ?        Sl   21:46   0:02 /usr/lib/cinnam
me        1426  0.0  0.0  47840  4020 ?        Sl   21:46   0:00 /usr/bin/gnome-
me        1433  0.0  0.1  99948  5500 ?        S<l  21:46   0:00 /usr/bin/pulsea
rtkit     1435  0.0  0.0  21376  1236 ?        SNl  21:46   0:00 /usr/lib/rtkit/
root      1443  0.0  0.1  37416  4056 ?        Sl   21:46   0:00 /usr/lib/upower
me        1508  0.0  0.0  27660  2712 ?        Sl   21:46   0:00 /usr/lib/gvfs/g
me        1539  0.0  0.0  45356  3332 ?        Sl   21:46   0:00 /usr/lib/gvfs//
me        1624  0.0  0.3  41776 14480 ?        Sl   21:46   0:00 /usr/bin/python
colord    1626  0.0  0.1  37876  5440 ?        Sl   21:46   0:00 /usr/lib/colord
root      1628  0.0  0.1  37244  4216 ?        Sl   21:46   0:00 /usr/lib/accoun
me        1642  0.0  0.1  52192  4168 ?        Sl   21:46   0:00 /usr/lib/cinnam
me        1647  2.0  1.3 455356 54264 ?        Sl   21:46   0:26 cinnamon --repl
me        1655  0.0  0.1  60956  7792 ?        Sl   21:46   0:00 /usr/lib/cinnam
me        1656  0.6  0.5 219168 24200 ?        Sl   21:46   0:08 nemo -n
me        1657  0.0  0.3 283576 14692 ?        Sl   21:46   0:00 nm-applet
me        1661  0.0  0.1  33304  7884 ?        Sl   21:46   0:00 /usr/lib/policy
me        1667  0.0  0.1  48760  5144 ?        Sl   21:46   0:00 /usr/lib/gvfs/g
root      1672  0.0  0.1  54648  5388 ?        Sl   21:46   0:00 /usr/lib/udisks
me        1685  0.0  0.0  26556  2424 ?        Sl   21:46   0:00 /usr/lib/gvfs/g
me        1689  0.0  0.0  27788  2844 ?        Sl   21:46   0:00 /usr/lib/gvfs/g
me        1693  0.0  0.0  39132  2576 ?        Sl   21:46   0:00 /usr/lib/gvfs/g
me        1707  0.0  0.0   9124  2536 ?        S    21:46   0:00 /usr/lib/i386-l
me        1710  0.0  0.0  48056  3776 ?        Sl   21:46   0:00 /usr/lib/gvfs/g
me        1764  0.0  0.2  52312  8388 ?        Sl   21:46   0:00 cinnamon-screen
me        1765  0.0  0.0   9244  3720 ?        S    21:46   0:00 /usr/bin/python
me        1768  0.0  0.0   2272   548 ?        S    21:46   0:00 sh -c /usr/lib/
me        1769  0.0  0.6 181904 24328 ?        Sl   21:46   0:00 python /usr/lib
me        1812  0.0  0.0  19440  3528 ?        Sl   21:49   0:00 /usr/lib/gvfs/g
me        1820  0.0  0.0  35392  2876 ?        Sl   21:50   0:00 /usr/lib/libreo
me        1841  1.1  2.0 283968 81504 ?        Sl   21:50   0:11 /usr/lib/libreo
me        1858  0.3  0.4 185780 17188 ?        Sl   21:50   0:03 gnome-terminal
me        1862  0.0  0.0   2440   748 ?        S    21:50   0:00 gnome-pty-helpe
me        1864  0.0  0.0   6276  2604 pts/0    Ss   21:50   0:00 bash
me        1932  0.0  0.0   6276  2604 pts/1    Ss+  21:50   0:00 bash
root      2020  0.0  0.0      0     0 ?        S    22:01   0:00 [kworker/u8:1]
me        2053  3.3  0.7 223612 29264 ?        Sl   22:02   0:09 gedit /media/me
me        2124  0.0  0.0  24304  2348 ?        Sl   22:05   0:00 /usr/lib/dconf/
me        2129  0.0  0.0   5240  1168 pts/0    R+   22:07   0:00 ps aux
```
### Monitoring Process with top command

Command ***top*** is used to monitor processes sorted by the CPU usage. This command updates its result for every 3 seconds. Information like how many users exists on computer, how much time since computer is on called up time, information about memory and more can be find out using this command. Press `Q` to return to shell prompt.

```bash
me@linux ~ $ top

top - 22:14:25 up 28 min,  3 users,  load average: 0.00, 0.06, 0.09
Tasks: 150 total,   1 running, 149 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.3 us,  0.2 sy,  0.0 ni, 97.0 id,  2.5 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem:   4038304 total,   926896 used,  3111408 free,    65312 buffers
KiB Swap: 10485756 total,        0 used, 10485756 free,   633792 cached
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
  PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND
 1647 me        20   0  444m  52m  24m S   1.0  1.3   0:32.61 cinnamon
 1233 root      20   0  160m  40m  30m S   0.7  1.0   0:29.57 Xorg
 1858 me        20   0  181m  16m  11m S   0.7  0.4   0:06.60 gnome-terminal
 1841 me        20   0  277m  79m  53m S   0.3  2.0   0:12.88 soffice.bin
 2176 me        20   0  5220 1304  952 R   0.3  0.0   0:00.37 top
    1 root      20   0  4044 2316 1368 S   0.0  0.1   0:01.42 init
    2 root      20   0     0    0    0 S   0.0  0.0   0:00.00 kthreadd
    3 root      20   0     0    0    0 S   0.0  0.0   0:00.13 ksoftirqd/0
    4 root      20   0     0    0    0 S   0.0  0.0   0:00.00 kworker/0:0
    5 root       0 -20     0    0    0 S   0.0  0.0   0:00.00 kworker/0:0H
    7 root      rt   0     0    0    0 S   0.0  0.0   0:00.00 migration/0
    8 root      20   0     0    0    0 S   0.0  0.0   0:00.00 rcu_bh
    9 root      20   0     0    0    0 S   0.0  0.0   0:00.71 rcu_sched
   10 root      rt   0     0    0    0 S   0.0  0.0   0:00.01 watchdog/0
   11 root      rt   0     0    0    0 S   0.0  0.0   0:00.01 watchdog/1
   12 root      rt   0     0    0    0 S   0.0  0.0   0:00.10 migration/1
   13 root      20   0     0    0    0 S   0.0  0.0   0:00.11 ksoftirqd/1  
```
## Controlling Processes

Some times we want to copy or move big files from one location to another. Or we want to execute a process which takes more time. Let's take program firefox as an example to understand process controlling.

```bash
me@linux ~ $ firefox
(process:4248): GLib-CRITICAL **: g_slice_set_config: assertion 'sys_page_size == 0' failed
(firefox:4248): GLib-GObject-WARNING **: Attempt to add property GnomeProgram::sm-connect after class was initialised
```
Notice that the shell prompt (`me@linux ~ $`) is not returned (ignore warning messages).

## Terminating Process

Since shell prompt is not returned when run the command firefox, we can't enter other command. To terminate firefox press `Ctrl`+`C`.

## Running Process in the Background

Since Linux is a multitasking system, there is a way to run more than one process through terminal. We can launch any program and can be placed it in the background. To run firefox program in background, use command firefox & .

```bash
me@linux ~ $ firefox &
[1] 4294
me@linux ~ $
(process:4294): GLib-CRITICAL **: g_slice_set_config: assertion 'sys_page_size == 0' failed
(firefox:4294): GLib-GObject-WARNING **: Attempt to add property GnomeProgram::sm-connect after class was initialiseded
ps
  PID TTY          TIME CMD
 4189 pts/0    00:00:00 bash
 4294 pts/0    00:00:01 firefox
 4341 pts/0    00:00:00 ps
```
In the second line, *[1]* represents first process running in background. *4294* is the process id (PID) assigned to firefox program. Note that shell prompt is already returned in line 3. Next two lines 4th and 5th are warning messages and can be ignored now. Enter ps command and check total processes running through current terminal.

Let's run another process in the background.

```bash
me@linux ~ $ top &
[2] 4352
```
This time the process top is given job number *[2]* and PID *4352*.

To view all processes running in background, command jobs is used.

```bash
me@linux ~ $ jobs
[1]-  Running                 firefox &
[2]+  Running                 top & 
```
## Bringing Process to Foreground

To bring background process to foreground, command ***fg*** is used followed by job number along with symbol ***%***.

```bash
me@linux ~ $ fg %1
firefox
```
`%1` is job number of firefox program preceded by symbol %.

## Pausing a Process

Pressing `Ctrl`+`Z` pauses or stops (not terminates) the process.

```bash
me@linux ~ $ fg %1
firefox
^Z
[1]+  Stopped                 firefox
```
