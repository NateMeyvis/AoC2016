//
//  day4.swift
//  
//
//  Created by Nate Meyvis on 12/5/16.
//


/*
WARNING: VERY SLOW (takes ~15s to run on my machine)
I AM NOT AN EXPERT IN STRING MANIPULATION IN SWIFT
*/

import Foundation

//Assumes the data is in the filename below
let filename = "day4.txt"
//Get input
let inputLines = try String(contentsOfFile: FileManager.default.currentDirectoryPath + "/" + filename).characters.split(separator: "\n").map {String($0)}

//Create some dictionaries to make part 2 easier
let alphabet = "abcdefghijklmnopqrstuvwxyz"
var forward : [Character : Int] = [:]
var backward : [Int : Character] = [:]
for c in alphabet.characters.enumerated() {
    forward[c.1] = c.0
    backward[c.0] = c.1
}


func grabRoomID(s: String) -> Int {
    return Int(String(s.characters.filter({"0123456789".characters.contains($0)})))!
}

func grabBody(s: String) -> String {
    return String(s.characters.split(separator: "[")[0])
}

func grabCheck(s: String) -> String {
    return String(s.characters.split(separator: "[")[1].split(separator: "]")[0])
}

func countIn(target: String, c: Character) -> Int {
    return target.characters.filter({$0 == c}).count
}

func translateCharacter(c: Character, off: Int) -> Character {

    return forward[c] != nil ? backward[(forward[c]! + off) % 26]! : Character(" ")

}

func hasCorrectCheck(body: String, check: String) -> Bool {
    //horribly inefficient
    let sortedAlphabet = alphabet.characters.sorted(by: {(countIn(target: body, c: $0) > countIn(target: body, c: $1)) || ((countIn(target: body, c: $0) == countIn(target: body, c: $1)) && ($0 < $1))})
    let topFive = sortedAlphabet[0..<5].map({String($0)}).reduce("", +)
    return topFive == check
}

//Part 1
print(inputLines.filter({hasCorrectCheck(body: grabBody(s: $0), check: grabCheck(s: $0))}).map({grabRoomID(s: $0)}).reduce(0, +)) //part 1

//Part 2: this prints out a bunch of room names, one of which is (in my input set, at least) "northpole object storage"
for line in inputLines {
    let body = grabBody(s:line)
    let check = grabCheck(s:line)
    let room = grabRoomID(s:line)
    if hasCorrectCheck(body: body, check: check) {
        print("\(String(body.characters.map({translateCharacter(c: $0, off: room)}))) in room \(room)")
    }
}
