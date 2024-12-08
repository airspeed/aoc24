//
//  AoC7_2.swift
//  
//
//  Created by Francesco Puglisi on 07.12.24.
//

import Foundation

public func performPart2(
    lines: [Substring]
) -> Int {
    let termRegex = Regex(/(\d+): ((\d+ ?)+)/)
    let parsedLines =
    lines.compactMap { line -> (Int, [Int])? in
        let output = try? termRegex.wholeMatch(in: line)?.output
        guard let output else {
            return nil
        }
        assert(output.count > 2)
        guard let result: Int = output[1].substring.flatMap({ Int($0) }),
              let operands: Substring = output[2].substring else {
            return nil
        }
        let operandsList = operands.split(separator: " ")
        assert(operandsList.count > 1)
        return (result, operandsList.compactMap { Int($0) })
    }
    let solution =
    parsedLines.compactMap { line -> Int? in
        let (result, operands) = line
        let resultOperands: [[Int]] = operands.reduce([[Int]]()) { acc, operand in
            if acc.isEmpty {
                [[operand]]
            } else {
                acc
                .map { xs in
                    xs.filter { x in
                        x <= result
                    }
                }
                .filter { xs in
                    !xs.isEmpty
                }.map { xs in
                    xs.flatMap { x in
                        OperatorPart2.allCases.map { $0.perform(x, operand) }
                    }
                }
            }
        }
        let possibleSolutions =
        resultOperands.filter { xs in
            xs.contains(where: { $0 == result })
        }
        if possibleSolutions.isEmpty {
            return nil
        } else {
            return result
        }
    }
    let solution1 = solution.reduce(0, +)
    return solution1
}

enum OperatorPart2: CaseIterable {
    case add
    case multiply
    case gestellt
    
    var perform: (Int, Int) -> Int {
        switch self {
        case .add: return { $0 + $1 }
        case .multiply: return { $0 * $1 }
        case .gestellt: return { $0 * $1.nextMagnitude() + $1 }
        }
    }
}

extension Int {
    func nextMagnitude(order: Self = 1) -> Self {
        if self % order == self {
            order
        } else {
            nextMagnitude(order: order * 10)
        }
    }
}
