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
            }?.key
        guard let start else {
            return assertionFailure("cannot find start")
        }
        let guardPath = GuardPath(
            location: start,
            labMap: labMap,
            obstacle: nil
        )
        for step in guardPath {
//                print(step)
        }
        print(initialPath.count)
        for point in initialPath.filter { point in
            point != start
            && labMap[point] != .obstacle
        } {
            var labMapCopy = labMap
            labMapCopy[point] = .obstacle
            let guardPath = GuardPath(
                location: start,
                labMap: labMapCopy,
                obstacle: point
            )
            for step in guardPath {
//                    print(step)
            }
        }
        print(obstacles.count)
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
}
let input = """
<redacted>
"""
let rows = input
    .split(separator: "\n")
extension Character {
    static var obstacle: Self { "#" }
}
extension Set {
    func inserting(_ element: Element) -> Self {
        var new = self
        new.insert(element)
        return new
    }
}
let labMap: [Point: Character] = Dictionary(
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
    fileprivate var path = Set<Point>()
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
    let labMap: [Point: Character]
    let obstacle: Point?
    var visited = [Point: [Orientation]]()
    var isLoop = false

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
            initialPath = path
            return nil // guard left the room
        }
        guard !isLoop else {
            return nil
        }
        if self.labMap[nextTentativeLocation] == .obstacle {
            orientation = orientation.nextTurn()
            return next()
        } else {
            location = nextTentativeLocation
            index += 1
            path.insert(nextTentativeLocation)
            if let currentVisited = visited[nextTentativeLocation] {
                var newVisited = currentVisited
                newVisited.append(orientation)
                visited[nextTentativeLocation] = newVisited
                if Set(newVisited).count < newVisited.count {
                    isLoop = true
                    if let obstacle {
                        obstacles.insert(obstacle)
                    }
                }
            } else {
                visited[nextTentativeLocation] = [orientation]
            }
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
    let location: Point
    let labMap: [Point: Character]
    let obstacle: Point?
    func makeIterator() -> Guard {
        Guard(
            location: location,
            orientation: .up,
            labMap: labMap,
            obstacle: obstacle
        )
    }
}
var initialPath = Set<Point>()
var obstacles = Set<Point>()
