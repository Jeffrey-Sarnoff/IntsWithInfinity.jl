abstract ExtendedInteger{T} <: Signed

abstract   FiniteInteger{T} <: ExtendedInteger{T}
abstract InfiniteInteger{T} <: ExtendedInteger{T}

abstract     ZeroInteger{T} <: FiniteInteger{T}
abstract     UnitInteger{T} <: FiniteInteger{T}
abstract    OtherInteger{T} <: FiniteInteger{T} 

typealias SpecialInteger{T} Union{ZeroInteger{T}, UnitInteger{T}, InfiniteInteger{T}}


immutable FiniteInt{T<:Signed} <: FiniteInteger{T}
    val::T

    FiniteInt{T}(val::T) = new(val)
end

FiniteInt{T<:Signed}(val::T) = FiniteInt{T}(val)


@inline function Base.show{T<:Integer}(io::IO, x::FiniteInt{T})
    print(io, dec(x.val))
end

    
