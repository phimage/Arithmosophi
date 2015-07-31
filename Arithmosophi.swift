//
//  Arithmosophi.swift
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

// MARK: Protocols

public protocol Addable {
    func + (lhs: Self, rhs: Self) -> Self
}
public protocol Substractable {
    func - (lhs: Self, rhs: Self) -> Self
}
public protocol Negatable {
    prefix func - (instance: Self) -> Self
}
public protocol Multiplicable {
    func * (lhs: Self, rhs: Self) -> Self
}
public protocol Dividable {
    func / (lhs: Self, rhs: Self) -> Self
}
public protocol Modulable {
    func % (lhs: Self, rhs: Self) -> Self
}
public protocol Incrementable {
    prefix func ++(inout x: Self) -> Self
    postfix func ++(inout x: Self) -> Self
}
public protocol Decrementable {
    prefix func --(inout x: Self) -> Self
    postfix func --(inout x: Self) -> Self
}

public protocol AddableWithOverflow {
    func &+ (lhs: Self, rhs: Self) -> Self
}
public protocol SubstractableWithOverflow {
    func &- (lhs: Self, rhs: Self) -> Self
}
public protocol MultiplicableWithOverflow {
    func &* (lhs: Self, rhs: Self) -> Self
}


public protocol Initializable {
    init() // get a zero
}

// MARK: combined protocols

public protocol Additive: Addable, Substractable, Incrementable, Decrementable {}
public protocol Multiplicative: Multiplicable, Dividable, Modulable {}

public protocol AdditiveWithOverflow: Additive, AddableWithOverflow, SubstractableWithOverflow {}
public protocol OverflowOperable: MultiplicableWithOverflow, AddableWithOverflow, SubstractableWithOverflow {}

public protocol UnsignedArithmeticType: Initializable, Additive, Multiplicative {}
public protocol ArithmeticType: UnsignedArithmeticType, Negatable {}

// MARK: Implement protocols

extension Int: ArithmeticType, OverflowOperable {}
extension Float: ArithmeticType {}
extension Double: ArithmeticType {}
extension CGFloat: ArithmeticType{}
extension UInt8: UnsignedArithmeticType, OverflowOperable {}
extension Int8: ArithmeticType, OverflowOperable {}
extension UInt16: UnsignedArithmeticType, OverflowOperable {}
extension Int16: ArithmeticType, OverflowOperable {}
extension UInt32: UnsignedArithmeticType, OverflowOperable {}
extension Int32: ArithmeticType, OverflowOperable {}
extension UInt64: UnsignedArithmeticType, OverflowOperable {}
extension Int64: ArithmeticType, OverflowOperable {}
extension UInt: UnsignedArithmeticType, OverflowOperable {}


extension String: Initializable, Addable {}
extension Array: Initializable, Addable {}
extension Bool: Initializable {}


// MARK: utility functions
public func sumOf<S: SequenceType where S.Generator.Element: Addable> (seq: S, initialValue: S.Generator.Element) -> S.Generator.Element {
    return seq.reduce (initialValue){ $0 + $1 }
}
public func sumOf<S: SequenceType where S.Generator.Element: protocol<Addable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    let initialValue: S.Generator.Element  = 0
    return sumOf(seq, initialValue: initialValue)
}
public func sumOf<S: SequenceType where S.Generator.Element: protocol<Addable, Initializable>> (seq: S) -> S.Generator.Element {
    let initialValue: S.Generator.Element  = S.Generator.Element()
    return sumOf(seq, initialValue: initialValue)
}
public func sumOf<T where T: protocol<Addable, Initializable>> (seq: T...) -> T {
    return sumOf(seq)
}

public func productOf<S: SequenceType where S.Generator.Element: protocol<Multiplicable, IntegerLiteralConvertible>> (seq: S) -> S.Generator.Element {
    let initialValue: S.Generator.Element  = 1
    return productOf(seq, initialValue: initialValue)
}
public func productOf<S: SequenceType where S.Generator.Element: protocol<Multiplicable, Initializable, Incrementable>> (seq: S) -> S.Generator.Element {
    var initialValue: S.Generator.Element  = S.Generator.Element()
    initialValue++
    return productOf(seq, initialValue: initialValue)
}

public func productOf<S: SequenceType where S.Generator.Element: Multiplicable> (seq: S, initialValue: S.Generator.Element) -> S.Generator.Element {
    return seq.reduce (initialValue){ $0 * $1 }
}

// MARK: closures (WIP)
internal func AddableBlock<T:Addable>() -> ((T, T) -> T) {
    return { left, right in
        left + right
    }
}
internal func SubstractableBlock<T:Substractable>() -> ((T, T) -> T) {
    return { left, right in
        left - right
    }
}



