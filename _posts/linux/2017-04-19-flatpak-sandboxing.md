---
layout: post
date: 2017-04-19 05:55:07 +0000
title: Flatpak Sandboxed Applications
excerpt: A tutorial to install packages in Linux based operating system using flatpak
  sandboxing technology.
comments: true
google_adsense: true
categories: linux
---
This is a tutorial to install packages in Linux based operating system using flatpak sandboxing packaging system.

## Installing core **_flatpak_** package in Ubuntu

```bash
$ sudo add-apt-repository ppa:alexlarsson/flatpak
$ sudo apt update
$ sudo apt install flatpak
```

## Adding remote repository

```bash
flatpak remote-add --if-not-exists <remote_name> <repo_url>
```

### Examples

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Gnome flatpak repo contains runtime dependencies to run other flatpak applications. Add it.
flatpak remote-add --if-not-exists gnome https://sdk.gnome.org/gnome.flatpakrepo
# Now add gnome app repo
flatpak remote-add gnome-apps https://sdk.gnome.org/gnome-apps.flatpakrepo
```

{% if jekyll.environment == 'production' and page.google_adsense %}
{% include goog_inart_2par.html %}
{% endif %}

## List all all added repositories

```basha
flatpak remote-list
```

This is the total list of added repositories.

## List all packages in remote repository

```basha
flatpak remote-ls --app <remote_name>
```

### Example

    flatpak remote-ls --app flathub

## Installing flatpak applications

### Install from downloaded **_.flatpakref_** file

```bash
flatpak install --from <path_to_.flatpakref_file>
```

#### Example

```bash
flatpak install --from ~/Downloads/org.blender.Blender.flatpakref
# or
flatpak install --from https://www.daitauha.fr/static/flatpak/blender.flatpakref
```

### Install from downloaded **_.flatpak_** package

```bash
flatpak install --bundle LibreOffice.flatpak
```

## To run application

```bash
flatpak list
flatpak run <application>
```

### Examples

```bash
flatpak run org.libreoffice.LibreOffice
# or
flatpak run org.blender.Blender
```

## To uninstall application

```bash
flatpak uninstall <application>
```

### Example

```bash
flatpak uninstall org.libreoffice.LibreOffice
```

## To update applications

### To update all applications

```bash
flatpak update
```

### To update specific application

```bash
flatpak update <application>
```

#### Example

```bash
flatpak update org.libreoffice.LibreOffice
```