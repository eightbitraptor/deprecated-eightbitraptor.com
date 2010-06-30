::title::       Managing Ubuntu instances with Puppet
::published::   2009-07-28
::tags::        ubuntu,linux,sysadmin,config management

My machines at home can be pretty varied. I like to test out distributions and tend to just format my main dev box and try out new and exciting things pretty frequently. But one thing I get really sick of is the time spent making my environment personal, getting things like commonly used software installed, and my dot files in the correct places.

I needed a way of managing my infrastructure that doesn't involve me sitting down for a couple of hours after every install grabbing packages, compiling software etc.

And that's where Puppet comes in :)

<h4>What is Puppet</h4>

[Puppet is a configuration management framework](http://reductivelabs.com/products/puppet/). It's kind of a logical step forward from [Cfengine](http://www.cfengine.org). It is written in Ruby, by Luke Kanies of Reductive Labs and basically consists of 3 things:

* A domain specific language, for declaring configurations
* A client and server application for distributing your configurations, and
* A library for interpreting and applying the configuration

Puppet makes deploying identical environments across one or multiple machines one hell of a lot easier than it would be normally, it also lets you track changes and keep specific configurations in one central repository so that you can see at a glance, what state your machines are in and what package versions they have installed etc.

It also deals with abstracting the operating system layer so that your puppet recipes can be OS agnostic, the packages are handled automatically your default package manager.

<h4>Why Puppet? What about the alternatives</h4>

There are a couple of alternatives to Puppet. Cfengine, which Puppet is meant to be a replacement for, owing to Luke Kanies experience at writing custom Cfengine plugins. The Puppet Wiki has a very good article on why Puppet is not Cfengine and how it compares, which makes very interesting reading.

The other main alternative is Chef. Chef is also written in Ruby and is definitely worth keeping an eye on. It tries to alleviate some of the main issues in Puppet, mainly that instead of a custom DSL the recipes are written in Ruby, which lets you do something like this:

    node[:gems].each do |gem|
      gem_package gem[:name] do
        version gem[:version]
        source gem[:source]
        action :install
      end
    end

where gems is just a massive hash of ruby gems, versions and sources. Currently in Puppet, installing a named gem with a specific version requires a seperate package declaration for each package, which isn't very DRY and can clutter up your recipes a bit.

At the moment Chef is in early stages and seems to be a bit of a pain to use for anything other than Ubuntu so I prefer to concentrate on using Puppet, at least until Chef gets a bit more mature.

h4. Installing Puppet and setting up the Puppet Master

Puppet is pretty easy to set up, and on a blank install of Ubuntu the process is pretty much as follows:

* Install Ruby, and Rubygems
* Install Puppet
* Write/Pull your recipes into <code>/etc/puppet/</code>
* Start the Puppetmaster daemon and create a certificate for your client
* Run Puppet.

I prefer to use a custom rubygems install rather than the provided package. This is due to Debian's lack of support for Rubygems because they have apt and don't like having multiple package providers. 

I disagree with this because Rubygems, like CPAN or Python Eggs, is a very specific package manager for a very specific purpose, but this is a topic for another post/rant! Normally I'd compile and install Rubygems using the excellent checkinstall program, but seeing as how I like to automate my system, I've included a deb with my Puppet repository. So we can install it directly from there.

So lets install ruby, clone the Puppet repository, install Rubygems and then install Puppet.

    sudo apt-get install ruby git-core
    cd /etc/ && git clone git://github.com/shadowaspect/puppet.git
    sudo dpkg -i /etc/puppet/files/deb/rubygems1.8-1.3.5_i386.deb
    sudo gem install puppet

Now we need to look at starting the server with the correct certificate name, my recipes assume that your puppetmaster host is called puppet, so make sure that it is configured in your hosts file and start up the puppetmaster with:

    sudo puppetmasterd --certname puppet

So now we have a repository of Puppet recipes and our puppetmaster running you can run puppet on the machine with

    sudo puppetd --test --verbose

This will fail the first time due to an invalid client certificate, to rectify this you need to have the puppetmaster sign the client cert, you can do this by running (on the master)

    sudo puppetca -l # for a list of unsigned certs
    sudo puppetca -s <certname> # from the above list

h4. Writing Recipes

Puppet pulls it's configuration from the files located in /etc/puppet. It basically assumes a couple of things:

* that you have a site.pp file containing node definitions for each machine/class of machine on the network
* you have a puppet.conf file detailing some information about the actual puppet process itself.

Puppet has several useful constructs available for writing recipes, stuff like classes and basic inheritance, and also defines for creating your own custom functions, you can see examples of this by checking out my github repository, but a basic node definition would look like this:

    node mattsmachine{
      package{ "apt":
        ensure => installed,
      }
      file{"/etc/apt/sources.list":
        ensure => present,
        owner => root,
        require => Package["apt"]
      }
    }

This noddy little example just makes sure that apt is installed and that the sources.list is present on the machine. You can do so much more awesome stuff than this, for which I advise you to check out the excellent tutorials on the Puppet site, and have a browse around my custom Puppet repository.

<div class="githublink">
  <a href="http://github.com/shadowaspect/puppet/tree/master">Grab the source on Github</a>
</div>

h4. Where next?

Obviously the initial install of Puppet (installing Ruby and Git by hand, compiling rubygems etc) can be pretty time consuming in itself. At work we use RedHat, and so we have created a custom kickstart file that completely automates the process of installing the operating system and performing the first puppet run. All you have to do is boot the machine from the network, point the installer at the kickstart file and go and grab a coffee while it installs the OS (from a network share), configures the network, installs ruby and puppet, locates the puppetmaster and runs puppet to install the rest of the system depending on the role it's destined to perform.

This is exceptionally neat, and I think there are definitely options out there to make something like this work with Ubuntu/Debian either via the Debian preseed files, or tools like Fai, so expect more posts on the topin in the future.

