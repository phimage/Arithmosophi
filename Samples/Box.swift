//
//  Box.swift
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
import Arithmosophi

public final class Box<T> : RawRepresentable where T: Addable, T: Equatable {
    public typealias RawValue = T

    public var rawValue: T

    public required init?(rawValue: T) {
        self.rawValue = rawValue
    }

    public init(value: T) {
        self.rawValue = value
    }
}

public func +=<T> (box: inout Box<T>, addend: T) {
    box.rawValue += addend
}
public func -=<T> (box: inout Box<T>, addend: T) where T: Substractable {
    box.rawValue -= addend
}

// Equatable
extension Box: Equatable {}
public func == <T> (lhs: Box<T>, rhs: Box<T>) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

// Addable
extension Box: Addable {}
public func + <T> (lhs: Box<T>, rhs: Box<T>) -> Box<T> {
    return Box(value: lhs.rawValue + rhs.rawValue)
}
