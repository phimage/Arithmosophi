//
//  Optional.swift
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

public enum OptionalEnum<T: Initializable> : LogicalOperationsType, Equatable, Initializable {
    case none
    case some(T)

    public init(_ value: T?) {
        if let v = value {
            self = .some(v)
        } else {
            self = .none
        }
    }

    init(_ value: T) {
        self = .some(value)
    }

    public init() {
        self = .none
    }

    public func unwrap() -> T {
        switch self {
        case .some(let value):
            return value
        case .none:
            fatalError("Unexpectedly found nil whie unwrapping an Optional value")
        }
    }
}

public func == <T: Equatable>(left: OptionalEnum<T>, right: OptionalEnum<T>) -> Bool {
    switch (left, right) {
    case (.none, .none): return true
    case (.none, .some), (.some, .none):  return false
    case (.some(let x), .some(let y)): return x == y
    }
}

public func == <T>(left: OptionalEnum<T>, right: OptionalEnum<T>) -> Bool {
    switch (left, right) {
    case (.none, .none): return true
    case (.none, .some), (.some, .none):  return false
    case (.some, .some): return true
    }
}

public func && <T>(left: OptionalEnum<T>, right:  @autoclosure () throws -> OptionalEnum<T>) rethrows -> OptionalEnum<T> {
    switch left {
    case .none: return .none
    case .some:  return try right()
    }
}
public func || <T>(left: OptionalEnum<T>, right:  @autoclosure () throws -> OptionalEnum<T>) rethrows -> OptionalEnum<T> {
    switch left {
    case .none: return try right()
    case .some:  return left
    }
}
public prefix func ! <T>(value: OptionalEnum<T>) -> OptionalEnum<T> {
    switch value {
    case .none: return .some(T())
    case .some:  return .none
    }
}

public func ||= <T>(lhs: inout OptionalEnum<T>?, rhs: OptionalEnum<T>) {
    if lhs == nil {
        lhs = rhs
    }
}
