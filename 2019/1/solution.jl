using Printf, DelimitedFiles

mods = readdlm("input.txt")

fuels = floor.(mods ./ 3) .- 2

@printf("%F", sum(fuels)) # print the full floating point number

