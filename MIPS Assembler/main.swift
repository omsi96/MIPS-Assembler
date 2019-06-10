//
//  main.swift
//  MIPS Assembler
//
//  Created by OMAR ALIBRAHIM on 6/8/19.
//  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.
//
import Foundation

let s = #"s\n\n\n"#
print(#"Omar\nomar\tomar\r\t\(fd)"#)

let assemblyCode =
"""
add r0, r1, r2
jump 30
ret
beq r4, r4, Label
addi r0, r0, 45
"""


func decompose(str: String) throws
{

    let lines = assemblyCode.unicodeScalars.split(separator: "\n", omittingEmptySubsequences: true)
    for line in lines{
        let line = String(line)
        if line.contains(" ")
        {
            let splitLine = line.split(separator: " ")
            let opcode = String(splitLine[0])
            guard let instxType = instructionType.validate(opcode: opcode) else {
                fatalError("I want to always now be able to parse it")
            }
            
            switch instxType{
            case .r:
                let plainSplitLine = String(splitLine[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                let registersArray = plainSplitLine.split(separator: ",")
                let registersArrayInt = registersArray.map{Int(($0.split(separator: "r"))[0])!}
                let rs: Register = .rs(registersArrayInt[0])
                let rt: Register = .rt(registersArrayInt[1])
                let rd: Register = .rd(registersArrayInt[2])
                
            default:
                fatalError("I didn't finish this code yet for i type and j type")
            }
        }
        else
        {
            // error
        }
        
    }
    
}




enum instructionType
{
    enum INSTX: String{
        case add, sub, div, mul, addi, sw, lw, beq, jump, jal, nop
    }
    
    case r
    case i
    case j
    case nop
    
    init(opcode: INSTX)
    {
        switch opcode
        {
            case .add, .sub, .mul, .div     : self = .r
            case .addi, .beq, .sw, .lw      : self = .i
            case .jump, .jal                : self = .j
            case .nop                       : self = .nop
        }
    }
    
    static func validate(opcode: String) -> instructionType?
    {
        guard let opcode = instructionType.INSTX.init(rawValue: opcode) else {return nil}
        return instructionType(opcode: opcode)
    }
    
}



//struct Register
//{
//    var size: UInt8
//    var value: UInt32
//}

enum Register
{
    case rs(Int), rt(Int), rd(Int)
}

enum InstructionBody
{
    case Register
}
struct Instruction
{
    var opcode: instructionType.INSTX
    var registers: instructionType
}
//
