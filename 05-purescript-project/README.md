# 05-purescript-project

Let's try to build something bigger than little functions. A small project using purescript only could make sense. From 
the various examples, we can see that purescript can build / map / render HTML views quite easily. One of the challenges
building bigger applications is quite often the performance. I want to build something with a lot of components and see 
how it works out without re-rendering everything at all times. A (big) table might be a good challenge.

## Structure

It always makes sense to think about the structure first. In case of this project, this should be a reusable component
called `TableViewer`. The `TableViewer` gets headers (columns) and rows. It should be possible to change the data 
without triggering a re-render of all cells.
