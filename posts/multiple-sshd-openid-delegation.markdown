::title::       Multiple SSHD servers on ArchLinux and OpenID Delegation
::published::   2009-07-12
::tags::        sysadmin,linux,ssh,openid

A reasonably productive sunday morning has led to me having a couple of interesting things to talk about :) The first is running multiple ssh daemons on the same machine, and the second id about OpenID delegation, so that you can identify yourself on OpenID enabled sites with your own personal URL, rather than the URL of your OpenID provider.

h4. Multiple SSH Servers and why you should bother?

The use case I found for running multiple SSH servers is one of security through obscurity. For instance I wanted to have my server accessible from other machines on my local network using standard password authentication so that I can log in and manage stuff remotely with relatively few restrictions. To this end I set up the standard SSH server listening on port 22. 

This works great internally and because port 22 is blocked on my firewall I don't have to worry (too much) about people outside of the network.

But what if I want to access from outside my network, for instance I want to ssh in from work and grab some music that I left at home? I don't really want to open port 22 and similarly I don't really want to restrict the internal users too much. So the best solution is to run a seperate sshd listening on a higher port with restricted security settings.

This is actually pretty easy to get set up. But there are a couple of gotchas and these instructions pertain to Arch Linux, but the basic principles are the same for any distro.

* Copy the contents of <code>/etc/ssh</code> to <code>/etc/ssh-external</code> and remove the specific host keys in the new directory.
* Edit the new sshd_config, and customise it to your liking making sure to pay attention to the following settings:<br /><br />

    Port 55225 # A new higher port to listen on
    PidFile /var/run/sshd-external.pid # Make sure that this new instance uses a seperate pid
    PubkeyAuthentication yes # enable Public Key Auth
    PasswordAuthentication no # and don't let users use passwords
    AllowUsers extern # Allow access only to the extern user

* Copy (or symlink) the sshd binary to a new location, eg. sshd-external. This is not strictly necessary however it makes tracking connections easier as the processes will show up seperately in ps and top etc.
* copy the file <code>/etc/rc.d/sshd</code> to a new location eg. <code>/etc/rc.d/sshd-external</code>
* Edit the new rc file to point to your new sshd binary and new host_key locations.<br /><br /> There is also a reference to include the file <code>/etc/conf.d/sshd</code> which defines the $SSHD_ARGS variable. You'll need to redefine the include in your new ssh rc script so that it pulls in a different file. I suggest <code>/etc/conf.d/sshd-external</code>. Once this file is defined we can use it to set our $SSHD_ARGS variable. This will need to point to our new config file and host key explicitly to stop the sshd-external daemon using the default values, as these are already in use by our standard sshd; This can be done like so:

    #
    # Parameters to be passed to sshd
    #
    SSHD_ARGS="-f /etc/ssh-external/sshd_config -h /etc/ssh-external/ssh_host_rsa_key"
    
* Once this is all set up you should then be able to login from anywhere. Providing you have remembered to take your private key with you and that the user you configured for access has your public key in his <code>~/.ssh/authorized_keys</code> file, and that you have remembered to open the correct port on your router/firewall ;)

There are a couple of extra things that you can do to improve security in addition to the standard key based auth above, one of which is to restrict your external user to a restrictive shell (ie. <code>/bin/bash --restrictive</code>) or a chroot jail, I leave this as an excercise for the reader.

h4. Delegating OpenID Authentication to your personal website.

This is going to be a much shorter section that the previous one! I love OpenID but one thing I didn't like is having to sign in using the URL to an openID provider like Flickr or LiveJournal. If I'm signing in using my identity then why the hell can't I use my own URL?

It turns out that you can, and most OpenID providers will play nice and give you instructions on how to set it up. Basically it just involves some new information in the head of your websites markup. That extra info looks a lot like this:

    <link rel="openid.server" href="http://server.myid.net/server" /> 
    <link rel="openid.delegate" href="http://username.myid.net/" /> 
    <meta http-equiv="X-XRDS-Location" content="http://username.myid.net/xrds" />

Obviously replace username with your actual OpenID providers username!

This small bit of markup now allows me to sign in to openID enabled sites with theshadowaspect.com as my identity.
