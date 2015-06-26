//
//  NSDecimalNumber.swift
//  Arithmosophi
/*
The MIT License (MIT)

Copyright (c) 2015 Eric Marchand (phimage)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import Foundation

public func + (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

public func - (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberBySubtracting(right)
}

public func * (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return right.decimalNumberByMultiplyingBy(right)
}

public func / (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}

// MARK: crement

prefix public func ++ (inout operand: NSDecimalNumber) -> NSDecimalNumber {
    operand += NSDecimalNumber.one()
    return operand
}

postfix public func ++ (inout operand: NSDecimalNumber) -> NSDecimalNumber {
    var previousOperand = operand;
    ++operand
    return previousOperand
}

prefix public func -- (inout operand: NSDecimalNumber) -> NSDecimalNumber {
    operand -= NSDecimalNumber.one()
    return operand
}

postfix public func -- (inout operand: NSDecimalNumber) -> NSDecimalNumber {
    var previousOperand = operand;
    --operand
    return previousOperand
}

// MARK: assign inout

public func += (inout left: NSDecimalNumber, right: NSDecimalNumber) {
    left = left + right
}

public func -= (inout left: NSDecimalNumber, right: NSDecimalNumber) {
    left = left - right
}

public func *= (inout left: NSDecimalNumber, right: NSDecimalNumber) {
    left = left * right
}

public func /= (inout left: NSDecimalNumber, right: NSDecimalNumber) {
    left = left / right
}

//MARK: NSNumber

public func + (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    var decimalRight:NSDecimalNumber = NSDecimalNumber(double: right.doubleValue);
    return left.decimalNumberByAdding(decimalRight);
}

public func + (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    var decimalLeft:NSDecimalNumber = NSDecimalNumber(double: left.doubleValue);
    return decimalLeft.decimalNumberByAdding(right);
}

public func - (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    var decimalRight:NSDecimalNumber = NSDecimalNumber(double: right.doubleValue);
    return left.decimalNumberBySubtracting(decimalRight);
}

public func - (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    var decimalLeft:NSDecimalNumber = NSDecimalNumber(double: left.doubleValue);
    return decimalLeft.decimalNumberBySubtracting(right);
}

public func * (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    var decimalRight:NSDecimalNumber = NSDecimalNumber(double: right.doubleValue);
    return left.decimalNumberByMultiplyingBy(decimalRight);
}

public func * (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    var decimalLeft:NSDecimalNumber = NSDecimalNumber(double: left.doubleValue);
    return decimalLeft.decimalNumberByMultiplyingBy(right);
}

public func / (left: NSDecimalNumber, right: NSNumber) -> NSDecimalNumber {
    var decimalRight:NSDecimalNumber = NSDecimalNumber(double: right.doubleValue);
    return left.decimalNumberByDividingBy(decimalRight);
}

public func / (left: NSNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    var decimalLeft:NSDecimalNumber = NSDecimalNumber(double: left.doubleValue);
    return decimalLeft.decimalNumberByDividingBy(right);
}
