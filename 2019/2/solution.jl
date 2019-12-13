using Printf, DelimitedFiles

mods = readdlm("input.txt")

"""
    fuel(mass)

Calculates the fuel requirement for a given mass,
which is defined as:

```math
\\mathrm{floor}(\frac x3) - 2
```

Naturally a fuel requirement cannot be negative;
thus, as required by the problem, negative fuel
requirements are replaced by 0.
"""
function fuel(mass::T) where T
    
    f = floor(mass / 3) - 2 # calculate raw fuel requirement

    return f > zero(T) ? f : zero(T)

end

function loopfuel(mass::T) where T
    
    flag = false

end

@printf("%F", sum(fuels)) # print the full floating point number

