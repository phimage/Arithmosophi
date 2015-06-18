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

// MARK: Arithmos

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

public protocol Initializable {
    init() // get a zero
}

extension Int: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension Float: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension Double: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension CGFloat: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension UInt8: Addable, Substractable, Multiplicable, Dividable, Modulable {}
extension Int8: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension UInt16: Addable, Substractable, Multiplicable, Dividable, Modulable {}
extension Int16: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension UInt32: Addable, Substractable, Multiplicable, Dividable, Modulable {}
extension Int32: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension UInt64: Addable, Substractable, Multiplicable, Dividable, Modulable {}
extension Int64: Initializable, Addable, Negatable, Substractable, Multiplicable, Dividable, Modulable {}
extension UInt: Addable, Substractable, Multiplicable, Dividable, Modulable{}


extension String: Initializable, Addable {}
extension Array: Initializable, Addable {}
extension Bool: Initializable {}

