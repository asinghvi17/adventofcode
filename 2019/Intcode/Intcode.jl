module Intcode

using OffsetArrays
using DocStringExtensions

"""
    Computer

This struct represents an Intcode computer.

## Fields
$(FIELDS)
"""
mutable struct Computer

    "The tape, represented as an Array of instructions.  Offset to 0-based indexing."
    instructions::OffsetVector{Int, Vector{Int}}

    "The current position of the tape pointer."
    position::Int

    "The current relative base of coordinates."
    relative_base::Int

    "Whether the parser has reached the end of the tape."
    finished::Bool
end

function Computer(instructions::Vector{Int})
    Computer(OffsetVector(copy(instructions), 0:(length(instructions)-1)), 0, 0, false)
end

Base.getindex(c::Computer, args...) = getindex(c.instructions, args...)
Base.setindex!(c::Computer, args...) = setindex!(c.instructions, args...)

"""
    Operation{Code}

Represents an operation.

Interface requires `nargs(Val{N})` and `execute!(c::Computer, op::Operation{N})`
to be defined for each opcode.
"""
struct Operation{Code}
    args::Vector{Int}
    Operation{Code}(args::Vector{Int}) where Code = new{Code % 100}(args)
end

nargs(i::Int) = nargs(Val(i))
nargs(::Val{1})  = 3
nargs(::Val{2})  = 3
nargs(::Val{99}) = 0

function execute!(::Computer, op::Operation{N}) where N
    @error("Invalid opcode ($N)!")
end

function execute!(c::Computer, op::Operation{1})
    in1, in2, out = op.args
    c[out] = c[in1] + c[in2]
end

function execute!(c::Computer, op::Operation{2})
    in1, in2, out = op.args
    c[out] = c[in1] * c[in2]
end

Base.IteratorSize(::Type{Computer}) = SizeUnknown()

function Base.iterate(c::Computer)
    code = c.instructions[c.position]
    argend = c.position + nargs(code)
    op = Operation{code}(c.instructions[(c.position+1):argend])
    c.position = argend + 1
    return (op, c.position)
end

function Base.iterate(c::Computer, position)
    @assert position == c.position
    code = c.instructions[c.position] % 100
    if code == 99
        return nothing
    end
    argend = c.position + nargs(code)
    op = Operation{code}(c.instructions[(c.position+1):argend])
    c.position = argend + 1
    return (op, c.position)
end

export Computer, Operation, execute!

end
