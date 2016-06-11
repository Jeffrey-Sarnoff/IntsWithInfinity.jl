## IntsWithInfinity.jl
#### Machine Integers augmented with positive and negative Infinities

             least magnitudes             |      greatest magnitudes
    :-------------------------------------|:--------------------------------------
     typemin( InfInt16 ) == -Infinity16     | typemax( InfInt16 ) == +Infinity16  
     &nbsp;intmin( InfInt16 )&nbsp; == typemin(Int16)  | &nbsp;intmax( InfInt16 )&nbsp; == typemax(Int16)  

```FORTH
PosInf + PosInf == PosInf - NegInf ==  PosInf
PosInf - PosInf == PosInf + NegInf ==  Unbound
PosInf + NegInf == PosInf - PosInf ==  Unbound
PosInf - NegInf == PosInf + PosInf ==  PosInf

NegInf + PosInf == NegInf - NegInf ==  Unbound
NegInf - PosInf == NegInf + NegInf ==  NegInf
NegInf + NegInf == NegInf - PosInf ==  NegInf
NegInf - NegInf == NegInf + PosInf ==  Unbound

PosInf * PosInf == PosInf / NegInf ==  PosInf
PosInf / PosInf == PosInf * NegInf ==  Unbound
PosInf * NegInf == PosInf / PosInf ==  Unbound
PosInf / NegInf == PosInf * PosInf ==  PosInf

NegInf * PosInf == NegInf / NegInf ==  Unbound
NegInf / PosInf == NegInf * NegInf ==  NegInf
NegInf * NegInf == NegInf / PosInf ==  NegInf
NegInf / NegInf == NegInf * PosInf ==  Unbound

PosInf + Int    == PosInf - Int    == Int + PosInf    ==  PosInf
NegInf + Int    == NegInf - Int    == Int - PosInf    ==  NegInf
PosInf * Int    == PosInf / Int    == Int * PosInf    ==  PosInf
NegInf * Int    == NegInf / Int    == Int * NegInf    ==  NegInf

Int / PosInf    == Int / NegInf    == Zero * Zero     ==  Zero
Zero * PosInf   == Zero * NegInf   == Zero / Zero     ==  Zero

op(x, Unbound)  == op(Unboud, x)   == Unbound
```



```julia
immutable InfInt32{I}
    val::Int32
end

typealias Zero32    InfInt32{ 0}
typealias NonZero32 InfInt32{ 1}
typealias PosInf32  InfInt32{+2}
typealias NegInf32  InfInt32{-2}
typealias Unbound32 InfInt32{ 3}

```

