::title::                 Configuring polkit-1 and Devicekit (udisks) on ArchLinux
::published::             2010-06-25
::tags::                  linux,sysadmin

Endgame:
  
  * Automatic mounting of Removable media devices as a regular user
  * my main user must have sufficient permissions to be able to suspend, hibernate and shutdown the machine.
  * it must be easy for these privaleges to be configured for other users.
  
Configuration of this stuff is being carried out on a VM installed from the 2009.08 iso and updated to the latest release (pacman -Syy && pacman -Syu). with the exception of vim this is a bare install. Other software installed is noted in the documentation.

::fold::

Install

Installed all of base and base-devel and additionally:

* ipw2100-fw
* ipw2200-fw
* openssh
* sudo
* wlan-ng26-utils
* wireless_tools

Not sure why, but when I install my main machine I need wireless support so kind of force of habit and maintaining consistency etc etc.

Udev

1. changed udev log level in /etc/udev/udev.conf to info

Udisks

pacman -S udisks pulls in polkit by default, check default configuration by attempting to use a usb drive (make VirtualBox passthrough the usb port?)

udisks --dump : dumps all details of drives to stdout. udisks --poll-for-media can kick the drives to refresh their media. No testing with removable drives yet.

References

1. http://en.gentoo-wiki.org
2. http://wiki.archlinux.org
3. http://www.dreamincode.net/forums/topic/20020-using-udev-to-manage-hardware-in-linux/ (a basic intro to udev)