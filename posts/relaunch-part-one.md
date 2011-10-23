::title::     Relaunch! Part 1: The rewrite
::published::  2011-05-10 14:12:58
::tags::      sysadmin,architecture,rails

Welcome to the new look version of eightbitraptor.com!

Before you all sigh quietly into your coffee and skip this post just be aware that this isn't your usual hand wringing apology for not blogging in forever.

This is the first of a multi part serious of posts about the re-architecture of the site from the ground up, with a much needed Rails 3 rewrite along the way.

### Out with the old.

The old site is [available on github](http://github.com/eightbitraptor/eightbitraptor.com), it was written using [Sinatra](http://sinatrarb.com) and hosted using a free [Heroku](http://heroku.com) account. It used a flat file store for its data which allowed me to write posts in my editor of choice and simply drop them in place.

I was quite partial to this approach up until the point where I tried to
add more features, the codebase grew and grew and I realised I was
slowly implementing most of Rails ActionView!

Adding more varied types of data was also hassle, as my fragile document
system couldn't really handle anything that wasn't a simple blog post, I
needed a real data store.

Also there were no tests, which was a massive faux-pas when you're being
paid to be a professional Rails developer.

So armed with the latest Rails 3 and a [a decent text
editor](http://github.com/carlhuda/janus) I set to work

### In with the new.

There isn't really much to say about the codebase behind this app. It's
a basic Rails 3 MySQL backed web app, with a frontend written using
HTML5, CSS3 and jQuery (all the latest buzzwords obviously). [The
source is on github](http://github.com/eightbitraptor/ebr-rails) and
it's built using a variety of interesting projects. My favourite of
which is [Rails Admin](http://github.com/sferik/rails_admin) which
introspects your models to provide basic CRUD functionality.

Which means that my codebase consists predominantly of front end code,
and what little logic there is in my models is well tested using Rspec.

### So, what next?

How is he going to spin this out for more than one post? I hear you ask.
Basically the most interesting part of this whole excersise is that I am
using the new [Brightbox cloud beta](http://beta.brightbox.com/beta) for
my hosting.

Eightbitraptor lives behind a Varnish instance configured on one of my
nodes. Varnish acts as my caching layer and my load balancing layer
passing requests back to 2 seperate Apache/Passenger installs running on
their own instances.

Both of these instances are talking to a shared MySQL database instance.

I want to talk about how to set up this kind of arrangement (and a few
other asides) all on the Brightbox cloud servers running Ubuntu 10.10.

As a rough guide the next few parts will be as follows:

+ Part 1: This introduction
+ Part 2: Getting the Brightbox servers up and running
+ Part 3: Installing your database and Rails stack
+ Part 4: Deploying your app using Capistrano
+ Part 5: Using Varnish as a caching layer

This structure isn't set in stone, more articles may appear and there
this architecture isn't going to stay stable so more tweaks will be
documented in the future.

I am however sorry about not posting since last year, hopefully this
will make up for it


