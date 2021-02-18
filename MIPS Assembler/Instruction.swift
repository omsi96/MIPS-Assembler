//
//  Instruction.swift
//  MIPS Assembler
//
//  Created by OMAR ALIBRAHIM on 6/14/19.
//  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.
//

import Foundation


enum Instruction{
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
        case .lw:   return 0b0011
        case .sw:   return 0b0100
        case .beq:  return 0b0101
        case .jump: return 0b110
        case .jal:  return 0b0111
        case .ret:  return 0b1000
        case .nop:  return 0
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
    
    var binary: UInt32{
        func generateOpcode(slices: [(value: UInt32, offset: Int)]) -> UInt32{
            var binaryInstruction: UInt32 = 0
            for slice in slices{
                binaryInstruction <<= slice.offset
                binaryInstruction |= slice.value
            }
            
            return binaryInstruction
        }
        
        func rtype(rd: Register, rt: Register, rs: Register) -> UInt32{
            return generateOpcode(slices: [
                (self.opcode,   5),
                (rs.rawValue,   3),
                (rt.rawValue,   3),
                (rd.rawValue,   3),
                (self.rtypeFunction, 3)
                ])
        }
        
        func itype(rt: Register, rs: Register, immediate: UInt32) -> UInt32{
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
             let .or (rd, rs, rt),
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

extension Instruction
{
    init?(opcodeString str: String, parameters: [Register]? = nil, immediate: Int? = nil){
//        var valid3Paremeters: Bool{
//            guard let parameters = parameters, parameters.count == 3 else {return false}
//            return true
//        }
        switch str{
        case "add":
            guard let parameters = parameters, parameters.count == 3 else {return nil}
            self = .add(parameters[0], parameters[1], parameters[2])
        case "sub":
            guard let parameters = parameters, parameters.count == 3 else {return nil}
            self = .sub(parameters[0], parameters[1], parameters[2])
        case "and":
            guard let parameters = parameters, parameters.count == 3 else {return nil}
            self = .and(parameters[0], parameters[1], parameters[2])
        case "or":
            guard let parameters = parameters, parameters.count == 3 else {return nil}
            self = .or(parameters[0], parameters[1], parameters[2])
        case "xor":
            guard let parameters = parameters, parameters.count == 3 else {return nil}
            self = .xor(parameters[0], parameters[1], parameters[2])
        case "not":
            guard let parameters = parameters, parameters.count == 1 else {return nil}
            self = .not(parameters[0])
        case "srl":
            guard let parameters = parameters, parameters.count == 1 else {return nil}
            self = .srl(parameters[0])
        case "addi":
            guard let parameters = parameters, parameters.count == 2 else {return nil}
            guard let immediate = immediate else {return nil}
            self = .addi(parameters[0], parameters[1], UInt32(immediate))
        case "lw":
            guard let parameters = parameters, parameters.count == 2 else {return nil}
            guard let immediate = immediate else {return nil}
            self = .lw(parameters[0], parameters[1], UInt32(immediate))
        case "sw":
            guard let parameters = parameters, parameters.count == 2 else {return nil}
            guard let immediate = immediate else {return nil}
            self = .sw(parameters[0], parameters[1],  UInt32(immediate))
        case "beq":
            guard let parameters = parameters, parameters.count == 2 else {return nil}
            guard let immediate = immediate else {return nil}
            self = .beq(parameters[0], parameters[1], UInt32(immediate))
        case "jump":
            guard parameters == nil else {return nil}
            guard let immediate = immediate else {return nil}
            self = .jump(UInt32(immediate))
        case "jal":
            guard parameters == nil else {return nil}
            guard let immediate = immediate else {return nil}
            self = .jal(UInt32(immediate))
        case "ret":
            guard parameters == nil else {return nil}
            guard immediate == nil else {return nil}
            self = .ret
        case "nop":
            guard parameters == nil else {return nil}
            guard immediate == nil else {return nil}
            self = .nop
        default:
            return nil
        }
    }
    var opcodeString: String{
        switch self{
        case .add:  return "add"
        case .sub:  return "sub"
        case .and:  return "and"
        case .or:   return "or"
        case .xor:  return "xor"
        case .not:  return "not"
        case .srl:  return "srl"
        case .addi: return "addi"
        case .lw:   return "lw"
        case .sw:   return "sw"
        case .beq:  return "beq"
        case .jump: return "jump"
        case .jal:  return "jal"
        case .ret:  return "ret"
        case .nop:  return "nop"
        }
    }
}

