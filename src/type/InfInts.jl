#=
   numeric hierarchy includes
       Int8|16|32|64|128  <: Signed <: Integer
=#

abstract ExtendsSigned <: Signed

abstract IntsWithInf{T} <: ExtendsSigned

type ZeroAndInf{T} <: IntsWithInf{T} ZeroAndInf{T}(::Type{T}) = new() end; 
Zero64 = ZeroAndInf{Int64}(Int64)

type OneAndInf{T}  <: IntsWithInf{T} end
type InfAndInf{T}  <: IntsWithInf{T} end

typealias ZERO128 ZeroAndInf{Int128}
typealias ZERO64  ZeroAndInf{Int64}
typealias ZERO32  ZeroAndInf{Int32}
typealias ZERO16  ZeroAndInf{Int16}
typealias ZERO8   ZeroAndInf{Int8}

typealias ONE128 OneAndInf{Int128}
typealias ONE64  OneAndInf{Int64}
typealias ONE32  OneAndInf{Int32}
typealias ONE16  OneAndInf{Int16}
typealias ONE8   OneAndInf{Int8}


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

InfInt0{128}() = zero(Int128)
InfInt0{64}()  = zero(Int64)
InfInt0{32}()  = zero(Int32)
InfInt0{16}()  = zero(Int16)
InfInt0{8}()   = zero(Int8)

InfInt1{128}() = one(Int128)
InfInt1{64}()  = one(Int64)
InfInt1{32}()  = one(Int32)
InfInt1{16}()  = one(Int16)
InfInt1{8}()   = one(Int8)

for op in [:+,:-]
  @eval begin
      ($op){T<:Integer}(a::InfInt{T}, b::ZeroAndInt{T}) = ($op)(a, InfInt0{T}())
      ($op){T<:Integer}(a::ZeroAndInt{T}, b::InfInt{T}) = ($op)(InfInt0{T}(),b)
      ($op){T<:Integer}(a::InfInt{T}, b::OneAndInt{T}) = ($op)(a, InfInt1{T}())
      ($op){T<:Integer}(a::OneAndInt{T}, b::InfInt{T}) = ($op)(InfInt1{T}(),b)

      ($op){T<:Integer}(a::InfInt{T}, ::Type{ZeroAndInt{T}}) = ($op)(a, InfInt0{T}())
      ($op){T<:Integer}(::Type{ZeroAndInt{T}}, b::InfInt{T}) = ($op)(InfInt0{T}(),b)
      ($op){T<:Integer}(a::InfInt{T}, ::Type{OneAndInt{T}}) = ($op)(a, InfInt1{T}())
      ($op){T<:Integer}(a::OneAndInt{T}, ::Type{InfInt{T}}) = ($op)(InfInt1{T}(),b)
  end
end  

for op in [:*]
  @eval begin
      ($op){T<:Integer}(a::InfInt{T}, b::ZeroAndInt{T}) = ZeroAndInf{T}
      ($op){T<:Integer}(a::ZeroAndInt{T}, b::InfInt{T}) = ZeroAndInf{T}
      ($op){T<:Integer}(a::InfInt{T}, b::OneAndInt{T}) = a
      ($op){T<:Integer}(a::OneAndInt{T}, b::InfInt{T}) = b

      ($op){T<:Integer}(a::InfInt{T}, ::Type{ZeroAndInt{T}}) = ZeroAndInf{T}
      ($op){T<:Integer}(::Type{ZeroAndInt{T}}, b::InfInt{T}) = ZeroAndInf{T}
      ($op){T<:Integer}(a::InfInt{T}, ::Type{OneAndInt{T}}) = a
      ($op){T<:Integer}(::Type{OneAndInt{T}}, b::InfInt{T}) = b
  end
end

for op in [:/]
  @eval begin
      ($op){T<:Integer}(a::InfInt{T}, b::ZeroAndInt{T}) = IntAndInf{T}
      ($op){T<:Integer}(a::ZeroAndInt{T}, b::InfInt{T}) = ZeroAndInf{T}
      ($op){T<:Integer}(a::InfInt{T}, b::OneAndInt{T}) = IntAndInf{T}
      ($op){T<:Integer}(a::OneAndInt{T}, b::InfInt{T}) = ZeroAndInf{T}

      ($op){T<:Integer}(a::InfInt{T}, ::Type{ZeroAndInt{T}}) = IntAndInf{T}
      ($op){T<:Integer}(::Type{ZeroAndInt{T}}, b::InfInt{T}) = ZeroAndInf{T}
      ($op){T<:Integer}(a::InfInt{T}, ::Type{OneAndInt{T}}) = IntAndInf{T}
      ($op){T<:Integer}(::Type{OneAndInt{T}}, b::InfInt{T}) = ZeroAndInf{T}
  end
end  


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
