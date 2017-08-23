# 04 purescript testing

I like having tests and getting them from red to green. It gives me a sense of fulfillment (as I'm getting things done) 
and safety (as I can refactor the code later). From the first few examples I've seen and written myself, testing wasn't 
in the focus at all. Through understanding `map`, `bind`, etc. I hope I can begin and try to make tests and see how it 
works with such a type-safe language.

## The first test

After `pulp init`, we can call `pulp test` to start the tests. What can I say? It works out of the box, without changing
any configuration files.

Ok, so the test is not really there yet. We should add one it says. To do that, I tried to find out how to do testing in
purescript by looking through the [Purescript by example](https://leanpub.com/purescript/read) book again. The first 
observation is, that most of the time, the PSCi is used. A real test-runner really gets introduced in chapter 13 for the
first time, called [`purescript-quickcheck`](https://github.com/purescript/purescript-quickcheck). This is called 
property based testing from what I remember from [ScalaCheck](http://www.scalacheck.org/). I remember that writing this
kind of test is quite complicated. True, it's a lot safer than testing just a few cases, but I think it's pretty hard to
come up with something like this right from the start. I'd like to test against a few cases first and then see if I can
come up with the rule for a property. 

For example, let's think about a function called `isPrime :: Int -> Boolean` for a moment. I couldn't really come up 
with a way other than reimplementing a naive implementation of `isPrime` itself if the value is true. Searching for 
quickcheck and `isPrime` yields [an example of the `isPrime` case](https://www.fpcomplete.com/blog/2017/01/quickcheck).
It's quite complicated to set up this kind of rule, you need to write a generator for primes and, to be honest, you need
to take time understanding the final properties - why they should hold true and in some cases, how to implement them.

I don't want to give up on this way of testing, but I want to start with something simpler. 
[`purescript-test-unit`](https://github.com/bodil/purescript-test-unit) and its `Assert` module may be an easier way to 
get started with testing. As we can read on the site, it should integrate nicely with `purescript-quickcheck`. Let's 
write the first test and see how it works out.
