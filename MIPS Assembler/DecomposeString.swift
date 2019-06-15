////
////  DecomposeString.swift
////  MIPS Assembler
////
////  Created by OMAR ALIBRAHIM on 6/14/19.
////  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.
//
//import Foundation
//
//func decompose(str: String) throws
//{
//    let lines = str.unicodeScalars.split(separator: "\n", omittingEmptySubsequences: true)
//    for line in lines{
//        let line = String(line)
//        if line.contains(" ")
//        {
//            let splitLine = line.split(separator: " ")
//            let opcode = String(splitLine[0])
//            
//            
//
//            switch instxType{
//            case .r:
//                let plainSplitLine = String(splitLine[0]).trimmingCharacters(in: .whitespacesAndNewlines)
//                let registersArray = plainSplitLine.split(separator: ",")
//                let registersArrayInt = registersArray.map{Int(($0.split(separator: "r"))[0])!}
//                let rd: Register = .rd(registersArrayInt[0])
//                let rt: Register = .rt(registersArrayInt[1])
//                let rs: Register = .rs(registersArrayInt[2])
//
//            default:
//                fatalError("I didn't finish this code yet for i type and j type")
//            }
//        }
//        else
//        {
//            // error
//        }
//
//    }
//
//}
