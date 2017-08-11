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
