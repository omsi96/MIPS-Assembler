let i1 = Instruction.add(.r0, .r1, .r2)
let i2 = Instruction.beq(.r0, .r4, 5)
let i3 = Instruction.jump(5)
let i4 = Instruction.ret

print(i4.binary.binaryRepresentable())
