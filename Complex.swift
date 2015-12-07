//
//  Complex.swift
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

public struct Complex<T:ArithmeticType> {
    public var real: T = T()
    public var imaginary: T

    public init() {
        let zero = T()
        self.init(real: zero, imaginary: zero)
    }
    public init(real: T, imaginary: T) {
        self.real = real
        self.imaginary = imaginary
    }

    public var conjugate: Complex<T> {
        let inversImaginary = -imaginary
        return Complex(real: real, imaginary: inversImaginary)
    }

    public func combine(rhs: Complex, combineBehavior: (T, T) -> T) -> Complex<T> {
        let realPart = combineBehavior(self.real, rhs.real)
        let imaginaryPart = combineBehavior(self.imaginary, rhs.imaginary)
        return Complex(real: realPart, imaginary: imaginaryPart)
    }
}

extension Complex: CustomStringConvertible {
    public var description: String {
        return "\(self.real) + \(self.imaginary)i"
    }
}

extension Complex: Additive, Initializable {}

// MARK Addable
extension Complex: Addable {}
public func +<T: ArithmeticType>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs + Complex(real: rhs, imaginary: T())
}
public func +<T: ArithmeticType>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) * rhs
}

public func +<T: ArithmeticType>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    return lhs.combine(rhs, combineBehavior: +)
}
// MARK Substractable
extension Complex: Substractable {}
public func -<T: ArithmeticType>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs - Complex(real: rhs, imaginary: T())
}
public func -<T: ArithmeticType>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) - rhs
}
public func -<T: ArithmeticType>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    return lhs.combine(rhs, combineBehavior: -)
}

// MARK Multiplicable
extension Complex: Multiplicable {}
public func *<T: ArithmeticType>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs * Complex(real: rhs, imaginary: T())
}
public func *<T: ArithmeticType>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) * rhs
}
public func *<T: ArithmeticType>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    let productOfReals = lhs.real * rhs.real
    let productOfImaginaries = rhs.imaginary * lhs.imaginary
    let realPart = productOfReals - productOfImaginaries
    let imaginaryPart = ((lhs.real + lhs.imaginary) * (rhs.real + rhs.imaginary)) - productOfReals - productOfImaginaries
    return Complex(real:realPart, imaginary:imaginaryPart)
}

// MARK Dividable
extension Complex: Dividable {}
public func /<T: ArithmeticType>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs / Complex(real: rhs, imaginary: T())
}
public func /<T: ArithmeticType>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) / rhs
}
public func /<T: ArithmeticType>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    let denominator = rhs.real * rhs.real + rhs.imaginary * rhs.imaginary
    let realPart = (lhs.real * rhs.real + lhs.imaginary * rhs.imaginary) / denominator
    let imaginaryPart = (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary) / denominator
    return Complex(real: realPart, imaginary: imaginaryPart)
}

// MARK Negatable
extension Complex: Negatable {}
public prefix func -<T: ArithmeticType>(instance: Complex<T>) -> Complex<T> {
    return Complex(real: -instance.real, imaginary: -instance.imaginary)
}

// MARK Incrementable
extension Complex: Incrementable {}
public prefix func ++ <T: ArithmeticType>(inout x: Complex<T>) -> Complex<T> {
    x.real++
    x.imaginary++
    return x
}
public postfix func ++ <T: ArithmeticType>(inout x: Complex<T>) -> Complex<T> {
    let real = x.real
    let imaginary = x.imaginary
    x.real++
    x.imaginary++
    return Complex<T>(real: real, imaginary: imaginary)
}

// MARK Decrementable
extension Complex: Decrementable {}
public prefix func -- <T: ArithmeticType>(inout x: Complex<T>) -> Complex<T> {
    x.real--
    x.imaginary--
    return x
}
public postfix func -- <T: ArithmeticType>(inout x: Complex<T>) -> Complex<T> {
    let real = x.real
    let imaginary = x.imaginary
    x.real--
    x.imaginary--
    return Complex(real: real, imaginary: imaginary)
}
