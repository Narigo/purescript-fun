# 03 PureScript CLI

This session should try to use command line arguments or read stdin. My first impression is that the documentation is
not very informative about using purescript with node. There is a [documentation 
repository](https://github.com/purescript/documentation) where you should get all the information you need. Looking into
the table of contents, I wouldn't really know what I need to check. For a complete newbie, it looks like a bunch of 
links to various sources. It's not clear to me where I need to look. A real documentation with a search would help me
find the starting point.

For me, writing a command to run the program like `pulp run greeting XYZ` resulting in `Hello XYZ!` would be a good 
example on how to use it. When looking into `PureScript by example` - that seemed to me as the most complete 
documentation in the repository - I see a recommendation about using `purescript-yargs`. Do I really need to use a 
third-party module to be able to parse a list of arguments? Isn't there an easy way to get the `process.argv` array?

Using a search engine shows that there are other modules that wrap the NodeJS APIs. Is this really necessary? Isn't 
there an easier way than writing a wrapper around each function? Obviously, I don't really understand the concepts yet,
so back to research and find out why we really need it!

## Struggling with effects and do-Notation

After getting it to run with `purescript-node-process` (not using `purescript-yargs` for now), I could see which 
concepts I need to understand. Using `purescript-node-process` results in getting side effects when accessing a prop. 
This side effect is encoded in a `forall eff. Eff (process :: PROCESS | eff)` type definition.

You can think about side effects as "containers" for "some effect" plus a "real type" result. For me, I can relate to
this as a `Future[X]` in Scala: The `Future` is the "side effect", the `X` is the "real type". It has a strange type 
signature with `forall eff, ...`, but for now, I'll just think about it as a generic box around the real result. In the 
case of accessing `process.argv`, it results in `forall eff. Eff (process :: PROCESS | eff) (Array String)`. That means
"in a strange box called `PROCESS` effect, there is an `Array` containing `String` values".

The next thing I had to understand is how to really use that value, without thinking about the side effect. It helps 
that writing to console is a side effect as well. I've seen some "set a variable from some function call in the `do` 
notation by using `<-`" before. Knowing this, I've tried to do this inside the `do` of the main function. The result:

```purescript
module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array (head)
import Node.Process (PROCESS, argv)

greeting :: String -> String
greeting who = "Hello " <> who <> "!"

main :: forall eff. Eff (console :: CONSOLE, process :: PROCESS | eff) Unit
main = do
  arr <- argv
  log (greeting (show (head arr)))
```

Two things were completely new for me here:
1. `arr <- argv` to get the real array out of the side effected `Process.argv`
2. The main type signature got two side effects now, written like this: `main :: forall eff. Eff (console :: CONSOLE, 
process :: PROCESS | eff) Unit`. 

This was a lot of trial and error, reading about concepts that were explained a lot later than expected in the 
[Purescript by example book](https://leanpub.com/purescript/read) and even [asking questions on 
Twitter](https://twitter.com/NarigoDF/status/896987370461028352).

As I'm pretty interested to learn functional programming, I want to understand what I'm writing and why. It's hard to 
struggle with things like this early on. For me personally, it would make a lot more sense to get a basic understanding 
of the regular `main` function and its type signature than getting something thrown at from `pulp init` and not being 
able to tell how to do something that is done really simple in Node (`console.log("Hello " + process.argv[2] + "!");`).

Anyways, this was something I've been struggling with the past days but I think I can now understand the purescript 
world a bit better. As a "sneak peek", I've already heard something about the `do` notation that it's used as syntactic
sugar on `map` and `bind`. I'll have a look into this later and see what is meant by that.
