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
            return (acc.0, acc.1, acc.2 + [Point(x: ix + 10000000000000, y: iy + 10000000000000)])
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
        let d1 = (b.y * x.x - b.x * x.y)
        let d2 = (b.y * a.x - a.y * b.x)
        if d1 % d2 == 0 {
            let m = d1 / d2
            let d3 = x.y - m * a.y
            let d4 = b.y
            if d3 % d4 == 0 {
                let n = d3 / d4
                return [(m, n)]
            } else {
                return []
            }
        } else {
            return []
        }
    }
}

print(Date().timeIntervalSince(now))