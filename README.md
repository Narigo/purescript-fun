# purescript-fun

Trying out purescript for a bit and blogging about my impression and findings.

## First impression

Installing purescript seems like it should be just `npm install purescript`, maybe with `-g`, even though I dislike 
installing packages globally and not per project. As you create dependencies to things that other users checking out the
project don't necessarily have (or have a different version of), this always may lead to problems.

The beginner tutorials want you to install `pulp` and `bower`. If I understood this correctly, `pulp` is a build tool 
and provides quite a few data structures (plus `Prelude`). It downloads them from bower, as bower has a different 
approach to package management than NPM. That approach allows purescript to fail at build/compile-time instead of 
runtime errors if you or your dependencies want to use different versions of the same dependency and lets you decide 
which version to use if there is a conflict of these dependencies. There is a [thorough explanation why purescript uses 
bower](http://harry.garrood.me/blog/purescript-why-bower/).

## Pure PureScript without `pulp` and `bower`.

So if we don't need to `console.log` anything or use any of the provided data-structures of `Prelude`, we could compile 
our code with `purs` and run it through a regular JavaScript call. The first session is in
[01-pure-purescript](./01-pure-purescript), which provides some purescript and JavaScript code to run it. It does not 
depend on `pulp` or `bower`, but it needs foreign imports for even the most simple things (string concatenation in our
case here).
