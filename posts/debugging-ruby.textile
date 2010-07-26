::title::       Debugging Ruby using -rdebug
::published::   2009-07-09
::tags::        ruby,programming

After a particularly annoying hour or two spent tracking down a problem in one of our apps recently, I spent my time wishing that Ruby had a decent debugger! Well it turns out that it does, and it's pretty nifty.

Debuggers can be amazingly helpful when a particular bit of code is borking and you're not sure why, and they save the effort of modifying your code to output debug symbols and variables all the time. You can run the debugger on a script like so:

<pre class="brush: ruby">
[08:08]sakura mtmp $ ruby -rdebug testscript.rb 
Debug.rb
Emacs support available.
/opt/local/lib/ruby/vendor_ruby/1.8/ubygems.rb:10:require 'rubygems'
(rdb:1)
</pre>

This also works with Rails projects, simply run the debugger against script/server.

First and foremost, use the h key from the debug console for help

You can set breakpoints using the syntax below. Breakpoints are lines at which the program execution will pause so you can poke around the environment.

<pre class="brush: ruby">
(rdb:1) b testscript.rb:10
Set breakpoint 1 at testscript.rb 10
(rdb:1) b testscript.rb:20
Set breakpoint 2 at testscript.rb:20
(rdb:1) 
</pre>

This is the kind of output you'd see when you hit a breakpoint: we can see the line at which the execution stopped (we defined a breakpoint above as being on testscript.rb line 20), we can also see 5 lines of context each side of the Breakpoint, from here we can step through the code or just continue the exectution as normal.

<pre class="brush: ruby">
(rdb:1) c
Breakpoint 2, toplevel at testscript.rb:20
testscript.rb:20:some_object = DoNothing.new(1)
(rdb:1) l
[15, 24] in testscript.rb
   15    def has_been_run?
   16      return @times_run
   17    end
   18  end
   19  
=> 20  some_object = DoNothing.new(1)
   21  5.times do
   22    some_object.run
   23  end
   24  
(rdb:1) 
</pre>

You can grab information about variables that are currently in scope and what their values are, the code below grabs all the instance variables belonging to the object some_object. Certain commands can also be used to grab the values of all globals and all constants that are defined in your program.

<pre class="brush: ruby">
(rdb:1) v i some_object
  @do_nothing_for => 1
  @times_run => 0
</pre>

This is just a basic introduction to the Ruby debugger, there is a ton of stuff that you can do with it, such as thread manipulation: stopping and starting the threads of your program at will, setting watchpoints and catchpoints, and loads more.