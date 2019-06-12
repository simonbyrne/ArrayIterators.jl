using ArrayIterators, Test

mysum(x::EachRow) = vec(sum(underlying(x),dims=1))
mysum(x::EachCol) = vec(sum(underlying(x),dims=2))


A = reshape(1:20,4,5)
@test mysum(eachrow(A)) == sum(eachrow(A))
@test mysum(eachslice(A,dims=1)) == sum(eachrow(A))

@test mysum(eachcol(A)) == sum(eachcol(A))
@test mysum(eachslice(A,dims=2)) == sum(eachcol(A))
