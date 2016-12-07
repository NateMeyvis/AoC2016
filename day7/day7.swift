//
//  day7.swift
//  
//
//  Created by Nate Meyvis on 12/7/16.
//
//

// NOW I HAVE TWO PROBLEMS

// THIS TAKES TOO LONG

import Foundation
//test inputs
let test1 = "abba[mnop]qrst"
let test2 = "abcd[bddb]xyyx"
let test3 = "aaaa[qwer]tyui"
let test4 = "ioxxoj[asdfgh]zxcvbn"
let test5 = "aba[bab]xyz"
let test6 = "xyx[xyx]xyx"
let test7 = "aaa[kek]eke"
let test8 = "zazbz[bzb]cdb"

//grab input
let filename = "day7.txt"
let inputLines = try String(contentsOfFile: FileManager.default.currentDirectoryPath + "/" + filename).characters.split(separator: "\n").map {String($0)}

func hasAbbaInBrackets(s: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: "\\[[^\\]]*(.)(?!\\1)(.)\\2\\1.*\\]")
    let matches = regex.matches(in: s, options: [], range: NSRange(location: 0, length: s.utf16.count))
    return matches.first != nil
}

func hasAbbaAnywhere(s: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: ".*(.)(?!\\1)(.)\\2\\1.*")
    let matches = regex.matches(in: s, options: [], range: NSRange(location: 0, length: s.utf16.count))
    return matches.first != nil
}

func supportsTLS(s: String) -> Bool {
    return !hasAbbaInBrackets(s: s) && hasAbbaAnywhere(s: s)
}



func supportsSSL(s: String) -> Bool {
    //Could still use regex here, but trying an iterative method
    var inBrackets = false
    var currHash : String = "   "
    var hashes : [String] = [] //keep track of "winning combinations"
    var ix = s.startIndex
    var curr : Character = s[ix]
    var prev : Character = " "
    var prev2 : Character = " "
    for _ in 1..<s.utf16.count {
        ix = s.index(after:ix)
        prev2 = prev
        prev = curr
        curr = s[ix]
        //print("\(prev2)\(prev)\(curr)")
        if (curr == "[" || curr == "]") {inBrackets = !inBrackets} //Involves assumptions about formation of input (no extraneous brackets)
        if (curr == prev2 && curr != prev) {
            currHash = (inBrackets ? String("+") : String("-")) + String(curr) + String(prev)//What is the hash of the current situation?
            //print(currHash) //for debugging
            if hashes.contains(currHash) {return true} //then it corresponds to another string and we're done
            else {hashes.append((inBrackets ? String("-") : String("+")) + String(prev) + String(curr))} //add corresponding hash to hashes
        }
    }
    //print(hashes)
    return false
}

//Do the test cases work?
//print("\(supportsTLS(s: test1));\(supportsTLS(s:test2));\(supportsTLS(s:test3));\(supportsTLS(s:test4))")
//should be true / false / false / true
//Do test cases for part 2 work?
//print("\(supportsSSL(s: test5));\(supportsSSL(s:test6));\(supportsSSL(s:test7));\(supportsSSL(s:test8))")
//should be true / false / true / true
print(inputLines.filter {supportsTLS(s: $0)}.count)
print(inputLines.filter {supportsSSL(s: $0)}.count)
