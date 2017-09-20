# 05-purescript-project

Let's try to build something bigger than little functions. A small project using purescript only could make sense. From
the various examples, we can see that purescript can build / map / render HTML views quite easily. One of the challenges
building bigger applications is quite often the performance. I want to build something with a lot of components and see
how it works out without re-rendering everything at all times. A (big) table might be a good challenge.

## Structure

It always makes sense to think about the structure first. In case of this project, this should be a reusable component
called `TableViewer`. The `TableViewer` gets headers (columns) and rows. It should be possible to change the data
without triggering a re-render of all cells.

### Building a table with types in mind

The first try is building a `Table` that consists of two same-length vectors - one for columns and one for rows. This
way, we can be sure to always have the same size in rows and columns whenever we add (or remove) a column. The cells are
instances of `Maybe X` where `X` should be the type of the corresponding column. It's easy to keep the sizes of rows and
columns in sync through vectors, but keeping the types in sync between row and column? This seems to be a harder thing
to achieve.

We have to solve two problems: First, we have to find a way to convert from a specific column type (a `Column X`) to a
cell type (`Cell X`), where `Cell` could actually be a simple `Maybe` for now. Second, we need to have a list consisting
of multiple `Column X/Y/Z` and have all rows be of `Cell X/Y/Z`, depending on the ordering of the columns.

A type class could give us the converter method needed from `Column X` to `Cell X`. So if `X` would be `Int`, `Cell Int` could be `Maybe Int` or if `X` were `List String`, the resulting `Cell` should be of type `List String` but
initialize with an empty list.

For the second problem, having `Column X : Column Y : Column Z : Nil`, we might be able to use the concept of `HList`,
but we need to create the converter for `Column X : Column Y : Column Z : Nil` to `Cell X : Cell Y : Cell Z : Nil`.
Maybe we can find a solution to have `X : Y : Z : Nil` and map it to both?
