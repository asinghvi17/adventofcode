using Printf, DelimitedFiles, Revise

includet("../Intcode/Intcode.jl")

instructions = read("$(@__DIR__)/input.txt", String) |> x-> split(x, ',') .|> x-> parse(Int, x)

instructions[2] = 12
instructions[3] = 2

c = Intcode.Computer(instructions)

# iterate(c)
#
# c
# iterate(c, 4)

for op in c
    Intcode.execute!(c, op)
end

c.instructions[0]
