::title::       Configuring rubygems
::published::   2009-08-26
::tags::        ruby,sysadmin

After spending ages meticulously installing gems with 

<pre class="brush: bash">
matthouse [~] > sudo gem install some-random-gem --no-ri --no-rdoc
</pre>

I finally got round to trying to find a better way. It turns out that rubygems has it's own config file, which is cool. It's located at ~/.gemrc and is a simple yaml file. My gemrc now looks like this:

<pre class="brush: ruby">
:update_sources: true
:sources: 
- http://gems.rubyforge.org/
- http://gems.github.com
:backtrace: false
:verbose: true
gem: --no-ri --no-rdoc
</pre>

You can find out more about the options by running

<pre class="brush: bash">
matthouse [~] > gem help environment
</pre>

The options in my config file work as follows

* Sources: kind of speaks for itself
* backtrace: whether gem will show you stack traces on install errors
* update_sources: this tells gem to automatically update it's own sources when you install a gem
* verbose: this defines how much information gem will spit out to stdout
* gem: these are the important ones, the flags that are passed to gem on the command line
