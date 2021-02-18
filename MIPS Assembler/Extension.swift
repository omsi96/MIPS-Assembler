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
        guard 0 < paddingWidth else { return binary }
        
        return String(repeating: "0", count: paddingWidth) + binary
    }
}


extension String {
    func split(usingRegex pattern: String) -> [String] {
        //### Crashes when you pass invalid `pattern`
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(0..<utf16.count))
        let ranges = [startIndex..<startIndex] + matches.map{Range($0.range, in: self)!} + [endIndex..<endIndex]
        return (0...matches.count).map {String(self[ranges[$0].upperBound..<ranges[$0+1].lowerBound])}
    }
}
