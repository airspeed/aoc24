// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

let now = Date()

let input = """
<redacted>
"""
let lines = input.split(separator: "\n")
if #available(macOS 15.2, *) {
    let buttonARegex = Regex(/Button A: X\+(\d{1,3}), Y\+(\d{1,3})/)
    let buttonBRegex = Regex(/Button B: X\+(\d{1,3}), Y\+(\d{1,3})/)
    let prizeRegex = Regex(/Prize: X=(\d{1, 9}), Y=(\d{1, 9})/)
    let parsedLines = lines.reduce(([Point](), [Point](), [Point]())) { acc, next in
        if let output = try? buttonARegex.wholeMatch(in: next)?.output,
            let ax = output[1].substring,
            let ay = output[2].substring,
            let ix = Int(ax),
            let iy = Int(ay) {
            return (acc.0 + [Point(x: ix, y: iy)], acc.1, acc.2)
        } else if let output = try? buttonBRegex.wholeMatch(in: next)?.output,
            let bx = output[1].substring,
            let by = output[2].substring,
            let ix = Int(bx),
            let iy = Int(by) {
            return (acc.0, acc.1 + [Point(x: ix, y: iy)], acc.2)
        } else if let output = try? prizeRegex.wholeMatch(in: next)?.output,
            let px = output[1].substring,
            let py = output[2].substring,
            let ix = Int(px),
            let iy = Int(py) {
            return (acc.0, acc.1, acc.2 + [Point(x: ix, y: iy)])
        } else {
            assertionFailure()
            return acc
        }
    }
    let aButtons = parsedLines.0
    let bButtons = parsedLines.1
    let prizes = parsedLines.2
    assert(aButtons.count == bButtons.count)
    assert(bButtons.count == prizes.count)
    let buttons = zip(aButtons, bButtons)
    let clawMachines = zip(buttons, prizes).map { buttons, prize in
        let (a, b) = buttons
        return ClawMachine(a: a, b: b, x: prize)
    }
    assert(clawMachines.count == prizes.count)
    // print(clawMachines)
    let solutions =
    clawMachines.map { $0.solve() }
    let prices = solutions.compactMap { sx in
        sx.map { a, b in
            a * 3 + b
       }
       .min()
    }
    print(prices.reduce(0, +))
}

struct Point: Hashable {
    let x: Int
    let y: Int
}
extension Point: CustomStringConvertible {
    var description: String {
        "(\(x), \(y))"
    }
}
struct ClawMachine: Hashable {
    let a: Point
    let b: Point
    let x: Point
}
extension ClawMachine: CustomStringConvertible {
    var description: String {
        "\(a)+\(b): \(x)"
    }
}
extension ClawMachine {
    func solve() -> [(Int, Int)] {
        (0..<100).reduce([(-1, -1)]) { acc, m -> [(Int, Int)] in
            acc + (0..<100).compactMap { n -> (Int, Int)? in
                let solvesX = x.x == m * a.x + n * b.x
                let solvesY = x.y == m * a.y + n * b.y
                if solvesX && solvesY {
                    return (m, n)
                } else {
                    return nil
                }
            }
        }
        .filter { $0.0 != -1 && $0.1 != -1 }
    }
}

print(Date().timeIntervalSince(now))