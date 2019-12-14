using Printf, DelimitedFiles

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

    f = mass ÷ 3 - 2 # calculate raw fuel requirement

    return f > zero(T) ? f : zero(T)

end

function totalfuel(mass)

    local_fuel = fuel(mass)

    return iszero(local_fuel) ? 0 : local_fuel + totalfuel(local_fuel)
end

mods = readdlm("$(@__DIR__)/input.txt")

part1 = sum(fuel.(mods))

@printf("Part 1: %F", part1)

part2 = sum(totalfuel.(mods))

@printf("Part 2: %F", part2)
