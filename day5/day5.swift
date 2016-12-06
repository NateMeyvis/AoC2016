//
//  day5.swift
//  
//
//  Created by Nate Meyvis on 12/5/16.
//
//

import Foundation

//Put your puzzle input here
let puzzleInput = "cxdnnyjw"

//This is totally cheating but in some sense counts as "solving in Swift"


func runMD5Script(s: String, b: Bool) -> String {
    //given an Int, returns an optional Character.
    //Nil if the md5 hash doesn't start with 00000
    //The next character otherwise
    let suffix = b ? "day5.py" : "day5_partb.py"
    let pythonScriptPath = "/Users/nate/Documents/aoc2016/AoC2016/day5/" + suffix
    let task = Process(), pipe = Pipe()
    task.standardOutput = pipe
    task.launchPath = "/usr/bin/env"
    task.arguments = ["python", pythonScriptPath, s]
    task.launch()
    let hash = pipe.fileHandleForReading.readDataToEndOfFile()
    let s = String(data: hash, encoding: String.Encoding.utf8)!
    return s
}

print(runMD5Script(s: puzzleInput, b: true))
print(runMD5Script(s: puzzleInput, b: false))
