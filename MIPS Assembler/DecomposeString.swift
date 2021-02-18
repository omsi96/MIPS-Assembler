////
////  DecomposeString.swift
////  MIPS Assembler
////
////  Created by OMAR ALIBRAHIM on 6/14/19.
////  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.

import Foundation

// Main Function
func interpertation()
{
    var allInstructions: [(String, Instruction)] = []
    for i in 1...
    {
        print("\(i)> ", terminator: "")
        guard let instructionStr = readLine(), instructionStr != "-1" else {
            break
        } // user didn't input ctr+d
        
        if let instx = generateInstruction(instructionLine: instructionStr)
        {
            allInstructions.append(instx)
        }
    }
    printInstruction(allInstructions: allInstructions)
}


func readingFile(fileName: String)
{
    let instructions2 = instructions.trimmingCharacters(in: .whitespaces)
    let lines = instructions2.components(separatedBy: .newlines)
    var allInstructions: [(String, Instruction)] = []
    for line  in lines {
        if let instx = generateInstruction(instructionLine: line)
        {
            allInstructions.append(instx)
        }
        }
        printInstruction(allInstructions: allInstructions)
}



func generateInstruction(instructionLine: String) -> (String, Instruction)?
{
    let instructionStructure = splitInstruction(instructionLine)
    guard let instruction = Instruction(opcodeString: instructionStructure.opcode, parameters: instructionStructure.registers, immediate: instructionStructure.immediate) else
    {
        print("Wrong input!")
        return nil
    }
    return (instructionLine, instruction)
}

func printInstruction(allInstructions: [(String, Instruction)])
{
    print("your code can be converted as follows:- ")
    //    print(allInstructions.map{$0.binary.binaryRepresentable()}.description)
    print("Binary \t\t\t\t\tInstruction")
    allInstructions.forEach { (instructionTuple) in
        print(instructionTuple.1.binary.binaryRepresentable() + "\t\t" + instructionTuple.0)
    }
    print("Program has ended")
}





enum InstructionsStructure{
    case rtype3(Register, Register, Register)
    case rtype1(Register)
    case itype(Register, Register, UInt32)
    case jtype(UInt32)
    case op
}



// How can I properly make this into a class
func splitInstruction(_ instructionStr: String) -> (opcode: String, registers: [Register]?, immediate: Int?)
{
    
    guard instructionStr.contains(" ") else
    {
        return (instructionStr, nil, nil)
    }
    
    let splitedArray = instructionStr.split(separator: " ", maxSplits: 1)
    if splitedArray.count <= 1
    {
        var opcode = instructionStr
        opcode.removeAll{$0==" "}
        return (opcode, nil, nil)
    }
    let opcode = String(splitedArray[0])
    var parameters = splitedArray[1]
    var immediateValue: Int?
    var immediateIndex: Substring.Index?
    
    if var immediate = (parameters.split(separator: ",").last), !immediate.contains("$") || !immediate.contains("r")
    {
        immediate.removeAll{$0 == " "}
        immediateValue = Int(immediate)
        immediateIndex = parameters.lastIndex{String($0) == ","}
    }
    
    // removing immediate value
    if let _ = immediateValue, let index = immediateIndex
    {
        parameters.removeSubrange(index..<parameters.endIndex)
    }
    
    // check if there are any registers
    if !(parameters.contains("$") || parameters.contains("r"))
    {
        return (opcode, nil, immediateValue)
    }
    
    // removing anything else "r" and "$" and white spaces
    parameters.removeAll{$0 == " " || $0 == "r" || $0 == "$"}
    let registersStr = parameters.split(separator: ",")
    let intregisters = registersStr.map{Int($0)!}
    var regs: [Register]? = []
    let registersOpt = intregisters.map{Register(rawValue: UInt32($0))}
    
    registersOpt.forEach{ regOpt in
        guard let reg = regOpt else{
            regs = nil
            return
        }
        regs?.append(reg)
    }
    
    
    return (opcode, regs,immediateValue)
}

struct InstructionStructure{
    var opcode: String
    var registers: [Register]?
    var immediate: UInt32?
}


//func splitInstruction2(_ instructionStr: String) -> (opcode: String, registers: [Register]?, immediate: Int?)?
//{
//    let parts = instructionStr.split(usingRegex: "(\\w|,)+")
//    
//    
//    guard parts.count > 0 else
//    {
//        return nil
//    }
//    if parts.count == 1
//    {
//        return InstructionStructure(opcode: parts[0], registers: nil, immediate: nil)
//    }
//    if parts.count == 2
//    {
//        InstructionStructure(opcode: parts[0], registers:, immediate: <#T##UInt32?#>)
//    }
//    
//}


//func parse(str: String)
//{
//
//}
////
////func decompose(str: String) throws
////{
////    let lines = str.unicodeScalars.split(separator: "\n", omittingEmptySubsequences: true)
////    for line in lines{
////        let line = String(line)
////        if line.contains(" ")
////        {
////            let splitLine = line.split(separator: " ")
////            let opcode = String(splitLine[0])
////
////
////
////            switch instxType{
////            case .r:
////                let plainSplitLine = String(splitLine[0]).trimmingCharacters(in: .whitespacesAndNewlines)
////                let registersArray = plainSplitLine.split(separator: ",")
////                let registersArrayInt = registersArray.map{Int(($0.split(separator: "r"))[0])!}
////                let rd: Register = .rd(registersArrayInt[0])
////                let rt: Register = .rt(registersArrayInt[1])
////                let rs: Register = .rs(registersArrayInt[2])
////
////            default:
////                fatalError("I didn't finish this code yet for i type and j type")
////            }
////        }
////        else
////        {
////            // error
////        }
////
////    }
////
////}
