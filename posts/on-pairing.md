::title::       On Pairing
::published::   2011-06-20 22:41:00
::tags::        ruby,programming,agile


Over the last couple of years I've had the good fortune to work with several companies that practice "agile" development, from quite strict Scrum based approaches, through Kanban all the way to some ad-hoc "pick the bits that work" methods, but one of the things that has been stable throughout was the emphasis on pair programming and the belief that it improves code quality, results in better programmer productivity and introduces fewer bugs into production code.

I want to take this opportunity to put some of my thoughts on paper regarding pair programming, when I believe it's necessary, why it can help and most importantly, why it's not a silver bullet.

### Why Pair?

Pair programming has a lot of benefits, especially as part of an agile development approach. It can mean less bugs slip through into production. When two developers are working on a particular task you can pick up on mistakes that have been made that you potentially wouldn't have spotted on your own. With two people dedicated to solving a problem you'll probably end up spending less time heading down routes that you may have been tempted to follow but ultimately, may have been fruitless.

It also helps maintain focus. You have an ally in your attempts to solve a problem or build a feature. If you are prone to procrastination whilst working alone, this can be a lifesaver – you'll bounce ideas off of each other, keeping you motivated and always striving to write the best code you can.

One of the major benefits I've found personally whilst pairing has always been when working with people who are more experienced. There is in my opinion no substitute for the knowledge osmosis that can come with pairing, even for a relatively short period of time, with someone who has a better handle on the problem domain than you, or is simply a more experienced developer than you. It's hardcore on the job training, and worth it's weight in gold.

This benefit also extends to being able to discuss the problem at length, with someone who is just as emotionally involved as you, but might think differently about solving it. After all, there's no substitute for a [rubber duck that can talk back right?](http://c2.com/cgi/wiki?RubberDucking).

Pairing with someone can also help us to bring our heads down out of the clouds. There's nothing quite like someone grabbing you and pulling you back down to earth when you venture out into architecture astronaut territory, you may be in love with your fantastically elegant solution, but sometimes simplest is best and it can help to have that reiterated.

### Pair Programming is not a panacea

The problem with pair programming is that it's very developer specific. What works for one pair cannot work for everyone, that's all part of the joy of people being different! It's important to be able to work in an environment that's productive for both parties and allows everyone to just sit down and write awesome code.

You will need to make allowances, and you will need to accept that. Not everyone is going to be able to work the same way you work. Not everyone will love your awesome new blank keyboard and not everyone's going to be as productive as you are in Vim. The sooner you accept this the better. Keep multiple text editors installed, or better still, learn to use multiple editors so you can sit down with anyone and immediately be productive.

Pair programming, when done wrong can harm productivity just as much as doing it right can benefit it. If you're constantly fighting with your pair over who's approach is best, or if you can't see the screen properly, or if you just can't use someone elses tools it can be downright frustrating.

### Techniques for pairing

Wikipedia defines pairing as [the driver/navigator approach](http://en.wikipedia.org/wiki/Pair_programming) with one person typing code, and one person reviewing it as it is typed. This approach has a couple of benefits. Firstly, your driver can concentrate on the small things, the down and dirty implementation details of the method or function she is working on right now, whereas your navigator can think in more high level terms of how this particular piece of code is going to fit into the architecture, the things it needs to return and the edge cases it might have during it's use.

This is an awesome way of developing, providing that you keep in mind a few points

* __Turn off twitter:__ Seriously, it's distracting, and downright insulting to whoever you're with. If you're navigating you'll also end up losing your driver, who will wander off aimlessly without focus, unsure of where to go from the method that he's just finished.
* __Talk lots:__ Neither of you are mind readers, you can't expect anyone to know how your brain works, where you envisage the architecture heading or why in fact you think that this awesome function should return an array rather than a hash.
* __Don't be embarrased:__ No question is stupid, don't just assume that the other guy knows better than you. Neither of you will learn anything and you'll run the risk of heading off in completely the wrong direction. And similarly…
* __Don't be a dick:__ No question is stupid, just because the other guy doesn't know that you're awesome implementation is O(1) efficient doesn't make him an idiot. Just explain what you are doing and that way you'll both stay on the same page and you get the warm fuzzies at being able to teach someone something.
* __Pomodoro is shit:__ It's designed for lone developers to focus their efforts whilst ignoring distractions and disruptions. Forcing a pair to context switch every 20 minutes is a surefire way to make sure no one can concentrate properly on anything.
* __Mirror your screens:__ You should have 2 screens and they should be _mirrored_ I can't stress this enough. Forcing me to peer over your shoulder at 11pt font _will_ make me stop giving a shit about anything we're doing. I'm not killing my eyes so you can keep an email client open on a second screen (see my first point).

In my experience the best method of paring doesn't involve such formal definitions as driver and navigator, and it has no allocated time after which you should switch roles. It just involves one machine (a Mac Pro in my case), 2 screens (mirrored of course), 2 keyboards, 2 mice, and 2 developers. You can see everything that the other person is doing, if you're talking as you should be, you'll know exactly why they're doing what they're doing, and best of all, if you think it's shit you can just start typing over them!

This may sound mental, especially at the beginning of a session. You will end up with absolute chaos as you both try and talk and type over each other. But this is the beauty of it, it forces you to listen to the other person and integrate their ideas into what you're coding, it allows one person to be on a roll and write a ton, whilst still giving you the confidence of knowing that you can interrupt them at any point.

At it's best it can make pairing a very organic process, switching between 2 developers almost seamlessly, each one knowing where the other was going and where to pick up where they left off. It's these situations where you really will notice the gain in productivity, and you'll leave work at the end of the day feeling like you've got so much more done, and you'll probably make some really close friends to boot.

### Conclusions

Pair programming can be an extremely productive way to work, it can be very rewarding for all concerned. However it can just as easily fuck up your concentration, code quality and can make you despise the people you work with, and that's not even taking into account some of the other big issues, like having to syncronise lunches/breaks, and trying to make your co-workers use your custom bash profile. The most important points I am trying to get across in this post are:

1. Find what works for you and go for it. Feel free to ignore anything I've just said. If I'm talking shit and you've found the perfect way for you then that's great, run with it and I'm really pleased it works.
2. Don't let management force you to pair in a certain way. If it's not going to work then no amount of shoehorning is going to make it.
3. Don't knock it until you've tried it. Try everything until you find what works best. Honestly, it's the only way to be sure.

Special mention goes to designers ([@cgovias](http://twitter.com/cgovias) I'm looking at you). Designers need love too. Pair with your designers, show them how quickly you can get their psd's into the browser and they'll bear you in mind when they're working as well. Frontend stuff doesn't need to be painful, it just helps if the left hand knows what the right is doing! Plus you'll learn a metric fuckton of Photoshop shortcuts!
*
