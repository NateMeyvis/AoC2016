//
//  day2.swift
//  
//
//  Created by Nate Meyvis on 12/5/16.
//
//

import Foundation

//Assumes the data is in the filename below
let filename = "day2.txt"

//Get input
let puzzleInput = try String(contentsOfFile: FileManager.default.currentDirectoryPath + "/" + filename)
let instructions = puzzleInput.characters.split(separator:"\n")

enum keypadDigit : Int {
    
    case one = 1, two, three, four, five, six, seven, eight, nine

    var up: keypadDigit {
        if self.rawValue <= 3 {return self}
        else {return keypadDigit(rawValue: self.rawValue - 3)!}
    }
    
    var down: keypadDigit {
        if self.rawValue >= 7 {return self}
        else {return keypadDigit(rawValue: self.rawValue + 3)!}
    }
    
    var left: keypadDigit {
        if self.rawValue % 3 == 1 {return self}
        else {return keypadDigit(rawValue: self.rawValue - 1)!}
    }
    
    var right: keypadDigit {
        if self.rawValue % 3 == 0 {return self}
        else {return keypadDigit(rawValue: self.rawValue + 1)!}
    }
    
    mutating func move(c: Character){
        switch c {
            case "U": self = self.up
            case "D": self = self.down
            case "L": self = self.left
            case "R": self = self.right
            default: break
        }
    }
    
    var description: String {return String(self.rawValue)}

}

enum modifiedKeypadDigit: Int{
    case one = 1, two, three, four, five, six, seven, eight, nine, alpha, bravo, charlie, delta
    
    var up: modifiedKeypadDigit{
        switch self.rawValue{
        case 1, 2, 4, 5, 9: return self
        case 3, 13: return modifiedKeypadDigit(rawValue: self.rawValue - 2)!
        case 6, 7, 8, 10, 11, 12: return modifiedKeypadDigit(rawValue: self.rawValue - 4)!
        default: return self
        }
    }
    
    var down: modifiedKeypadDigit{
        switch (14 - self.rawValue) {
        case 1, 2, 4, 5, 9: return self
        case 3, 13: return modifiedKeypadDigit(rawValue: (self.rawValue + 2))!
        case 6, 7, 8, 10, 11, 12: return modifiedKeypadDigit(rawValue: (self.rawValue + 4))!
        default: return self
        }
    }
    
    var left: modifiedKeypadDigit{
        switch self.rawValue{
        case 1, 2, 5, 10, 13: return self
        default: return modifiedKeypadDigit(rawValue: self.rawValue - 1)!
        }
    }
    
    var right: modifiedKeypadDigit{
        switch self.rawValue{
        case 1, 4, 9, 12, 13: return self
        default: return modifiedKeypadDigit(rawValue: self.rawValue + 1)!
        }
    }
    
    mutating func move(c: Character){
        switch c {
        case "U": self = self.up
        case "D": self = self.down
        case "L": self = self.left
        case "R": self = self.right
        default: break
        }
    }

}

var d = keypadDigit(rawValue:5)
for sequence in instructions{
    for letter in sequence {d!.move(c: letter)}
    print(d!)
}

var e = modifiedKeypadDigit(rawValue: 8)
for sequence in instructions{
    for letter in sequence{e!.move(c: letter)}
    print(e!)
}
