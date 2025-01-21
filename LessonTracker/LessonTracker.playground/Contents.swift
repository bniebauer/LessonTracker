import UIKit

var greeting = "Hello, playground"

let testTotal = 7

var _numOfLessons: Int = 7
var topRow: Int {
    _numOfLessons / 2
}
var bottomRow: Int {
    _numOfLessons % 2 + (_numOfLessons / 2)
}

let topRange = Range(uncheckedBounds: (lower: 0, upper: topRow))
let bottomRange = Range(uncheckedBounds: (lower: bottomRow-1, upper: _numOfLessons))
