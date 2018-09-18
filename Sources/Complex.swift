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
#if os(Linux)
    import Glibc
#else
    import Darwin
    import CoreGraphics
#if os(watchOS)
    import UIKit
#endif
#endif

public struct Complex<T: ArithmeticType> {

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

    // conjugate
    public var conjugate: Complex<T> {
        return Complex(real: real, imaginary: -imaginary)
    }

    // `self * i`
    public var i: Complex {
        return Complex(real: -imaginary, imaginary: real)
    }

    // norm
    public var norm: T {
        return real * real + imaginary * imaginary
    }

    // a tuble of real and imaginary value
    public var tuple: (T, T) {
        get {
            return (real, imaginary)
        }
        set(t) {
            (real, imaginary) = t
        }
    }

    public func combine(_ rhs: Complex, combineBehavior: (T, T) -> T) -> Complex<T> {
        let realPart = combineBehavior(self.real, rhs.real)
        let imaginaryPart = combineBehavior(self.imaginary, rhs.imaginary)
        return Complex(real: realPart, imaginary: imaginaryPart)
    }

    public var description: String {
        let zero = T()
        return self.imaginary < zero ? "\(self.real)-\(-self.imaginary)i" : "\(self.real)+\(self.imaginary)i"
    }

    public func map(_ function: (T, T) -> (T, T)) -> Complex<T> {
        let result = function(self.real, self.imaginary)
        return Complex(real: result.0, imaginary: result.1)
    }

    public func map(_ function: (T) -> T) -> Complex<T> {
        return Complex(real: function(self.real), imaginary: function(self.imaginary))
    }

}

extension ArithmeticType {
    var complex: Complex<Self> {
        return Complex(real: self, imaginary: Self())
    }
}

extension Complex where T: Arithmos {

    public func sqrt() -> Complex<T> {
        return map { value in
            return value.sqrt()
        }
    }
}

extension Complex where T: Arithmos {
    public var description: String {
        let sig = imaginary.isSignMinus ? "-" : "+"
        return "\(self.real) \(sig) \(self.imaginary)i"
    }

    public var abs: T {
        get {
            return real.hypot(imaginary)
        }
        set(r) {
            let f = r / abs
            // swiftlint:disable:next shorthand_operator
            real = real * f
            // swiftlint:disable:next shorthand_operator
            imaginary = imaginary * f
        }
    }

    public var argument: T {
        get {
            return imaginary.atan2(real)
        }
        set(t) {
            let m = abs
            real = m * t.cos()
            imaginary = m * t.sin()
        }
    }

    public var projection: Complex {
        if real.isFinite && imaginary.isFinite {
            return self
        } else {
            return Complex(
                real: T(1)/T(0), imaginary: imaginary.isSignMinus ? -T(0) : T(0)
            )
        }
    }
}

extension Arithmos /*where Self: Equatable*/ {

    public var isSignMinus: Bool {
        return self != self.abs()
    }

}

extension Complex: Additive, Initializable {}

public extension ArithmeticType {
    // self * 1.0i
    public var i: Complex<Self> {
        return Complex(real: Self()/*zero*/, imaginary: self)
    }
}

// MARK: Addable
extension Complex: Addable {}
public func + <T>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs + Complex(real: rhs, imaginary: T())
}
public func + <T>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) + rhs
}

public func + <T>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    return lhs.combine(rhs, combineBehavior: +)
}
// MARK: Substractable
extension Complex: Substractable {}
public func - <T>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs - Complex(real: rhs, imaginary: T())
}
public func - <T>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) - rhs
}
public func - <T>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    return lhs.combine(rhs, combineBehavior: -)
}

// MARK: Multiplicable
extension Complex: Multiplicable {}
public func * <T>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs * Complex(real: rhs, imaginary: T())
}
public func * <T>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) * rhs
}
public func * <T>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    let productOfReals = lhs.real * rhs.real
    let productOfImaginaries = rhs.imaginary * lhs.imaginary
    let realPart = productOfReals - productOfImaginaries
    let imaginaryPart = ((lhs.real + lhs.imaginary) * (rhs.real + rhs.imaginary)) - productOfReals - productOfImaginaries
    return Complex(real: realPart, imaginary: imaginaryPart)
}

// MARK: Dividable
extension Complex: Dividable {}
public func / <T>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs / Complex(real: rhs, imaginary: T())
}
public func / <T>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex(real: lhs, imaginary: T()) / rhs
}
public func / <T>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    let denominator = rhs.real * rhs.real + rhs.imaginary * rhs.imaginary
    let realPart = (lhs.real * rhs.real + lhs.imaginary * rhs.imaginary) / denominator
    let imaginaryPart = (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary) / denominator
    return Complex(real: realPart, imaginary: imaginaryPart)
}

// MARK: Negatable
extension Complex: Negatable {}
public prefix func - <T>(instance: Complex<T>) -> Complex<T> {
    return Complex(real: -instance.real, imaginary: -instance.imaginary)
}

// MARK: Modulable
extension Complex: Modulable {}
public func % <T>(lhs: Complex<T>, rhs: Complex<T>) -> Complex<T> {
    return lhs - (lhs / rhs) * rhs
}

public func % <T>(lhs: Complex<T>, rhs: T) -> Complex<T> {
    return lhs - (lhs / rhs) * rhs
}
public func % <T: Modulable>(lhs: T, rhs: Complex<T>) -> Complex<T> {
    return Complex<T>(real: lhs, imaginary: T()) % rhs
}
public func %= <T: Modulable>(lhs: inout Complex<T>, rhs: Complex<T>) {
    lhs = lhs % rhs
}
public func %= <T: Modulable>(lhs: inout Complex<T>, rhs: T) {
    lhs = lhs % rhs
}

// MARK: Equatable
extension Complex: Equatable {}
public func == <T>(lhs: Complex<T>, rhs: Complex<T>) -> Bool {
    return lhs.real == rhs.real && lhs.imaginary == rhs.imaginary
}

// MARK: Hashable
/*extension Complex: Hashable where T: Hashable {
    public var hashValue: Int {
        return self.real.hashValue + self.imaginary.hashValue
    }
}*/

// MARK: CGPoint
public protocol Complexable {
    associatedtype AssociatedType: ArithmeticType
    var complex: Complex<AssociatedType> {get}

    init(complex: Complex<AssociatedType>)
}
#if !os(Linux)

    public typealias ComplexCGFloat = Complex<CGFloat>
    extension CGPoint: Complexable {

        public var complex: ComplexCGFloat {
            return ComplexCGFloat(real: self.x, imaginary: self.y)
        }

        public init(complex: ComplexCGFloat) {
            self.init(x: complex.real, y: complex.imaginary)
        }
    }

#endif
