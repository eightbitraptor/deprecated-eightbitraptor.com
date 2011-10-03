::title::       Defining a cron job that happens on machine reboot
::published::   2009-08-20
::tags::        ruby,sysadmin,linux

I have an app that uses the Sphinx search engine and it's partner Rails plugin thinking-sphinx. This is a neat little search engine that can be embedded into Rails projects.

The only downside is that you need to start the server before the app will run properly. You start thinking sphinx by running

<pre class="brush: ruby">
rake ts:start
</pre>

I started writing a full init script for this until I realised that writing a massive init script that I can manage with chkconfig (our servers are Redhat Enterprise) is slightly overkill for one freaking rake task. 

After some research I found out that our venerable friend cron supports running tasks on reboot, you simply need to define your job with @reboot instead of the standard time information. 

Nothing is as enlightening as an example so here goes nothing

<pre class="brush: bash">
matthouse@sakura $ crontab -l
@reboot echo "cron is ace" >> /tmp/somefile
</pre>

to read more check @man 5 crontab@ and read *all* the way to the bottom
