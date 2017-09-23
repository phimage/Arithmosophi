//
//  MesosOros.swift
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

public typealias AveragableDivideType = Int

public protocol Averagable: Addable {
    static func / (lhs: Self, rhs: AveragableDivideType) -> Self
}

// MARK: Implement protocols
extension Int: Averagable {}
extension Float: Averagable {}
public func / (lhs: Float, rhs: AveragableDivideType) -> Float { return lhs / Float(rhs) }
extension Double: Averagable {}
public func / (lhs: Double, rhs: AveragableDivideType) -> Double { return lhs / Double(rhs) }
extension CGFloat: Averagable {}
public func / (lhs: CGFloat, rhs: AveragableDivideType) -> CGFloat { return lhs / CGFloat(rhs) }
extension UInt8: Averagable {}
public func / (lhs: UInt8, rhs: AveragableDivideType) -> UInt8 { return lhs / UInt8(rhs) }
extension Int8: Averagable {}
public func / (lhs: Int8, rhs: AveragableDivideType) -> Int8 { return lhs / Int8(rhs) }
extension UInt16: Averagable {}
public func / (lhs: UInt16, rhs: AveragableDivideType) -> UInt16 { return lhs / UInt16(rhs) }
extension Int16: Averagable {}
public func / (lhs: Int16, rhs: AveragableDivideType) -> Int16 { return lhs / Int16(rhs) }
extension UInt32: Averagable {}
public func / (lhs: UInt32, rhs: AveragableDivideType) -> UInt32 { return lhs / UInt32(rhs) }
extension Int32: Averagable {}
public func / (lhs: Int32, rhs: AveragableDivideType) -> Int32 { return lhs / Int32(rhs) }
extension UInt64: Averagable {}
public func / (lhs: UInt64, rhs: AveragableDivideType) -> UInt64 { return lhs / UInt64(rhs) }
extension Int64: Averagable {}
public func / (lhs: Int64, rhs: AveragableDivideType) -> Int64 { return lhs / Int64(rhs) }
extension UInt: Averagable {}
public func / (lhs: UInt, rhs: AveragableDivideType) -> UInt { return lhs / UInt(rhs) }

// generic operators on dividable & literal
public func / <T>(lhs: T, rhs: T.IntegerLiteralType) -> T where T:ExpressibleByIntegerLiteral, T:Dividable {
    let div: T = T(integerLiteral: rhs)
    return lhs / div
}

public func / <T>(lhs: T, rhs: T.FloatLiteralType) -> T where T:ExpressibleByFloatLiteral, T:Dividable {
    let div: T = T(floatLiteral: rhs)
    return lhs / div
}
// MARK: utility functions

public func averageOf<T: Averagable & Initializable> (_ seq: [T]) -> T {
    return sumOf(seq) / seq.count
}
public func averageOf<T: Averagable & Initializable> (_ seq: T...) -> T {
    return averageOf(seq)
}

// MARK: average/mean
public extension Collection where Self.Iterator.Element: Averagable & Initializable {

    // The arithmetic mean
    public var average: Self.Iterator.Element {
        if self.count == 0 {
            return Self.Iterator.Element()
        }
        let count = AveragableDivideType(Int64(self.count)) // XXX check swift 4 conversion
        return self.sum / count
    }

    public var arithmeticMean: Self.Iterator.Element {
        return average
    }

}

public extension Collection where Self.Iterator.Element: Addable & Dividable & Comparable & ExpressibleByIntegerLiteral {

    public var harmonicMean: Self.Iterator.Element? {
        if self.count == 0 {
            return 0
        }

        let zero: Self.Iterator.Element  = 0
        var result = zero
        var n = zero
        for value in self {
            if value == zero {
                return nil // forbidden
            }
            let i = 1 / value
            result += i
            n += 1
        }
        return n / result
    }

}

// MARK: median
public extension Collection where Self.Iterator.Element: Averagable & Comparable & Initializable {

    public var median: Self.Iterator.Element? {
        if self.count == 0 {
            return nil
        }
        let sorted = self.sorted { (l, r) -> Bool in
            return l < r
        }

        if self.count % 2 == 0 {
            let leftIndex = Int(count / 2 - 1)
            let leftValue = sorted[leftIndex]
            let rightValue = sorted[leftIndex + 1]
            return (leftValue + rightValue) / 2
        } else {
            return sorted[Int(count / 2)]
        }
    }

    public var medianLow: Self.Iterator.Element? {
        if self.count == 0 {
            return nil
        }
        let sorted = self.sorted { (l, r) -> Bool in
            return l < r
        }

        if self.count % 2 == 0 {
            return sorted[Int(self.count / 2) - 1]
        } else {
            return sorted[Int(self.count / 2)]
        }
    }

    public var medianHigh: Self.Iterator.Element? {
        if self.count == 0 {
            return nil
        }
        let sorted = self.sorted { (l, r) -> Bool in
            return l < r
        }
        return sorted[Int(self.count / 2)]
    }
}
