::title::       Always Learning! Enumerable#inject and Hash#merge in Ruby
::published::   2009-05-14
::tags::        ruby,programming,tutorial

I learned something cool today. While discussing neat one liners in Ruby, someone suggested a potential challenge, it went something like this:

Given an array of numbers, how would you convert that into a hash where the key is the number and the value is the number of times that it appears in the array. so for example you start with the array

    [1,1,2,3,2,4,5,3,3,3,1,1,2,6,5,5,5,5]

And what you want to end up with is something like this:

    {5=>5, 6=>1, 1=>4, 2=>3, 3=>4, 4=>1}

So how would you do it? The solution I came up with after a couple of minutes was this:

    h = Hash.new(0)
    [1,1,2,3,2,4,5,3,3,3,1,1,2,6,5,5,5,5].each { |i| h[i] += 1 }
    puts h

This is a fairly simple solution, first you create a new hash and initialise every value with 0, then we iterate over each value of the array, passing the value to a block which finds the hash entry with the correct key and increments its value (this is acheivable because we initialise our hash with a Fixnum as a default value). I thought this was pretty neat but it turns out, as with most things in Ruby, that there is a much cooler way :)

It looks like this:

    p [1,1,2,3,2,4,5,3,3,3,1,1,2,6,5,5,5,5].inject(Hash.new(0)){ |memo,i| memo.merge({i => memo[i] += 1}) } 

So how is this working?

The first thing we need to look at is **Enumerable#inject**. This takes an argument and a block. Inject then calls the block once for every element in the Collection we are calling it for, in this case this is our array of values. The argument we give to the inject function will be yielded as the first argument to the block (memo), the second argument in the block(i) is the value in our collection we are working on.

An important thing to note with inject is that the return value of the block is passed into the block on the subsequent call, replacing the old value of our first block argument (memo in this case).

This lets us do something funky inside the block using the **Hash#merge** function. merge takes a hash as an argument and merges it's values into the hash that it's called on. A couple of examples to illustrate this (in irb):

    irb(main):007:0> {"first" => 2}.merge({"second" => 2})
    => {"second"=>2, "first"=>2}
    irb(main):001:0> {"first" => 2}.merge({"first" => 4})
    => {"first"=>4}

So what is our merge function doing? It's passing in an empty hash initialised with zeros, and for every entry in the array it's merging in a new hash that just contains the incremented value for that particular key.

The p at the beginning is just a shorthand way of saying puts, so that our final hash is printed to the terminal

Clever huh? 
