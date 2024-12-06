//
//  AoCModel.swift
//  aoc24
//
//  Created by Francesco Puglisi on 04.12.24.
//

import Foundation
@Observable
final class AoCModel {
    var result: Int = 0
    func perform() {
        let start = labMap
            .first { key, value in
                Guard.Orientation.up.char == value
            }
            .map { key, value in
                Guard(location: key, orientation: .up)
            }
        print(start)
        if let start {
            for step in GuardPath(guard_: start) {
                print(step)
            }
            print()
        } else {
            assertionFailure("cannot find start")
        }
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
}
extension Point: CustomStringConvertible {
    var description: String {
        "(\(x),\(y))"
    }
}
extension Point {
    var w: Self {
        Point(x: x - 1, y: y)
    }
    var e: Self {
        Point(x: x + 1, y: y)
    }
    var n: Self {
        Point(x: x, y: y - 1)
    }
    var s: Self {
        Point(x: x, y: y + 1)
    }
    var nw: Self {
        Point(x: x - 1, y: y - 1)
    }
    var ne: Self {
        Point(x: x + 1, y: y - 1)
    }
    var sw: Self {
        Point(x: x - 1, y: y + 1)
    }
    var se: Self {
        Point(x: x + 1, y: y + 1)
    }
    var neighbours: Set<Self> {
        [w, e, n, s]
    }
    func isAdjacent(to other: Self) -> Bool {
        neighbours.contains(other)
    }
    var isOutOfMap: Bool {
        x < 0 || y < 0 || x > mapWidth || y > mapHeight
    }
    var isObstacle: Bool {
        labMap[self] == obstacle
    }
}
let input = """
<redacted>
"""
let rows = input
    .split(separator: "\n")
var obstacle: Character { "#" }
extension Set {
    func inserting(_ element: Element) -> Self {
        var new = self
        new.insert(element)
        return new
    }
}
let labMap = Dictionary(
    uniqueKeysWithValues:
        rows
        .enumerated()
        .flatMap({ offsetY, row -> [(Point, Character)] in
            row.enumerated().map { offsetX, char -> (Point, Character) in
                (Point(x: offsetX, y: offsetY), char)
            }
        })
)
let mapWidth = labMap.keys.map(\.x).max() ?? 0
let mapHeight = labMap.keys.map(\.y).max() ?? 0
struct Guard: IteratorProtocol {
    fileprivate var index = 0
    fileprivate var result = Set<Point>()
    enum Orientation: String, CaseIterable {
        case up = "^"
        case down = "v"
        case left = "<"
        case right = ">"
        
        init?(rawValue: Character) {
            self.init(rawValue: String(rawValue))
        }
        var description: String {
            rawValue
        }
        var char: Character? {
            rawValue.first
        }
        func nextTurn() -> Self {
            switch self {
            case .up: .right
            case .right: .down
            case .down: .left
            case .left: .up
            }
        }
    }
    var location: Point
    var orientation: Orientation
    
    func nextTentativeLocation() -> Point {
        switch orientation {
        case .up: location.n
        case .down: location.s
        case .left: location.w
        case .right: location.e
        }
    }
    
    mutating func next() -> Point? {
        let nextTentativeLocation = self.nextTentativeLocation()
        guard !nextTentativeLocation.isOutOfMap else {
            print(index)
            print(result.count)
            return nil // guard left the room
        }
        if nextTentativeLocation.isObstacle {
            orientation = orientation.nextTurn()
            return next()
        } else {
            location = nextTentativeLocation
            index += 1
            result.insert(nextTentativeLocation)
            return nextTentativeLocation
        }
    }
}
extension Guard: CustomStringConvertible {
    var description: String {
        "\(orientation)\(location)"
    }
}
struct GuardPath: Sequence {
    let guard_: Guard
    func makeIterator() -> Guard {
        guard_
    }
}
