# purescript-fun
Trying out purescript for a bit.

## First impression

Installing purescript seems like it should be just `npm install purescript`, maybe with `-g`, even though I dislike 
installing packages globally and not per project as you create dependencies to things that other users checking out the
project don't necessarily have (or use a different version).

The beginner tutorials want you to install `pulp` and `bower`. If I understood this correctly, `pulp` is a build tool 
and provides quite a few data structures (plus `Prelude`). It downloads them from bower, as bower has a different 
approach to package management than NPM. That approach allows purescript to fail at build/compile-time instead of 
runtime errors if you or your dependencies want to use different versions of the same dependency and lets you decide 
which version to use if there is a conflict of these dependencies. There is a [thorough explanation why purescript uses 
bower](http://harry.garrood.me/blog/purescript-why-bower/).

So if we don't need to `console.log` anything and not use any provided data-structure, we could compile our code with 
`purs` and run it with regular JavaScript.
