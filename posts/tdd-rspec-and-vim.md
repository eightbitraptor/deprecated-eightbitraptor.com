::title::       Testing and TDD - A small demonstration
::published::   2011-11-10
::tags::        programming,ruby,rspec,tdd,vim

A couple of weeks ago I gave a short talk about testing with rspec to the rest of the development team at On The Beach as part of our 20% time initiative.

I primarily spoke about some of my Rspec best practices around testing your models and controllers, How and when to mock, and some thoughts on Object creation libraries like Factory Girls and Machinist.

It mostly carried on from a talk fellow developer Tom ([@seenmyfate](http://twitter.com/seenmyfate)) gave first at a previous 20% time, and then again at [MagRails](http://www.magrails.com) about how to speed up your test suite. Hence there's a lot of references in here to what came before.

I've put the [slides on heroku](http://google-time-matth.heroku.com) for your viewing pleasure, although it's doubtful how much you'll get out of them without context.

I also recorded a short screencast of mmy attempt at the code demonstration. Although please bear in mind, this was recorderd spontaneously over lunch today so it's pretty slow as I actually have to think about stuff. Also I couldn't be arsed to edit this in any way, there's no sound and you get all of my typos and mistakes, and my innefficient usage of Vim will probably drive you to drink.

Please, any comments, suggestions, Vim tips then get in touch with me. Twitter, email, IRC, anything.

Now that I've got all the snivelling out of the way, I really hope this is useful to someone.

<iframe src="http://player.vimeo.com/video/31908840?title=0&amp;byline=0&amp;portrait=0" width="400" height="300" frameborder="0" webkitAllowFullScreen allowFullScreen></iframe>

The command I type at `0:15` seconds in is this:

        :map ;t :!rspec --no-color %<cr>

If you're not familiar with the syntax for Vim shortcuts, this is me telling Vim that when I press semi colon then t in normal mode I want it to run the current buffer (`%`) through the command `rspec --no-color` This is so I can really quickly run my tests and see the output inside Vim. The `--no-color` switch is required in GUI versions of Vim to avoid printing shell color codes throughout your output.

I'd recommend watching the non-HD version, the text is still readable and the framerate is much better than Vimeo's HD encoding.
