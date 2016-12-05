import Foundation

//Assumes the data is in the filename below
let filename = "day1.txt"

enum Direction : Int {case north = 0, east, south, west}

//Set initial conditions
var state = (0, 0, Direction.north)
var visited : Set<String> = [] //Maintain a list of locations for the second part
var haveSeenIntersection = false
var hash = "" //A string we use to hold string representations of locations; (Int, Int) isn't hashable in Swift
var firstIntersection = ""


func updateDirection(direction: Direction, isRight: Bool) -> Direction {
    
    //Given a direction and whether we're going right or left, returns the direction after turning
    return Direction(rawValue: (direction.rawValue + (isRight ? 1 : -1) + 4) % 4)!
}

func updateXY(x: Int, y: Int, factor: Int, direction: Direction) -> (newX: Int, newY: Int) {
    
    //Given x, y, the size of the step, and the direction, updates x and y
    //Silently updates <visited> to include intermediate steps
    let deltaX = -1 * direction.rawValue % 2 * (direction.rawValue % 4 - 2)
    let deltaY = -1 * (direction.rawValue - 1) % 2
    let newX = x + deltaX * factor, newY = y + deltaY * factor
    if haveSeenIntersection == false {
        //Gross violation of DRYness below
        //To resolve such issues I'll learn more about Swift's Ranges, Intervals, etc.
        if deltaX == 0 {
            for j in (min(y, newY) + 1)..<(max(y, newY)){
                hash = "\(x),\(j)"
                if visited.contains(hash){
                    haveSeenIntersection = true
                    firstIntersection = hash
                } else {
                    visited.insert(hash)
                    //print(hash)
                }
            }
        } else {
            for i in (min(x, newX) + 1)..<(max(x, newX)){
                hash = "\(i),\(y)"
                if visited.contains(hash){
                    haveSeenIntersection = true
                    firstIntersection = hash
                } else {
                    visited.insert(hash)
                    //print(hash)
                }
            
            }
        }
    }
    return (x + deltaX * factor, y + deltaY * factor)
    
}

func updateState(s: (Int, Int, Direction), u: (Bool, Int)) -> (Int, Int, Direction) {
    
    let newDir = updateDirection(direction: s.2, isRight: u.0)
    let newXY = updateXY(x: s.0, y: s.1, factor: u.1, direction: newDir)
    return (newXY.0, newXY.1, newDir)
    
}

func parseInput(s: String) -> ([Bool], [Int]) {
    
    //Add whitespace to the beginning for consistency later; there are other ways to fix this obv
    let s_prime = " " + s
    let tokens = s_prime.characters.split(separator: ",")
    let directions = tokens.map {$0[$0.index($0.startIndex, offsetBy: 1)] == "R"}
    let magnitudes = tokens.map {Int(String($0[$0.index($0.startIndex, offsetBy: 2)..<$0.endIndex]))!}
    return (directions, magnitudes)
}

//Get input
let puzzleInput = try String(contentsOfFile: FileManager.default.currentDirectoryPath + "/" + filename)
let (directions, magnitudes) = parseInput(s: puzzleInput)
let zipped = zip(directions, magnitudes)

//Iterate
for z in zipped{
    state = updateState(s: state, u: z)
}

//Print result
print("Distance: \(abs(Int(state.0)) + abs(Int(state.1)))")
print("First location visited twice: \(firstIntersection)")
