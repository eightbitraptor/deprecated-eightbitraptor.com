::title:: Relaunch! Part 2: Building the basic architecture
::published:: 2011-05-21 14:39:38
::tags:: architecture,sysadmin,rails

In this entry I want to talk about where this site is hosted and exactly
how to go about setting up the Virtual Instances and getting everything
ready and talking to each other so that we can deploy and configure the
app.

### Setup

Firstly you're going to need a few things…

+ Ruby installed (wait, you do want to deploy a Rails app right?)
+ An SSH keypair that you want to use (I'll assume `~/.ssh/id_dsa` for
  now )
+ A Brightbox cloud account
+ The Brightbox CLI tools

These last 2 are the kickers! To request a Brightbox cloud beta account
you should go here and be nice: [Apply for a Brightbox cloud
account](http://beta.brightbox.com/beta).

There are 2 ways to install the Brightbox utilities depending on whether
you're on Ubuntu or not. If you are, then:

    sudo apt-get install bbcloud

and if you're not:

    gem install bbcloud

The awesome folks at Brightbox have already written documentation on how
to use the CLI apps, suffice to say it's good enough that I'm going to
save myself a few paragraphs and [just link to it](http://docs.brightbox.com/guides/getting_started) so you should go and read that and come back when you're familiar with how the tools work.

### Architecture

Back now? Good. So the next step is to plan out our architecture and to
make sure that all of our boxes can talk to each other. The basic
architecture for this site is shown in the diagram below:

<img class="figure" src="/images/BB_network.png" />

Ignoring my terrible Illustrator skills and focusing on the content you can see I have 3 (at the moment) servers, 2 main application boxes talking to a single backend database. Clearly this isn't going to serve your needs for a large traffic site, but as an education excercise and running a low traffic blog it'll do just fine.

+ **Box 1: (Kumiko)**
  
  This is where our main Varnish instance sits, requests come into this box and hit Varnish which is running on port 80.

  Sitting behind Varnish is an Apache/Passenger instance listening on
  port 8008 for any Rails request to come in.

+ **Box 2: (Yasuna)**
  
  This box just has an Apache/Passenger instance running on port 8008
  which will service Rails requests that come into it.

+ **Box 3: (Lain)**
  
  This is my database box, it's running a MySQL server instance and
  that's it. We'll configure MySQL to be greedy about the amount of
  memory it can use on this machine so we can maximise the query cache
  size and tweak the system for maximum responsiveness.

And that's it. So the next thing you'll want to do using your new found
Brightbox cloud CLI skills, is go and build yourself 3 machines. You can
call them what you want, I just use anime characters for my server names
because that's just how I roll.

I'm going to assume you're using a recent Ubuntu image for these
machines, if you didn't then you'll have to adjust the rest of these
tutorials relative to your system.

### Database Configuration

The first thing I want to do is get the database up and running so ssh
onto your shiny new (and very bare) ubuntu box and run

    sudo apt-get install mysql-server

That will, fairly obviously, install your MySQL server and all the
dependancies required to make it work. Follow the instructions and for
petes sake **make sure you set a decent and secure MySQL root password**

The next step is to configure MySQL - [You can grab my config file from
here](/misc/my.cnf.template), it's very very close to the example small
server setup that comes bundles in the examples directory of the MySQL
distribution. 

The basic gist is, we want to optimize the size of the query cache, and
various buffer sizes for the amount of memory we can realistically
allocate on the free Brightbox cloud beta, and tune concurrency so that
we can service multiple queries at a time. We are also telling mysql
where it's data directory, log files et al are to live.

If you want to know more about how much more we can wring from MySQL (and there is a lot) I thoroughly recommend adding the [MySQL performance blog](http://www.mysqlperformanceblog.com/) to your feed reader.

Finally we need to start the MySQL service by running

    sudo service mysql start

And that's all we need to do on this box for now. Later on we will need
to create users and databases, but there's little point doing that until
we have a machine that needs to talk to the database.

### Application Server 1

Right now jump on to one of your other boxes so we can start setting up
Apache and Passenger.

You're going to need a lot more software for these ones, so before you
do anything make sure your apt repositories are up to date.

    sudo apt-get update && sudo apt-get upgrade

And from then on it's basically just a case of installing stuff. Now
it's a good idea in the interest of repeatability to set up some kind of
configuration management system so we can have a safe, repeatable,
idempotent way of managing our server profiles: Something like
[Puppet](http://www.puppetlabs.com/) would be perfect.

However, pragmatically, that's a lot of overhead, so here's a bash
script that does kind of the same thing

[Matt's super duper brightbox cloud server setup script of
DOOM](/misc/setup.sh)

**Obligatory Warning:** This is hacked up based on my bash history and
it does alter files as root. It's basic and hacky. Read it, understand
what it does before you run it. It's not my fault if it kills your cat.

That script, in a nutshell does the following:

1. Installs Ruby.
2. Builds Rubygems (from source).
3. Installs Bundler.
4. Installs development libraries.
5. Installs Apache.
6. Installs Passenger.
7. Builds the mod\_rails Apache module.
8. Edits your apache2.conf to load and configure the passenger module.

Providing that has all happened successfully and no errors happened, we
end this post having 3 seperate VM's running, 2 clear web/application
servers and one database server.

This also means that I've already deviated from the rough planning list
I set out in [the introductory post](/posts/15) having merged parts 2
and 3 into one. 

The next post is going to be about how to get our Rails applications
configured with [Capistrano](https://github.com/capistrano/capistrano)
so we can deploy them easily and repeatably to our cloud hosting.

So far there's been no mention of Varnish, never fear, it is coming.
We're going to get the individual apps responding on their own IP's
before whacking Varnish in front and kicking away the stool, so to
speak.

I'll concentrate on Varnish in 1 or 2 posts time.
*
