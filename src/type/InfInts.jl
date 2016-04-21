#=
   numeric hierarchy includes
       Int8|16|32|64|128  <: Signed <: Integer
=#

abstract ExtendsSigned <: Signed

abstract IntsWithInf{T<:Signed} <: ExtendsSigned

type ZeroAndInf{T} <: IntsWithInf end

typealias ZERO128 ZeroAndInf{Int128}
typealias ZERO64  ZeroAndInf{Int64}
typealias ZERO32  ZeroAndInf{Int32}
typealias ZERO16  ZeroAndInf{Int16}
typealias ZERO8   ZeroAndInf{Int8}

type OneAndInf{T}  <: IntsWithInf end

typealias ONE128 OneAndInf{Int128}
typealias ONE64  OneAndInf{Int64}
typealias ONE32  OneAndInf{Int32}
typealias ONE16  OneAndInf{Int16}
typealias ONE8   OneAndInf{Int8}

type InfAndInf{T}  <: IntsWithInf end

typealias INF128 InfAndInf{Int128}
typealias INF64  InfAndInf{Int64}
typealias INF32  InfAndInf{Int32}
typealias INF16  InfAndInf{Int16}
typealias INF8   InfAndInf{Int8}



immutable InfInt{T} <: IntsWithInf{T}
    val::T

    InfInt{T}(val::T) = new(val)
end

InfInt{T<:Signed}(val::T) = InfInt{T}(val)

function Base.show{T<:Signed}(io::IO, a::InfInt{T})
    print(io, dec(a.val) )
end


typealias InfInt128 InfInt{Int128}
typealias InfInt64  InfInt{Int64}
typealias InfInt32  InfInt{Int32}
typealias InfInt16  InfInt{Int16}


@delegate InfInt.val [ signbit, one, iseven, isodd]

@delegateTyped InfInt.val [-, abs, zero, one]

@delegateTyped2 InfInt.val [+,-,*,/,\,%,mod,rem,div,fld,cld]





#=
abstract ExtendedInteger{T} <: Signed

abstract   FiniteInteger{T} <: ExtendedInteger{T}
abstract InfiniteInteger{T} <: ExtendedInteger{T}

abstract     ZeroInteger{T} <: FiniteInteger{T}
abstract     UnitInteger{T} <: FiniteInteger{T}
abstract    OtherInteger{T} <: FiniteInteger{T} 

typealias SpecialInteger{T} 
          Union{ZeroInteger{T}, UnitInteger{T}, InfiniteInteger{T}}


for (I,A) in [(:FiniteInt,:FiniteInteger),
              (:InfiniteInt, :InfiniteInteger),
              (:ZeroInt, :ZeroInteger),
              (:UnitInt, :UnitInteger),
              (:OtherInt, :OtherInteger)
             ]

  @eval begin
    immutable ($I){T<:Signed} <: ($A){T}
      val::T

      ($I){T}(val::T) = new(val)
    end

    ($I){T<:Signed}(val::T) = ($I){T}(val)
  end
end
 

@inline function Base.show{T<:Integer}(io::IO, x::FiniteInt{T})
    print(io, dec(x.val))
end

@inline function Base.show{T<:Integer}(io::IO, x::ZeroInt{T})
    print(io, zero(T))
end
    
@inline function Base.show{T<:Integer}(io::IO, x::UnitInt{T})
    print(io, dec(x.val))
end

@inline function Base.show{T<:Integer}(io::IO, x::OtherInt{T})
    print(io, dec(x.val))
end

=#
