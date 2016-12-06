//
//  day6.swift
//  
//
//  Created by Nate Meyvis on 12/6/16.
//
//

import Foundation

//Assumes the data is in the filename below
let filename = "day6.txt"
//Get input
let inputLines = try String(contentsOfFile: FileManager.default.currentDirectoryPath + "/" + filename).characters.split(separator: "\n")

//Keep track of what we've seen at each position
var frequencies : [Int : [Character : Int]] = [0 : [:], 1 : [:], 2 : [:], 3 : [:],
                                               4 : [:], 5 : [:], 6 : [:], 7 : [:]]

//Cycle through input
for line in inputLines{
    var ix = line.startIndex
    frequencies[0]![line[ix]] = frequencies[0]![line[ix]] == nil ? 1 : frequencies[0]![line[ix]]! + 1 // yay optionals
    for i in 1..<8{
        ix = line.index(after: ix) //trying to avoid O(n^2) algorithms here
        frequencies[i]![line[ix]] = frequencies[i]![line[ix]] == nil ? 1 : frequencies[i]![line[ix]]! + 1
    }
}

//print outputs
for i in 0..<8{
    print(frequencies[i]!.max(by: {$0.1 < $1.1})!.0)
}
print("Part 2:")
for i in 0..<8{
    print(frequencies[i]!.max(by: {$0.1 > $1.1})!.0)
}
