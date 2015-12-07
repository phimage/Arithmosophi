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
import Foundation
#if os(watchOS)
    import UIKit
#endif

public typealias AveragableDivideType = Int

public protocol Averagable: Addable {
    func / (lhs: Self, rhs: AveragableDivideType) -> Self
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
public func / <T where T:IntegerLiteralConvertible, T:Dividable>(lhs: T, rhs: T.IntegerLiteralType) -> T {
    let div: T = T(integerLiteral: rhs)
    return lhs / div
}

public func / <T where T:FloatLiteralConvertible, T:Dividable>(lhs: T, rhs: T.FloatLiteralType) -> T {
    let div: T = T(floatLiteral: rhs)
    return lhs / div
}
// MARK: utility functions

public func averageOf<T: protocol<Averagable, Initializable>> (seq: [T]) -> T {
    return sumOf(seq) / seq.count
}
public func averageOf<T: protocol<Averagable, Initializable>> (seq: T...) -> T {
    return averageOf(seq)
}


// MARK: CollectionType
public extension CollectionType where Self.Generator.Element: protocol<Averagable, Initializable> {

    public var average: Self.Generator.Element {
        let count = AveragableDivideType(self.count.toIntMax()) // Int64...
        if count == 0 {
            return Self.Generator.Element()
        }
        return self.sum / count
    }

}
