//
//  HNMathExpression.swift
//  HNMathExpression
//
//  Created by Hady Nourallah on 20/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class HNMathExpression {
    let expression: String
    
    init(_ expression: String) {
        self.expression = expression
    }
    
    func evaluate() -> (Float?, HNMathExpressionError?) {
        do {
            let x = try HNParser(self.expression).getValue()
            return (x, nil)
            
        } catch let error as HNMathExpressionError {
            print("Error")
            return(nil, error)
        } catch {
            print("unhandled Error")
            return(nil, HNMathExpressionError.unhandledError)
        }
    }
}

enum HNMathExpressionError: Error {
    case outOfRange
    case noClosingParenthesis
    case moreDecimalsThanItShould
    case unexpectedEnd
    case unexpectedCharacter
    case divisionByZero
    case unhandledError
}

fileprivate class HNParser {
    
    
        
    let expression: String
    var index: Int = 0
    
    func getValue() throws -> Float {
        let value = try self.parseExpression()
        self.skipWhiteSpaces()
        
        if self.hasNext() {
            throw HNMathExpressionError.unexpectedCharacter
        }
        
        return value
    }
    
    func peek() -> String {
        return self.hasNext() ? self.expression[self.index..<self.index+1] : ""
    }
    
    func hasNext() -> Bool {
        return self.index < self.expression.count
    }
    
    func isNext(_ val: String) -> Bool {
        return self.expression[self.index..<self.index+val.count] == val
    }
    
    func popIfNext(_ val: String) -> Bool {
        if self.isNext(val) {
            self.index += val.count
            return true
        }
        return false
    }
    
    func popExpected(_ val: String) throws {
        if self.popIfNext(val) == false {
            throw HNMathExpressionError.outOfRange
        }
    }
    
    func skipWhiteSpaces() {
        while hasNext() {
            if self.peek().contains(["\n", "\t", "\r", " "]) {
                self.index += 1
            } else {
                return
            }
        }
    }
    
    func parseExpression() throws -> Float {
        return try self.parseAdditions()
    }
    
    func parseAdditions() throws -> Float {
        var values: [Float] = [try self.parseMultiplications()]
        
        while true {
            self.skipWhiteSpaces()
            let c = self.peek()
            
            if c == "+" {
                self.index += 1
                values.append(try self.parseMultiplications())
            } else if c == "-" {
                self.index += 1
                values.append(-1 * (try self.parseMultiplications()))
            } else {
                break
            }
        }
        
        return values.reduce(0, +)
    }
    
    func parseMultiplications() throws -> Float {
        var values: [Float] = try [parseParenthesis()]
        
        while true {
            self.skipWhiteSpaces()
            let c = self.peek()
            
            if c == "*" {
                self.index += 1
                values.append(try self.parseParenthesis())
            } else if c == "/" {
                self.index += 1
                let dom = try self.parseParenthesis()
                if dom == 0 {
                    throw HNMathExpressionError.divisionByZero
                }
                values.append(1 / dom)
            } else {
                break
            }
        }
        
        return values.reduce(1, *)
    }
    
    func parseParenthesis() throws -> Float {
        self.skipWhiteSpaces()
        let c = self.peek()
        
        if c == "(" {
            self.index += 1
            let value = try self.parseExpression()
            
            self.skipWhiteSpaces()
            
            if self.peek() != ")" {
                throw HNMathExpressionError.noClosingParenthesis
            }
            
            self.index += 1
            return value
        } else {
            return try self.parseNegative()
        }
    }
    
    func parseNegative() throws -> Float {
        self.skipWhiteSpaces()
        let c = self.peek()
        
        if c == "-" {
            self.index += 1
            return try -1 * self.parseParenthesis()
        } else {
            return try self.parseNumbers()
        }
    }
    
    func parseNumbers() throws -> Float {
        self.skipWhiteSpaces()
        var strV: String = ""
        var isDecimal: Bool = false
        
        var c: String = ""
        while self.hasNext() {
            c = self.peek()
            if c == "." {
                if isDecimal {
                    throw HNMathExpressionError.moreDecimalsThanItShould
                }
                
                isDecimal = true
                strV.append(".")
            } else if c.isNumeric {
                strV.append(c)
            } else {
                break
            }
            
            self.index += 1
        }
        
        if strV.count == 0 {
            if c.isEmpty {
                throw HNMathExpressionError.unexpectedEnd
            }
        }
        
        return Float(strV)!
    }
    
    func parseArguments() throws {
        let args: [Int] = []
        self.skipWhiteSpaces()
        try self.popExpected("(")
        while self.popIfNext(")") == false {
            self.skipWhiteSpaces()
            if args.count > 0 {
                
            }
        }
    }
    
    init(_ expression: String) {
        self.expression = expression
        self.index = 0
    }
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    var characters: [String] {
        return self.map({String($0)})
    }
    
    var isNumeric: Bool {
        return self.contains(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
    }
    
    func contains(_ elements: [String]) -> Bool {
        guard self.count > 0 else { return false }
        
        let set: Set<String> = Set<String>(elements)
        return Set(self.characters).isSubset(of: set)
    }
}
