////
////  DecomposeString.swift
////  MIPS Assembler
////
////  Created by OMAR ALIBRAHIM on 6/14/19.
////  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.
//
import Foundation



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
    
    if var immediate = (parameters.split(separator: ",").last), !immediate.contains("$")
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

//
// Main Function
func interpertation()
{
    var allInstructions: [Instruction] = []
    for i in 1...
    {
        print("\(i)> ", terminator: "")
        guard let instructionStr = readLine(), instructionStr != "-1" else {
            break
        } // user didn't input ctr+d
        
        let instructionStructure = splitInstruction(instructionStr)
        guard let instruction = Instruction(opcodeString: instructionStructure.opcode, parameters: instructionStructure.registers, immediate: instructionStructure.immediate) else
        {
            print("Wrong input!")
            continue
        }
        allInstructions.append(instruction)
    }
    print("your code can be converted as follows:- ")
    print(allInstructions.map{$0.binary.binaryRepresentable()}.description)
    
    print("Program has ended")
}



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
