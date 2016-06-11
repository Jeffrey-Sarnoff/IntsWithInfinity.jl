immutable InfInt64{I}
    val::Int64
end

immutable InfInt32{I}
    val::Int32
end

immutable InfInt16{I}
    val::Int16
end

if sizeof(Int) == sizeof(Int32)
   typealias InfInt InfInt32
else
   typealias InfInt InfInt64
end    


typealias Zero    InfInt{ 0}
typealias NonZero InfInt{ 1}
typealias PosInf  InfInt{+2}
typealias NegInf  InfInt{-2}
typealias Unbound InfInt{ 3}

typealias Zero64    InfInt64{ 0}
typealias NonZero64 InfInt64{ 1}
typealias PosInf64  InfInt64{+2}
typealias NegInf64  InfInt64{-2}
typealias Unbound64 InfInt64{ 3}

typealias Zero32    InfInt32{ 0}
typealias NonZero32 InfInt32{ 1}
typealias PosInf32  InfInt32{+2}
typealias NegInf32  InfInt32{-2}
typealias Unbound32 InfInt32{ 3}

typealias Zero16    InfInt16{ 0}
typealias NonZero16 InfInt16{ 1}
typealias PosInf16  InfInt16{+2}
typealias NegInf16  InfInt16{-2}
typealias Unbound16 InfInt16{ 3}
