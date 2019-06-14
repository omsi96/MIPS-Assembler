//
//  main.swift
//  MIPS Assembler
//
//  Created by OMAR ALIBRAHIM on 6/8/19.
//  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.

import Foundation // TrimmingCharacters is found in Foundarion lel2saf
let assemblyCode =  """
                    add r0, r1, r2
                    jump 30
                    ret
                    beq r4, r4, Label
                    addi r0, r0, 45
                    """


let add: Instruction = .add(.r0, .r1, .r2)
let sub: Instruction = .sub(.r0, .r1, .r2)
print(add.binary.binaryRepresentable())
print(sub.binary.binaryRepresentable())



