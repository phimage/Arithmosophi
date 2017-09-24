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

#if os(Linux)
    import Glibc
#else
    import Darwin
    import CoreGraphics
#if os(watchOS)
    import UIKit
#endif
#endif

// MARK: Protocols

public protocol Addable {
    static func + (lhs: Self, rhs: Self) -> Self
    static func += (lhs: inout Self, rhs: Self)
}
public func += <T: Addable>(lhs: inout T, rhs: T) {
    //swiftlint:disable:next shorthand_operator
    lhs = lhs + rhs
}
public protocol Substractable {
    static func - (lhs: Self, rhs: Self) -> Self
    static func -= (lhs: inout Self, rhs: Self)
}
public func -= <T: Substractable>(lhs: inout T, rhs: T) {
    //swiftlint:disable:next shorthand_operator
    lhs = lhs - rhs
}
public protocol Negatable {
    static prefix func - (instance: Self) -> Self
}
public protocol Multiplicable {
    static func * (lhs: Self, rhs: Self) -> Self
}
public protocol Dividable {
    static func / (lhs: Self, rhs: Self) -> Self
}
public protocol Modulable {
    static func % (lhs: Self, rhs: Self) -> Self
}
public protocol AddableWithOverflow {
    static func &+ (lhs: Self, rhs: Self) -> Self
}
public protocol SubstractableWithOverflow {
    static func &- (lhs: Self, rhs: Self) -> Self
}
public protocol MultiplicableWithOverflow {
    static func &* (lhs: Self, rhs: Self) -> Self
}
public protocol Shiftable {
    static func >> <RHS>(lhs: Self, rhs: RHS) -> Self where RHS : BinaryInteger
    static func << <RHS>(lhs: Self, rhs: RHS) -> Self where RHS : BinaryInteger
}
public protocol XorOperable {
    static func ^ (lhs: Self, rhs: Self) -> Self
}
public protocol AndOperable {
    static func & (lhs: Self, rhs: Self) -> Self
}
public protocol OrOperable {
    static func | (lhs: Self, rhs: Self) -> Self
}
public protocol InverseOperable {
    prefix static func ~ (x: Self) -> Self
}

public protocol Initializable {
    init() // get a zero
}

extension Initializable where Self: Equatable {
    public var isZero: Bool {
        return self == Self()
    }
}

public protocol LatticeType: Comparable {
    static var min: Self { get }
    static var max: Self { get }
}

// MARK: combined protocols

public protocol Additive: Addable, Substractable {}
public protocol Multiplicative: Multiplicable, Dividable/*, Modulable*/ {}
// public protocol IntegerArithmetic: Additive, Multiplicative{}

public protocol LogicalOperable: XorOperable, AndOperable, InverseOperable, OrOperable {}

public protocol AdditiveWithOverflow: Additive, AddableWithOverflow, SubstractableWithOverflow {}
public protocol OverflowOperable: MultiplicableWithOverflow, AddableWithOverflow, SubstractableWithOverflow, LogicalOperable, Shiftable {}

public protocol UnsignedArithmeticType: Initializable, Additive, Multiplicative, LatticeType {}
public protocol ArithmeticType: UnsignedArithmeticType, Negatable {}

// MARK: Implement protocols

extension Int: ArithmeticType, OverflowOperable {}
extension Float: ArithmeticType {}
extension Double: ArithmeticType {}
extension UInt8: UnsignedArithmeticType, OverflowOperable {}
extension Int8: ArithmeticType, OverflowOperable {}
extension UInt16: UnsignedArithmeticType, OverflowOperable {}
extension Int16: ArithmeticType, OverflowOperable {}
extension UInt32: UnsignedArithmeticType, OverflowOperable {}
extension Int32: ArithmeticType, OverflowOperable {}
extension UInt64: UnsignedArithmeticType, OverflowOperable {}
extension Int64: ArithmeticType, OverflowOperable {}
extension UInt: UnsignedArithmeticType, OverflowOperable {}
extension CGFloat: ArithmeticType {}

extension String: Initializable, Addable {}
extension Array: Initializable, Addable {}
extension Bool: Initializable {}

// Array addable
public func += <T> (left: inout [T], right: [T]) {
    // swiftlint:disable:next shorthand_operator
    left = left + right
}

// lattice impl
extension Bool : LatticeType {
    public static var min: Bool {
        return false
    }

    public static var max: Bool {
        return true
    }
}
public func < (left: Bool, right: Bool) -> Bool {
    if left == right {
        return false
    }
    return left
}

extension Float : LatticeType {
    public static var min: Float {
        return .leastNormalMagnitude
    }

    public static var max: Float {
        return .greatestFiniteMagnitude
    }
}

extension Double : LatticeType {
    public static var min: Double {
        return .leastNormalMagnitude
    }

    public static var max: Double {
        return .greatestFiniteMagnitude
    }
}

extension CGFloat : LatticeType {
    public static var min: CGFloat {
        return .leastNormalMagnitude
    }

    public static var max: CGFloat {
        return .greatestFiniteMagnitude
    }
}

// MARK: utility functions
public func sumOf<S: Sequence> (_ seq: S, initialValue: S.Iterator.Element) -> S.Iterator.Element where S.Iterator.Element: Addable {
    return seq.reduce(initialValue) { $0 + $1 }
}
private func sumOf<S: Sequence> (_ seq: S) -> S.Iterator.Element where S.Iterator.Element: Addable & ExpressibleByIntegerLiteral {
    let initialValue: S.Iterator.Element  = 0
    return sumOf(seq, initialValue: initialValue)
}
public func sumOf<S: Sequence> (_ seq: S) -> S.Iterator.Element where S.Iterator.Element: Addable & Initializable {
    let initialValue: S.Iterator.Element  = S.Iterator.Element()
    return sumOf(seq, initialValue: initialValue)
}
public func sumOf<T> (_ seq: T...) -> T where T: Addable & Initializable {
    return sumOf(seq)
}

private func productOf<S: Sequence> (_ seq: S) -> S.Iterator.Element where S.Iterator.Element: Multiplicable & ExpressibleByIntegerLiteral {
    let initialValue: S.Iterator.Element  = 1
    return productOf(seq, initialValue: initialValue)
}

public func productOf<S: Sequence> (_ seq: S, initialValue: S.Iterator.Element) -> S.Iterator.Element where S.Iterator.Element: Multiplicable {
    return seq.reduce (initialValue) { $0 * $1 }
}

extension UnsignedArithmeticType where Self: OverflowOperable, Self: ExpressibleByIntegerLiteral {
    public func gcd(with value: Self) -> Self {
        let zero = Self()
        if self == zero { return value }
        if value == zero { return self }

        let one: Self = 1
        var a = self
        var b = value
        var shift = 0
        while ((a | b) & one) == zero {
            a = a >> 1
            b = b >> 1
            // swiftlint:disable:next shorthand_operator
            shift = shift + 1
        }
        while (a & one) == zero {
            a = a >> 1
        }
        repeat {
            while (b & one) == zero {
                b = b >> 1
            }
            if a > b {
                swap(&a, &b)
            }
            // swiftlint:disable:next shorthand_operator
            b = b - a
        } while b != zero
        return a << shift
    }

    /// Last common multiple
    @_transparent public func lcm(with b: Self) -> Self {
        let zero = Self()
        let a = self
        if a == zero || b == zero { return zero }

        return a / a.gcd(with: b) * b
    }
}

// MARK: CollectionType
private extension Sequence where Self.Iterator.Element: Addable & ExpressibleByIntegerLiteral { // If public ambigous for ExpressibleByIntegerLiteral type

    private var sum: Self.Iterator.Element {
        let initialValue: Self.Iterator.Element  = 0
        return self.reduce(initialValue, +)
    }

}
extension Sequence where Self.Iterator.Element: Addable & Initializable {

    public var sum: Self.Iterator.Element {
        return self.reduce(Self.Iterator.Element(), +)
    }

}
public extension Sequence where Self.Iterator.Element: Multiplicable & ExpressibleByIntegerLiteral {

    public var product: Self.Iterator.Element {
        let initialValue: Self.Iterator.Element  = 1
        return self.reduce(initialValue, *)
    }

}

extension Sequence where Self.Iterator.Element: UnsignedArithmeticType & OverflowOperable & ExpressibleByIntegerLiteral {

    public var gcd: Self.Iterator.Element {
        return self.reduce(Self.Iterator.Element()) { (result, value) -> Self.Iterator.Element in
            return result.gcd(with: value)
        }
    }

}

extension Sequence where Self.Iterator.Element: Addable & Multiplicable & Initializable & Comparable {

    // https://en.wikipedia.org/wiki/Riemann_sum
    public func riemannSum(range: Range<Self.Iterator.Element>, interval: Self.Iterator.Element, function: (Self.Iterator.Element) -> Self.Iterator.Element) -> Self.Iterator.Element {
        var sum: Self.Iterator.Element = Self.Iterator.Element()
        var lower = range.lowerBound
        let upper = range.upperBound
        while lower <= upper {
            let value = function(lower)
            sum += value * interval
            lower += interval
        }
        return sum
    }

}
