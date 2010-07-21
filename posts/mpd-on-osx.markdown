::title::       Running MPD on OSX
::published::   2010-10-21
::tags::        sysadmin,music

After finally getting fed up and giving iTunes the boot, I got round to making MPD work on my Mac. and unfortunately, apt-get install it ain't!

First step is to actually get hold of and install mpd, if you're using sensible and using homebrew that's as easy as

    brew install mpd

Which will pull in all of the required dependancies and compile them all for you. Then comes the mpd config file. This is all pretty standard stuff, you can adapt from the standard and massively verbose example included with the mpd sources. Mine lives at /usr/local/Cellar/mpd/0.15.9/share/doc/mpd/mpdconf.example. The stuff you need to care about is:

    music_directory
    playlist_directory
    log_file
    db_file
    pid_file
    
    mixer_type "software"
  
Make sure these paths are all writeable by the user that you intend to run mpd as. In my case, I run mpd as the mpd user, and I made the mpd user and my normal user account members of group mpd.

What this amounts to is a music and playlist directory that the mpd user can read from and that I can add songs to. If you run a multi user system it's probably a good idea to put this somewhere outside of your home dir.

A special point regarding the mixer_type line: I have found this necessary when running on Snow Leopard to avoid mplayer crashing hard when trying to skip playing tracks, but as is normal with these things YMMV.

Once this has been set up you should be able to start mpd with 

    mpd --create-db

and watch it chug away for a while depending on how much music you have.

<h3>Client</h3>

I use the excellent Theremin, which is an OSX native MPD client and does the job admirably. If that's not your style there are an excellent array of decent mpd clients out there.

<h3>Last.fm</h3>

Last fm Scrobbling is acheived by the use of the lastfmsubmitd daemon, and it's build in client lastpd. It's dead easy to set up. Clone the sources from Github and follow the instructions in the INSTALL file. The client scrobbler lives inside the contrib folder of the checkout.

I installed lastfmsubmitd to /usr/local/bin and created it's config file, and then simply copied the contrib/lastmp script to /usr/local/bin.

One gotcha if you're not familiar with running Python stuff (I'm not) is that lastpd will bail out complaining it can't import libmpdclient2. this is easily fixed with:

    easy_install py-libmpdclient2

which will ramble on about install eggs, I guess these are pythons equivalent of gems.

<h3>Tying it all together</h3>

By this point I just wanted to listen to some music so I skipped out creating a LaunchDaemon plist and all that bollocks and wrote a wrapper script to start lastmp at the same time as mpd and dumped it in the crontab to happen on system boot. my crontab has this entry in it:

    @reboot sudo -u mpd '/usr/local/bin/mpd && /usr/local/bin/lastmp'

All that remains is to either reboot or start the services up manually and the job's a good'un 