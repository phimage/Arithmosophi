//
//  Parity.swift
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

public enum Parity: IntegerLiteralType, Equatable, Addable, Substractable, Multiplicable {
    case even, odd

    public init(integerLiteral value: IntegerLiteralType) {
        self = value % 2 == 0 ? .even : .odd
    }

}

// MARK: Equatable
public func == (left: Parity, right: Parity) -> Bool {
    switch (left, right) {
    case (.even, .even), (.odd, .odd): return true
    case (.even, .odd), (.odd, .even):  return false
    }
}

// MARK: Addable
public func + (left: Parity, right: Parity) -> Parity {
    return left == right ? .even : .odd
}

// MARK: Substractable
public func - (left: Parity, right: Parity) -> Parity {
    return left + right
}

// MARK: Multiplicable
public func * (left: Parity, right: Parity) -> Parity {
    return left == .odd && right == .odd ? .odd : .even
}
