# ArrayIterators.jl

[![Travis build status](https://travis-ci.org/simonbyrne/ArrayIterators.jl.svg?branch=master)](https://travis-ci.org/simonbyrne/ArrayIterators.jl)
[![Appveyor build status](https://ci.appveyor.com/api/projects/status/iy25a8lg6pk3wt34/branch/master?svg=true)](https://ci.appveyor.com/project/simonbyrne/arrayiterators-jl/branch/master)


This exports the `EachRow` and `EachCol` type aliases, allowing users to dispatch on the iterators returned by the `eachcol`, `eachrow` and `eachslice` functions, in order to provide efficient implementations for these iterators.

Additionally it adds methods to the `parent` function from Base for accessing the matrix underlying the iterators (this is technically type piracy, but I think it is unlikely to cause problems).

## Example

```julia
julia> using ArrayIterators, BenchmarkTools

julia> U = rand(1000,1000);

julia> @btime sum(eachrow(U));
  3.161 ms (2002 allocations: 7.79 MiB)

julia> mysum(x::EachRow) = vec(sum(parent(x),dims=1))
mysum (generic function with 1 method)

julia> @btime mysum(eachrow(U));
  453.885 μs (5 allocations: 8.06 KiB)
```
