# 04 purescript testing

I like having tests and getting them from red to green. It gives me a sense of fulfillment (as I'm getting things done) 
and safety (as I can refactor the code later). From the first few examples I've seen and written myself, testing wasn't 
in the focus at all. Through understanding `map`, `bind`, etc. I hope I can begin and try to make tests and see how it 
works with such a type-safe language.

## Before the first test

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

## The first unit tests

As I like test driven development, I began writing the test in [test/Main.purs](./test/Main.purs#L14). It took me a bit
to find out the correct imports, as I wanted to write out the complete type signature of the main test function. The 
examples in `purescript-test-unit` do not tell too much about it, so it was a lot of trial and error to get there. 
Anyways, it's actually quite nice to write tests now. The only problem left for me is my editor: The [purescript 
IntelliJ plugin](https://github.com/ikarienator/pure-idea) seems not to be able to parse imports like this: 

```purescript
import Test.Unit.Assert as Assert
``` 

The lines after the mentioned above are all marked as errors, so syntax highlighting doesn't really help there anymore. 
I'm not very confident if this gets fixed as the last update to the plugin was done three years ago and the pull request
was not added to the test-cases yet.

One additional thing that I've found out is that `Data.Array` cannot be used to pattern match easily on the input. Thus
I've used `Data.List` in the `sum` function, even though I only played around with `Data.Array` before. That's probably
only because I tried hard to use the arguments of the node process before, which is using an array instead of a list.

There are two things worth mentioning: First, I should see if I find better tools to work on purescript, the Markdown
files and git than IntelliJ and second, use `Data.List` instead of `Array` whenever you can. It's probably worth 
converting arrays to lists, but I haven't looked too deep into how to pattern match arrays yet. Just want to mention 
that the developer experience between `List` and `Array` is quite different and `List` seems to be a lot simpler, 
looking at [answers on pattern matching arrays in 
purescript](https://stackoverflow.com/questions/42450347/purescript-pattern-match-arrays-of-unknown-length).

### Splitting tests

After implementing two functions and adding tests for them, it became clear that it might be a good idea to split tests.
I've splitted this into two suites and used `Test.Main.main` to call the methods containing the suites. It doesn't look
perfect to write as I have to repeat the suites once again in the `main` method, but at least it is possible to split 
the various tests.

What I don't really like is the fact that `pulp test` warns me about not explicitly setting all imports and letting the
compiler infer all the types. Especially finding out the correct classes for the imports was a bit harder. Maybe 
different tooling might be able to help here as the compiler warnings just tell you the type, but not from where to 
import it.

### Property based testing

The next challenge is to use property based testing. As I mentioned before, I don't want to give up on this approach, it
is just a bit harder to write and read - at least from my experience in other languages. Anyways, it helps a lot to be 
sure that the function does what you want in all cases.

The first iteration of trying quickCheck tests was to make `length :: List Int -> Int` and check it with this function:

```purescript
mainQuickCheck = do
  quickCheck \xs -> length xs >= 0
```

This made `length` a lot less generic. To get it running with different types again, we need to explicitly check the 
types under test inside the tests, like this:

```purescript
mainQuickCheck = do
  quickCheck \(xs :: List Int) -> length xs >= 0
``` 

We can also add more types to this, by just duplicating the `quickCheck` line and changing the `Int` with different 
types. As I asked on Twitter how to do this, I got a helpful [tip by Harry Garrod in this 
thread](https://twitter.com/NarigoDF/status/903021096143872000). It resulted in the now current version which could 
actually have a lot more tests/checks in the `testWith` function (because of the `do` keyword):

```purescript
mainQuickCheck :: forall e. Eff (console :: CONSOLE, random :: RANDOM, exception :: EXCEPTION | e) Unit
mainQuickCheck = do
  testWith (Proxy :: Proxy Int)
  testWith (Proxy :: Proxy Char)
  testWith (Proxy :: Proxy String)
  testWith (Proxy :: Proxy Boolean)

testWith :: forall a e. Arbitrary a => Proxy a -> Eff (console :: CONSOLE, random :: RANDOM, exception :: EXCEPTION | e) Unit
testWith _ = do
  quickCheck \(xs :: List a) -> length xs >= 0
```
