module ArrayIterators

export EachRow, EachCol

@static if VERSION < v"1.1"
    # added in https://github.com/JuliaLang/julia/pull/29749
    # once available in Compat, we should re-export here
    # https://github.com/JuliaLang/Compat.jl/issues/639
    error("Julia version $VERSION is not supported")
end

const EachRow_eachrow{A,I} = Base.Generator{I,typeof(eachrow(zeros(0,0)).f).name.wrapper{A}}
const EachCol_eachcol{A,I} = Base.Generator{I,typeof(eachcol(zeros(0,0)).f).name.wrapper{A}}

const EachRow_eachslice{A,I} = Base.Generator{I,typeof(eachslice(zeros(0,0),dims=1).f).name.wrapper{A,Tuple{},Tuple{Colon}}}
const EachCol_eachslice{A,I} = Base.Generator{I,typeof(eachslice(zeros(0,0),dims=2).f).name.wrapper{A,Tuple{Colon},Tuple{}}}

const EachRow{A,I} = Union{EachRow_eachrow{A,I}, EachRow_eachslice{A,I}}
const EachCol{A,I} = Union{EachCol_eachcol{A,I}, EachCol_eachslice{A,I}}

Base.parent(x::EachRow) = x.f.A
Base.parent(x::EachCol) = x.f.A

end # module
