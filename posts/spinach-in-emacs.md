::title::       Running Spinach in Emacs
::published::   2012-02-13
::tags::        ruby,programming,emacs

There are quite a few specific plugins and modes for doing Ruby development in Emacs and some of them are quite mature. [Cucumber.el](https://github.com/michaelklishin/cucumber.el) and [Rspec.el](https://github.com/pezra/rspec-mode) for instance allow fine grained control of all of your acceptance features and unit tests from inside Emacs.

I use Spinach for Acceptance testing, rather than Cucumber and I was looking for a simple way of being able to verify my acceptance suite without context switching away from Emacs.

There doesn't seem to be a Spinach mode as yet so as a quick workaround I've  borrowed some functionality from Rspec mode and written a quick function to run all your features.

It looks like this:

	(defun run-spinach-for-project ()
  		(interactive)
  		(rspec-from-project-root
   			(compile "bundle exec spinach"))
  		(rspec-end-of-buffer-target-window rspec-compilation-buffer-name))

to make this work, you'll need to grab this snippet and load it from somewhere inside your `.emacs.d` and run it with `M-x run-spinach-for-project`, or bind it to a keyboard shortcut

	(global-set-key (kbd "C-c s") 'run-spinach-for-project)

You'll need `rspec.el` installed to be able to use this, as I use it's functions for sniffing the project root directory and auto-scrolling the compilation buffer.

You can check out this and the rest of my Emacs configuration [on Github](http://github.com/eightbitraptor/emacs_conf)