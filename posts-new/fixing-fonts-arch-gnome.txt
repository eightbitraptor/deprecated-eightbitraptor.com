::title::       Fixing font rendering in Arch/Gnome
::published::   2009-01-28
::tags::        linux,sysadmin,arch linux,fonts

If you use Arch linux you may have noticed that the default font rendering in Gnome is a bit lacking, especially if you don't have Xfce installed as well, this appears to be because Xfce installs gsfonts as one of it's dependancies yet Gnome doesn't. So the first to do is install it.

<% coderay do -%>
$ pacman -S gsfonts
<% end -%>

The next thing I like to do is to install the liberation font set, and the microsoft web fonts. These are available using pacman and can be installed as follows:

<% coderay(:lang => 'shell', :line_numbers => 'inline') do -%>
$ pacman -S ttf-liberation ttf-ms-fonts
<% end -%>

Then I like to install the versions of freetype, libxft and cairo with the cleartype patches applied. These are available from AUR, so grab them and install them. If you have yaourt you can simply do

<% coderay :lang => 'ruby', :line_numbers => 'inline' do -%>
yaourt -S cairo-cleartype freetype2-cleartype libxft-cleartype
<% end -%>

Then install the packages that it creates (usually in /tmp/yaourt somehwhere). NB: Make sure that if you have installed any of the non cleartype versions of these packages using pacman that you remove them before installing the new versions.
If you don't have yaourt installed for whatever reason you can grab the tarballs directly from the AUR repo and build the packages like this:

<% coderay(:lang => 'shell', :line_numbers => 'inline') do -%>
$ tar zxvf package.src.tar.gz
$ cd package
$ makepkg
$ pacman -U package-i686.pkg.tar.gz
<% end -%>

The remaining step is to configure your font preferences in the Gnome Appearance dialog, my preferred settings are: 
<ul>
	<li>Resolution 96dpi
	<li>Subpixel (LCD) smoothing
	<li>Slight Hinting
	<li>RGB Sub-pixel order
</ul>
Now you should be able to restart X and enjoy some much better looking fonts
