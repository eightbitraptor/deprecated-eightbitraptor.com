::title::         SSH tab-completion in Bash
::published::     2011-11-07
::tags::          bash,programming,sysadmin

Dealing with ZSH fanbois appears to be an occupational hazard in my office. Their latest pitchfork to rattle was how zsh autocompletes hostnames that are configured in the `.ssh/config` file and tired as I was of their mocking whenever I had to rely on my bash history for a hostname, I decided to do something about it.

Looking at `man bash` and reading a little about the builtins pointed me in the direction of `complete`. The bash manpage says this about complete:

    complete (TAB)
      Attempt  to perform completion on the text before point.

And continuing a little further down, underneath the heading **Programmable Completion** is a wall of text on how to use it and the arguments it can take.

Long story, short: you can use complete a little bit like this

    complete -o default -W <word_list> <command_to_autocomplete>

So with a little bit of Awk magic I built a script to find all the hosts defined in my config file, build a word list out of them and then tell bash to autocomplete the ssh command based on my wordlist. The script looks like this:

    #!/bin/sh
    # ~/.bash/ssh_autocomplete.sh
    SSH_COMPLETE=( $(awk '/^Host [^\*]/ {print $2}' ~/.ssh/config) )
    complete -o default -W "${SSH_COMPLETE[*]}" ssh

I sourced this file from my bashrc and all is well. So how does this work? Firstly we're using Awk and a regular expression to match all of the `Host` line in my `.ssh/config` and then print the second chunk of the line, bearing in mind Awk splits on whitespace. The `SSH_COMPLETE` variable is being defined with braces around it which is bash's way of defining an array.

Next thing we're doing is telling complete to tab complete our ssh command from the dumped out contents of our `SSH_COMPLETE` array

And the final thing to do is marvel at the awesome, and watch the fanboys eat their words as I tab out ssh hostnames like sysadmin during downtime.

Bash for life!
