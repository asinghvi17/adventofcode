using Printf, DelimitedFiles, Revise

includet("../Intcode/Intcode.jl")

instructions = read("$(@__DIR__)/input.txt", String) |> x-> split(x, ',') .|> x-> parse(Int, x)

instructions[2] = 12
instructions[3] = 2

# part 1

c = Intcode.Computer(instructions)

for op in c
    Intcode.execute!(c, op)
end

@show c.instructions[0] # answer to part 1

# part 2

for noun in 0:99, verb in 0:99
    localins = copy(instructions)
    localins[2] = noun
    localins[3] = verb
    Intcode.reset!(c, localins)
    for op in c
        Intcode.execute!(c, op)
    end
    if c[0] == 19690720
        @show noun verb 100 * noun + verb
        break
    end
end
