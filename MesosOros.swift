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

public protocol Averagable : Addable {
    func /(lhs: Self, rhs: Int) -> Self
}

// MARK: Implement protocols
extension Int: Addable, Averagable {}
extension Float: Addable, Averagable {}
public func / (lhs: Float, rhs: Int) -> Float { return lhs / Float(rhs) }
extension Double: Addable, Averagable {}
public func / (lhs: Double, rhs: Int) -> Double { return lhs / Double(rhs) }
extension CGFloat: Addable, Averagable{}
public func / (lhs: CGFloat, rhs: Int) -> CGFloat { return lhs / CGFloat(rhs) }
extension UInt8: Addable, Averagable {}
public func / (lhs: UInt8, rhs: Int) -> UInt8 { return lhs / UInt8(rhs) }
extension Int8: Addable, Averagable {}
public func / (lhs: Int8, rhs: Int) -> Int8 { return lhs / Int8(rhs) }
extension UInt16: Addable, Averagable {}
public func / (lhs: UInt16, rhs: Int) -> UInt16 { return lhs / UInt16(rhs) }
extension Int16: Addable, Averagable {}
public func / (lhs: Int16, rhs: Int) -> Int16 { return lhs / Int16(rhs) }
extension UInt32: Addable, Averagable {}
public func / (lhs: UInt32, rhs: Int) -> UInt32 { return lhs / UInt32(rhs) }
extension Int32: Addable, Averagable {}
public func / (lhs: Int32, rhs: Int) -> Int32 { return lhs / Int32(rhs) }
extension UInt64: Addable, Averagable {}
public func / (lhs: UInt64, rhs: Int) -> UInt64 { return lhs / UInt64(rhs) }
extension Int64: Addable, Averagable {}
public func / (lhs: Int64, rhs: Int) -> Int64 { return lhs / Int64(rhs) }
extension UInt: Addable, Averagable {}
public func / (lhs: UInt, rhs: Int) -> UInt { return lhs / UInt(rhs) }


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

public func averageOf<T: protocol<Addable, Averagable, Initializable>> (seq: [T]) -> T {
    return sumOf(seq) / seq.count
}
public func averageOf<T: protocol<Addable, Averagable, Initializable>> (seq: T...) -> T {
    return averageOf(seq)
}