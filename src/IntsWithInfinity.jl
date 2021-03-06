module IntsWithInfinity

import Base: hash, string, show, convert, promote_rule,
    zero, one, signbit, copysign, flipsign, abs,
    typemin, typemax, widen,
    iseven, isodd, isinf, isfinite,
    round,trunc,
    isequal, isless, (==),(!=),(<),(<=),(>=),(>),
    (~),(+),(-),(*),(/),(//),(\),(%),(^),
    widemul,div,fld,cld,rem,mod,divrem,fldmod,
    gcd, lcm, gcdx, isqrt, factorial, binomial

export InfInt8, InfInt16, InfInt32, InfInt64, InfInt128,
    iszero,nonzero,isone,isneg,nonneg,ispos,nonpos

using Genera    

include("type/InfInts.jl")

end # IntsWithInfinity

