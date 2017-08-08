# 01 Pure PureScript without `pulp` and `bower`

So if we don't need to `console.log` anything or use any of the provided data-structures of `Prelude`, we could compile 
our code with `purs` and run it through a regular JavaScript call. This session provides some purescript and JavaScript 
code to run it. It does not depend on `pulp` or `bower`, but it needs foreign imports for even the most simple things 
(string concatenation in our case here).

After installing the single `purescript` dependency from NPM by executing `npm install`, you can run the code with `npm 
start`. This will build the `*.purs` files into regular JavaScript into an `output` folder by using the PureScript 
compiler `purs`. After this is done, it will run the provided [`src/index.js`](./src/index.js) file with regular node.
I've been using node v8.1.4 right now, so the `const {main}` destructuring works without any `--harmony` flags or using
`babel-node` or similar.

As you can see, setting this up is still quite some hassle especially having the `Prelude` stuff only available through
`pulp` and `bower`. Due to this, let's find out the basics of `pulp` and how it can be useful for us in the next 
session.

One thing I've seen while creating the string concatenation foreign was that purescript does not seem to understand ES6.
Instead of the following code:

```javascript
// module Simple

exports.concatString = function (a) {
  return function (b) {
    return a + b;
  };
};
```

I've tried using this, but it failed:

```javascript
// module Simple

exports.concatString = a => b => a + b;
```

It seems there is an open issue about supporting ES6 / ES2015+ etc. Hopefully this will change in the future as I've 
started to get rid of babel in a couple of projects. Node scripts can do enough right now, the only trouble is using 
modules right now.
