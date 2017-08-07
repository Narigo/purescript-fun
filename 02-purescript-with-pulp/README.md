# PureScript with pulp

The second session is to try out purescript for real now. This time, we use `pulp` and `bower` since `pulp` is needed 
for building our purescript code and `bower` for the registries. As mentioned in the [first 
session](../01-pure-purescript/), we now have a `Prelude` and other things we can use.

Let's try it!

## Initializing the project

The project is set up by executing the following command:

```
npm install --save-dev purescript pulp bower
```

You can use pulp to initialize the project like this: 
```
./node_modules/.bin/pulp init
```

This way we don't need to install the dependencies globally and just use what we just installed through NPM. Inside the 
`package.json` `scripts` field, we can use the dependency without adding `./node_modules/.bin/` in front of it and NPM 
will find the correct tool without having to set up a bigger environment.

As I've mentioned before, I like having the setup completely inside the project. Thankfully `pulp` does not mind being 
started out of a different directory.
