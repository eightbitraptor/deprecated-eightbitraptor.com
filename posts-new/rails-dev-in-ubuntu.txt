::title::       Rails Development with Ubuntu
::published::   2009-03-31
::tags::        ubuntu,netbooks,rails,ruby,programming

Having recently purchased myself a new Dell Mini 9, I got a chance to set up a development environment for rails apps so that I can hack on the train to and from work. It's not particularly hard but I thought I'd document it for reference and hopefully someone will find this useful.

First of all a note or 2 about the hardware, the machine is a 1.6GHz Intel Atom chip. A single core, cpu that supports hyper-threading (it shows up in /proc/cpuinfo as 2 seperate cpu's but you can only control scaling on cpu0). It has a 4Gb SSD and 1Gb of RAM. This minimal spec turns out to be more than enough for a full Rails/mysql/mongrel development stack if you're careful with a few defaults.

First of all I removed all unnecesary packages using a combination of apt-get and synaptic. apt-get remove is useful if you know what you want to kill (such as openoffice.org) but I find synaptic really useful for browsing through stuff you're not sure about, libraries for example, and killing anything that doesn't sound useful.

The next step is to install ruby, rubygems and a few useful dependancies. This is covered in detail elsewhere on the web so I'll be brief, basically just:

<% coderay :lang => 'shell', :line_numbers => 'inline' do -%>
sudo apt-get install ruby1.8 irb1.8 rdoc1.8 ri1.8 \
             readline build-essential libopenssl-ruby1.8
sudo ln -s /usr/bin/ruby /usr/bin/ruby1.8 #repeat for irb,ri and rdoc
wget http://www.rubygems.org/rubygems/rubygems-1.3.1.tar.gz
tar zxvf rubygems-1.3.1.tar.gz && cd rubygems-1.3.1
sudo ruby setup.rb
<% end -%>

If you'd like a nice deb package that you can track with apt, you can replace the last step with:

<% coderay :lang => 'shell', :line_numbers => 'inline' do -%>
sudo apt-get install checkinstall
checkinstall 'sudo ruby setup.rb'
<% end -%>

"Checkinstall is an awesome piece of software":http://checkinstall.izto.org/, it's so awesome it deserves it's own post so I'll skip over the details, check it out. 

After setting up this step you should now have a fully functioning rubygems installation, test it by issuing gem -v
 
Next step is to get mysql installed and configured. I did this using apt-get, because it's easy:

<% coderay :lang => 'shell', :line_numbers => 'inline' do -%>
sudo apt-get install mysql-server mysql-client libmysql-dev
<% end -%>

Be aware that you need the mysql development headers in order to compile the mysql gem, which we will install next, alongside adding Github to our gems sources, installing rails and a bunch of other useful stuff.

<% coderay :lang => 'shell', :line_numbers => 'inline' do -%>
sudo gem sources -a http://gems.github.com
sudo gem install rails mysql sqlite3-ruby capistrano hoe hpricot webby RedCloth rake
<% end -%>

And that is pretty much all there is to it. you can now run your favourite editor (in my case gedit) and start writing Ruby.

There are a couple of Dell Mini specific issues that I had to do before I found this machine to be a truly comfortable development environment though.

# Remove the bottom Gnome taskbar, and make the fonts and theme stuff as small as possible, 1024x600 is a pretty tight screen resolution for web stuff, so it's good to make the most of it. I use a combination of 8 pt Liberation Sans and Mono for my desktop/coding fonts, at 96dpi with subpixel smoothing, and slight hinting. Clearlooks Compact GTK theme, Metabox for Metacity and the GNOME-Brave icon set.
# Slow the keyboard repeat rate down. The keyboard on the mini 9 is small, it's reasonable easy to get used to but it is exceptionally sensitive by default to repeated keypresses, which are hard to avoid on a keyboard this small. I turned my repeat rate up to it's longest setting in Gnome Keyboard preferences and the problem has pretty much gone away.
# Turn off the trackpad while typing. This gets very annoying very quickly, the trackpad is pretty sensitive and due to the size of the whole unit, you can very easily get in the way of yourself while typing, especially for longer stints (like this blog post) thankfully the default synaptic driver handles this by default, you just have to enable the daemon. To do this either:

* run <code>syndaemon -d -t</code> in a terminal to make it active per session, or
* add an entry to Gnome -> Preferences -> Sessions to make it run on login.

That's pretty much everything I've done so far. If I find anything else that works really well I'll update this post. Also any comments/suggestions then email them to me :)
