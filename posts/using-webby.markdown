::title::       Using Webby  
::published::   2009-01-30
::tags::        old,pointless


Recently I found the time to give theshadowaspect.com a much needed redesign and in the process decided to switch systems from the hybrid wordpress/custom thing that I was using before. Seeing as I am a sysadmin by trade working in a Ruby on Rails shop ("reevoo.com":http://www.reevoo.com for those that are interested) I wanted to use something Ruby based. Unfortunately my options were severly limited by the hosting environment that I am using.

Rails and their ilk were out of the question, seeing as my shared hosting account doesn't support it and doesn't look like it's going to anytime soon. I don't have ssh access, so installing "Passenger":http://www.modrails.com/ wasn't feasible, and in fact my only access to the account is using either ftp or the cpanel frontend that is provided.

I decided that what I needed was a static site, but one that was easy to manage and using open source tools. I also wanted to avoid php as, being frank, I've had my fill of php blogging engines.

I looked briefly at "thingamablog":http://thingamablog.sourceforge.net/, which is very cool. It's a multi-platform app (Java based), that lets you configure your site and write posts on your local machine using it's GUI, and when you are done you simply hit publish and it builds your static site, and plops it into an output directory ready for uploading to a web server. It works very well, but I wanted something Ruby based.

Due to the praise that some of my work colleagues had been heaping on it I decided to give Webby a go. It doesn't dissapoint.

Webby is basically some advanced Rake scripts that build a template for your site which you can then edit to your hearts desire, when you are done you run the build command and it creates your site and puts it in the output directory ready for upload. It's a similar concept to thingamablog, but it's done in the Ruby Way ;)

the basic workflow in webby is as follows:

* Use webby-gen to build the template for your site, there are several build in templates depending on what you want to do like website, blog, tumblog etc.

<% coderay :lang => 'ruby', :line_numbers => 'inline' do -%>
webby-gen website test
<% end -%>

This will output something similar to the following:

<% coderay :lang => 'ruby', :line_numbers => 'inline' do -%>
create  test
create  test/content
create  test/content/css
create  test/content/css/blueprint
create  test/content/css/blueprint/compressed
create  test/content/css/blueprint/lib
create  test/content/css/blueprint/plugins
create  test/content/css/blueprint/plugins/buttons
create  test/content/css/blueprint/plugins/buttons/icons
create  test/content/css/blueprint/plugins/css-classes
create  test/content/css/blueprint/plugins/fancy-type
create  test/layouts
create ...
<% end -%>

* Edit the site as you wish: pages, images and css are placed in the content directory, the layout directory contains all of your basic templates and files that define the markup for the site, these are all erb files so you can write Ruby code to do cool stuff in them. Templates for things like auto generation of partials and rss feeds are all found in the templates directory. You can write Ruby scripts for advanced content and dump them in lib. 

One cool thing about webby is that the actual content for the pages and the posts can be written in several ways, you can write straight html if that's your thing, and there are also filters for erb and textile, so you can concentrate on writing without having crap loads of markup all over the place!

* Build the site. This is as simple as doing:

<% coderay :lang => 'ruby', :line_numbers => 'inline' do -%>
webby build
<% end -%>

from your sites root directory, and will dump all the html,css, images etc into a folder called output which can then be copied to your server and you're away.

Aside from this basic workflow there are a load of other notable points that deserve a mention.

Firstly the autobuild task. Webby builds your site as normal but also starts up a webbrick server attached to port 4331, it also fires up your web browser pointing to that address. The principle being that whenever you save a file, webby automatically rebuilds it and updates the site so you can develop your site without having to keep rebuilding it all the time.

Secondly, webby has built in tasks for verifying all the external and internal links on your site. So no more worrying about having broken links on the site.

Thirdly, don't even want to ftp your site manually, webby has built-in deploy tasks so you can autmatically build and deploy your site (using scp or rsync) without ever having to leave your terminal.

There are loads more things that I could write about, such as CodeRay support (for pretty marking up and syntax highlighting of a bunch of popular languages) and partials, but this is going to go on forever so I'll leave you to discover them for yourself.

I realise this article is basically just a pimp webby session, but damn I'm so impressed I feel the need to. Additionally the entire webby directory for this site is available from my github repository, so feel free to tear it down and work out how everything works. 
