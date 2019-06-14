//
//  Extension.swift
//  MIPS Assembler
//
//  Created by OMAR ALIBRAHIM on 6/14/19.
//  Copyright © 2019 OMAR ALIBRAHIM. All rights reserved.
//

import Foundation


extension UInt32{
    public func binaryRepresentable(length: Int = 16) -> String{
        let binary = String(self, radix: 2)
        let paddingWidth = length - binary.count
        guard 0 < paddingWidth else { return String(self) }
        
        return String(repeating: "0", count: paddingWidth) + binary
    }
}
