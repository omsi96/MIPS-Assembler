//
//  Instruction.swift
//  MIPS Assembler
//
//  Created by OMAR ALIBRAHIM on 6/14/19.
//  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.
//

import Foundation


enum Instruction
{
    case add(Register, Register, Register)
    case sub(Register, Register, Register)
    case and(Register, Register, Register)
    case or(Register, Register, Register)
    case xor(Register, Register, Register)
    case not(Register)
    case srl(Register)
    case addi(Register, Register, UInt32)
    case sw(Register, Register, UInt32)
    case lw(Register, Register, UInt32)
    case beq(Register, Register, UInt32)
    case jump(UInt32)
    case jal(UInt32)
    case ret
    case nop
    
    var opcode: UInt32{
        switch self {
        case .add, .sub, .and, .or, .xor, .not, .srl: return 0b001
        case .addi: return 0b0010
        case .lw: return 0b0011
        case .sw: return 0b0100
        case .beq: return 0b0101
        case .jump: return 0b110
        case .jal: return 0b0111
        case .ret: return 0b1000
        case .nop: return 0
        }
    }
    
    var rtypeFunction: UInt32{
        switch self{
        case .add: return 0b110
            
        case .sub: return 0b111
            
        case .and: return 0b000
            
        case  .or: return 0b001
            
        case .xor: return 0b010
            
        case .not: return 0b011
            
        case .srl: return 0b100
            
        default: fatalError("You should not use this in other types!")
        }
    }
    
    var binary: UInt32
    {
        func generateOpcode(slices: [(value: UInt32, offset: Int)]) -> UInt32
        {
            var binaryInstruction: UInt32 = 0
            for slice in slices
            {
                binaryInstruction <<= slice.offset
                binaryInstruction |= slice.value
            }
            
            return binaryInstruction
        }
        
        func rtype(rd: Register, rt: Register, rs: Register) -> UInt32
        {
            return generateOpcode(slices: [
                (self.opcode,   5),
                (rs.rawValue,   3),
                (rt.rawValue,   3),
                (rd.rawValue,   3),
                (self.rtypeFunction, 3)
                ])
        }
        
        func itype(rt: Register, rs: Register, immediate: UInt32) -> UInt32
        {
            return generateOpcode(slices: [
                (self.opcode,   5),
                (rs.rawValue,   3),
                (rt.rawValue,   3),
                (immediate,     6)
                ])
        }
        
        switch self {
        case let .add(rd, rs, rt),
             let .sub(rd, rs, rt),
             let .and(rd, rs, rt),
             let .or(rd, rs, rt),
             let .xor(rd, rs, rt):
            return rtype(rd: rd, rt: rt, rs: rs)
            
        case let .not(rs),
             let .srl(rs):
            return rtype(rd: .r0, rt: .r0, rs: rs)
            
        case let .addi  (rs, rt, immediate),
             let .sw    (rs, rt, immediate),
             let .lw    (rs, rt, immediate),
             let .beq   (rs, rt, immediate):
            return itype(rt: rt, rs: rs, immediate: immediate)
            
        case let .jump(immediate),
             let .jal(immediate):
            return generateOpcode(slices: [
                (self.opcode, 5),
                (immediate, 12)
                ])
        case .ret:
            return generateOpcode(slices: [
                (self.opcode, 5),
                (0, 12)
                ])
        case .nop:
            return 0
        }
    }
}

