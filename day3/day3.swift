//
//  day3.swift
//
//
//  Created by Nate Meyvis on 12/5/16.
//
//

import Foundation

//Assumes the data is in the filename below
let filename = "day3.txt"

//Get input
let puzzleInput = try String(contentsOfFile: FileManager.default.currentDirectoryPath + "/" + filename)
//Interpret instructions as part 1 requires
let rowInstructions = puzzleInput.characters.split(separator:"\n").map {String($0).characters.split(separator: " ").map {Int(String($0))!}}
//Interpret instructions as part 2 requires
let emptyListOfInts : [Int] = []
let concatenated = rowInstructions.reduce(emptyListOfInts, +)
let left = concatenated.enumerated().filter({$0.0 % 3 == 0}).map {$0.1}
let middle = concatenated.enumerated().filter({$0.0 % 3 == 1}).map {$0.1}
let right = concatenated.enumerated().filter({$0.0 % 3 == 2}).map {$0.1}
let concatenatedColumnwise = left + middle + right
let length = concatenatedColumnwise.count / 3
let columnInstructions = (0..<length).map({Array(concatenatedColumnwise[(3 * $0)..<(3 * $0 + 3)])})

//Function for testing whether three sides, expressed as an array of three Ints, can form a triangle
func isPossibleTriangle(sides: [Int]) -> Bool {
    let largest = sides.reduce(0, {$1 > $0 ? $1 : $0})
    return sides.reduce(0, +) > 2 * largest
}

print(rowInstructions.filter({isPossibleTriangle(sides: $0) == true}).count)
print(columnInstructions.filter({isPossibleTriangle(sides: $0) == true}).count)
