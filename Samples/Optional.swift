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


public enum Optional<T:Initializable> : LogicalOperationsType, Equatable, Initializable {
    case None
    case Some(T)
    
    public init(_ value: T?) {
        if let v = value {
            self = .Some(v)
        } else {
            self = .None
        }
    }
    
    init(_ value: T) {
        self = .Some(value)
    }
    
    public init() {
        self = .None
    }
    
    public func unwrap() -> T {
        switch self {
        case .Some(let value):
            return value
        case .None:
            fatalError("Unexpectedly found nil whie unwrapping an Optional value")
        }
    }
}

public func == <T: Equatable>(left: Optional<T>, right: Optional<T>) -> Bool {
    switch (left, right) {
    case (.None, .None): return true
    case (.None, .Some), (.Some,.None):  return false
    case (.Some(let x), .Some(let y)): return x == y
    }
}

public func == <T>(left: Optional<T>, right: Optional<T>) -> Bool {
    switch (left, right) {
    case (.None, .None): return true
    case (.None, .Some), (.Some,.None):  return false
    case (.Some, .Some): return true
    }
}

public func && <T>(left: Optional<T>, @autoclosure right:  () -> Optional<T>) -> Optional<T> {
    switch left {
    case .None: return .None
    case .Some:  return right()
    }
}
public func || <T>(left: Optional<T>, @autoclosure right:  () -> Optional<T>) -> Optional<T> {
    switch left {
    case .None: return right()
    case .Some:  return left
    }
}
public prefix func ! <T: Initializable>(value: Optional<T> ) -> Optional<T> {
    switch value {
    case .None: return .Some(T())
    case .Some:  return .None
    }
}

public func ||=<T>(inout lhs:T?, rhs:T) {
    if lhs == nil {
        lhs = rhs
    }
}