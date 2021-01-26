//
//  Arithmos.swift
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

public func fract(_ x: Double) -> Double {
    return x - x.floor()
}

public func fract(_ x: Float) -> Float {
    return x - x.floor()
}

public func fract(_ x: CGFloat) -> CGFloat {
    return x - x.floor()
}

/// Protocol to add some commons function to Double, CGFloat and Float
public protocol Arithmos: Comparable {

    func abs() -> Self
    func floor () -> Self
    func ceil () -> Self
    func round () -> Self
    func fract() -> Self

    func sqrt() -> Self
    func cbrt() -> Self
    func pow(_ value: Self) -> Self

    func exp() -> Self
    func exp2() -> Self
    func log() -> Self
    func log2() -> Self
    func log1p() -> Self
    func log10() -> Self
    func tgamma() -> Self
    func lgamma() -> Self

    func sin() -> Self
    func cos() -> Self
    func tan() -> Self
    func sinh() -> Self
    func cosh() -> Self
    func tanh() -> Self
    func asin() -> Self
    func acos() -> Self
    func atan() -> Self
    func atan2(_ value: Self) -> Self
    func hypot(_ value: Self) -> Self

    func reciprocal() -> Self
    func erf() -> Self
    func erfc() -> Self

    static func random(_ max: Self) -> Self
    static func random(_ min: Self, _ max: Self) -> Self
    static func random(_ range: ClosedRange<Self>) -> Self

    func clamp(_ max: Self) -> Self
    func clamp(_ min: Self, _ max: Self) -> Self
    func clamp(_ range: ClosedRange<Self>) -> Self

    init(_ double: Double)

    var isFinite: Bool {get}
    var isInfinite: Bool {get}
}

extension Double: Arithmos {

    #if os(Linux)
    public func abs() -> Double { return Glibc.fabs(self) }
    public func floor () -> Double { return Glibc.floor(self) }
    public func ceil () -> Double { return Glibc.ceil(self) }
    public func round () -> Double { return Glibc.round(self) }
    public func fract() -> Double { return self - self.floor() }

    public func sqrt() -> Double { return Glibc.sqrt(self) }
    public func cbrt() -> Double { return Glibc.cbrt(self) }
    public func pow(value: Double) -> Double { return Glibc.pow(self, value) }

    public func exp() -> Double { return Glibc.exp(self) }
    public func exp2() -> Double { return Glibc.exp2(self) }
    public func log() -> Double { return Glibc.log(self) }
    public func log2() -> Double { return Glibc.log2(self) }
    public func log10() -> Double { return Glibc.log10(self) }
    public func log1p() -> Double { return Glibc.log1p(self) }
    public func tgamma() -> Double { return Glibc.tgamma(self) }
    public func lgamma() -> Double { return Glibc.lgamma(self) }

    public func erf() -> Double { return Glibc.erf(self) }
    public func erfc() -> Double { return Glibc.erfc(self) }

    public func cos() -> Double { return Glibc.cos(self) }
    public func sin() -> Double { return Glibc.sin(self) }
    public func hypot(value: Double) -> Double { return Glibc.hypot(self, value) }
    public func atan2(value: Double) -> Double { return Glibc.atan2(self, value) }
    public func cosh() -> Double { return Glibc.cosh(self) }
    public func sinh() -> Double { return Glibc.sinh(self) }
    public func tanh() -> Double { return Glibc.tanh(self) }
    public func acos() -> Double { return Glibc.acos(self) }
    public func asin() -> Double { return Glibc.asin(self) }
    public func atan() -> Double { return Glibc.atan(self) }

    #else
    @_transparent public func abs() -> Double { return Darwin.fabs(self) }
    @_transparent public func floor () -> Double { return Darwin.floor(self) }
    @_transparent public func ceil () -> Double { return Darwin.ceil(self) }
    @_transparent public func round () -> Double { return Darwin.round(self) }
    @_transparent public func fract() -> Double { return self - self.floor() }

    @_transparent public func sqrt() -> Double { return Darwin.sqrt(self) }
    @_transparent public func cbrt() -> Double { return Darwin.cbrt(self) }
    @_transparent public func pow(_ value: Double) -> Double { return Darwin.pow(self, value) }

    @_transparent public func exp() -> Double { return Darwin.exp(self) }
    @_transparent public func exp2() -> Double { return Darwin.exp2(self) }
    @_transparent public func log() -> Double { return Darwin.log(self) }
    @_transparent public func log2() -> Double { return Darwin.log2(self) }
    @_transparent public func log10() -> Double { return Darwin.log10(self) }
    @_transparent public func log1p() -> Double { return Darwin.log1p(self) }
    @_transparent public func tgamma() -> Double { return Darwin.tgamma(self) }
    @_transparent public func lgamma() -> Double { return Darwin.lgamma(self) }

    @_transparent public func erf() -> Double { return Darwin.erf(self) }
    @_transparent public func erfc() -> Double { return Darwin.erfc(self) }

    @_transparent public func cos() -> Double { return Darwin.cos(self) }
    @_transparent public func sin() -> Double { return Darwin.sin(self) }
    @_transparent public func tan() -> Double { return Darwin.tan(self) }
    @_transparent public func hypot(_ value: Double) -> Double { return Darwin.hypot(self, value) }
    @_transparent public func atan2(_ value: Double) -> Double { return Darwin.atan2(self, value) }
    @_transparent public func cosh() -> Double { return Darwin.cosh(self) }
    @_transparent public func sinh() -> Double { return Darwin.sinh(self) }
    @_transparent public func tanh() -> Double { return Darwin.tanh(self) }
    @_transparent public func acos() -> Double { return Darwin.acos(self) }
    @_transparent public func asin() -> Double { return Darwin.asin(self) }
    @_transparent public func atan() -> Double { return Darwin.atan(self) }
    #endif

    @_transparent public func reciprocal() -> Double {
        return 1 / self
    }

    public static func random(_ max: Double) -> Double {
        return random(0, max)
    }
    public static func random(_ min: Double, _ max: Double) -> Double {
        let diff = max - min
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min
    }
    public static func random(_ range: ClosedRange<Double>) -> Double {
        return random(range.lowerBound, range.upperBound)
    }

    public func clamp(_ max: Double) -> Double {
        return clamp(0.0, max)
    }
    public func clamp(_ min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    public func clamp(_ range: ClosedRange<Double>) -> Double {
        return Swift.max(range.lowerBound, Swift.min(range.upperBound, self))
    }
}

extension Float: Arithmos {
    #if os(Linux)
    public func abs() -> Float { return Glibc.fabs(self) }
    public func floor () -> Float { return Glibc.floor(self) }
    public func ceil () -> Float { return Glibc.ceil(self) }
    public func round () -> Float { return Glibc.round(self) }
    public func fract() -> Float { return self - self.floor() }

    public func sqrt() -> Float { return Glibc.sqrt(self) }
    public func cbrt() -> Float { return Glibc.sqrt.cbrt(self) }
    public func pow(value: Float) -> Float { return Glibc.pow(self, value) }

    public func exp() -> Float { return Glibc.exp(self) }
    public func exp2() -> Float { return Glibc.exp2(self) }
    public func log() -> Float { return Glibc.log(self) }
    public func log2() -> Float { return Glibc.log2(self) }
    public func log10() -> Float { return Glibc.log10(self) }
    public func log1p() -> Float { return Glibc.log1p(self) }
    public func tgamma() -> Float { return Glibc.tgamma(self) }
    public func lgamma() -> Float { return Glibc.lgamma(self) }

    public func erf() -> Float { return Glibc.erf(self) }
    public func erfc() -> Float { return Glibc.erfc(self) }

    public func cos() -> Float { return Glibc.cos(self) }
    public func sin() -> Float { return Glibc.sin(self) }
    public func tan() -> Float { return Glibc.tan(self) }
    public func hypot(value: Float) -> Float { return Glibc.hypot(self, value) }
    public func atan2(value: Float) -> Float { return Glibc.atan2(self, value) }
    public func cosh() -> Float { return Glibc.cosh(self) }
    public func sinh() -> Float { return Glibc.sinh(self) }
    public func tanh() -> Float { return Glibc.tanh(self) }
    public func acos() -> Float { return Glibc.acos(self) }
    public func asin() -> Float { return Glibc.asin(self) }
    public func atan() -> Float { return Glibc.atan(self) }

    #else

    #if swift(>=4.2)
    @_transparent public func abs() -> Float { return Darwin.fabsf(self) }
    #else
    @_transparent public func abs() -> Float { return Darwin.fabs(self) }
    #endif
    @_transparent public func floor () -> Float { return Darwin.floor(self) }
    @_transparent public func ceil () -> Float { return Darwin.ceil(self) }
    @_transparent public func round () -> Float { return Darwin.round(self) }
    @_transparent public func fract() -> Float { return self - self.floor() }

    @_transparent public func sqrt() -> Float { return Darwin.sqrtf(self) }
    @_transparent public func cbrt() -> Float { return Darwin.cbrtf(self) }
    @_transparent public func pow(_ value: Float) -> Float { return Darwin.pow(self, value) }

    @_transparent public func exp() -> Float { return Darwin.expf(self) }
    @_transparent public func exp2() -> Float { return Darwin.exp2f(self) }
    @_transparent public func log() -> Float { return Darwin.logf(self) }
    @_transparent public func log2() -> Float { return Darwin.log2f(self) }
    @_transparent public func log10() -> Float { return Darwin.log10f(self) }
    @_transparent public func log1p() -> Float { return Darwin.log1pf(self) }
    @_transparent public func tgamma() -> Float { return Darwin.tgammaf(self) }
    @_transparent public func lgamma() -> Float { return Darwin.lgammaf(self) }

    @_transparent public func erf() -> Float { return Darwin.erf(self) }
    @_transparent public func erfc() -> Float { return Darwin.erfc(self) }

    @_transparent public func cos() -> Float { return Darwin.cosf(self) }
    @_transparent public func sin() -> Float { return Darwin.sinf(self) }
    @_transparent public func tan() -> Float { return Darwin.tanf(self) }
    @_transparent public func hypot(_ value: Float) -> Float { return Darwin.hypotf(self, value) }
    @_transparent public func atan2(_ value: Float) -> Float { return Darwin.atan2f(self, value) }
    @_transparent public func cosh() -> Float { return Darwin.coshf(self) }
    @_transparent public func sinh() -> Float { return Darwin.sinhf(self) }
    @_transparent public func tanh() -> Float { return Darwin.tanhf(self) }
    @_transparent public func acos() -> Float { return Darwin.acosf(self) }
    @_transparent public func asin() -> Float { return Darwin.asinf(self) }
    @_transparent public func atan() -> Float { return Darwin.atanf(self) }
    #endif

    public func reciprocal() -> Float {
        return 1 / self
    }

    public static func random(_ max: Float) -> Float {
        return random(0, max)
    }
    public static func random(_ min: Float, _ max: Float) -> Float {
        let diff = max - min
        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min
    }
    public static func random(_ range: ClosedRange<Float>) -> Float {
        return random(range.lowerBound, range.upperBound)
    }

    public func clamp(_ max: Float) -> Float {
        return clamp(Float(0.0), max)
    }
    public func clamp(_ min: Float, _ max: Float) -> Float {
        return Swift.max(min, Swift.min(max, self))
    }
    public func clamp(_ range: ClosedRange<Float>) -> Float {
        return Swift.max(range.lowerBound, Swift.min(range.upperBound, self))
    }
}

#if !os(Linux)
extension CGFloat: Arithmos {

    #if swift(>=4.2)
    @_transparent public func abs() -> CGFloat { return CGFloat(Darwin.fabs(Double(self))) }
    #else
    @_transparent public func abs() -> CGFloat { return CoreGraphics.fabs(self) }
    #endif
    @_transparent public func floor () -> CGFloat { return CoreGraphics.floor(self) }
    @_transparent public func ceil () -> CGFloat { return CoreGraphics.ceil(self) }
    @_transparent public func round () -> CGFloat { return CoreGraphics.round(self) }
    @_transparent public func fract() -> CGFloat { return self - self.floor() }

    @_transparent public func sqrt() -> CGFloat { return CoreGraphics.sqrt(self) }
   @_transparent public func cbrt() -> CGFloat { return CoreGraphics.cbrt(self) }
    @_transparent public func pow(_ value: CGFloat) -> CGFloat { return CoreGraphics.pow(self, value) }

    @_transparent public func exp() -> CGFloat { return CoreGraphics.exp(self) }
    @_transparent public func exp2() -> CGFloat { return CoreGraphics.exp2(self) }
    @_transparent public func log() -> CGFloat { return CoreGraphics.log(self) }
    @_transparent public func log2() -> CGFloat { return CoreGraphics.log2(self) }
    @_transparent public func log10() -> CGFloat { return CoreGraphics.log10(self) }
    @_transparent public func log1p() -> CGFloat { return CoreGraphics.log1p(self) }
    @_transparent public func tgamma() -> CGFloat { return CoreGraphics.tgamma(self) }
    @_transparent public func lgamma() -> CGFloat { return CGFloat(Darwin.lgammaf(Float(self))) }

    @_transparent public func erf() -> CGFloat { return CoreGraphics.erf(self) }
    @_transparent public func erfc() -> CGFloat { return CoreGraphics.erfc(self) }

    @_transparent public func cos() -> CGFloat { return CoreGraphics.cos(self) }
    @_transparent public func sin() -> CGFloat { return CoreGraphics.sin(self) }
    @_transparent public func tan() -> CGFloat { return CoreGraphics.tan(self) }
    @_transparent public func hypot(_ value: CGFloat) -> CGFloat { return CoreGraphics.hypot(self, value) }
    @_transparent public func atan2(_ value: CGFloat) -> CGFloat { return CoreGraphics.atan2(self, value) }
    @_transparent public func cosh() -> CGFloat { return CoreGraphics.cosh(self) }
    @_transparent public func sinh() -> CGFloat { return CoreGraphics.sinh(self) }
    @_transparent public func tanh() -> CGFloat { return CoreGraphics.tanh(self) }
    @_transparent public func acos() -> CGFloat { return CoreGraphics.acos(self) }
    @_transparent public func asin() -> CGFloat { return CoreGraphics.asin(self) }
    @_transparent public func atan() -> CGFloat { return CoreGraphics.atan(self) }

    public func reciprocal() -> CGFloat {
        return 1 / self
    }

    public static func random(_ max: CGFloat) -> CGFloat {
        return random(0, max)
    }
    public static func random(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
        let diff = max - min
        let rand = CGFloat(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / CGFloat(RAND_MAX)) * diff) + min
    }
    public static func random(_ range: ClosedRange<CGFloat>) -> CGFloat {
        return random(range.lowerBound, range.upperBound)
    }

    public func clamp(_ max: CGFloat) -> CGFloat {
        return clamp(CGFloat(0.0), max)
    }
    public func clamp(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
        return Swift.max(min, Swift.min(max, self))
    }
    public func clamp(_ range: ClosedRange<CGFloat>) -> CGFloat {
        return Swift.max(range.lowerBound, Swift.min(range.upperBound, self))
    }
}
#endif

public extension Sequence where Self.Iterator.Element: Arithmos {

    func abs() -> [Self.Iterator.Element] { return self.map {$0.abs()} }
    func floor() -> [Self.Iterator.Element] { return self.map {$0.floor()} }
    func ceil() -> [Self.Iterator.Element] { return self.map {$0.ceil()} }
    func round() -> [Self.Iterator.Element] { return self.map {$0.round()} }
    func fract() -> [Self.Iterator.Element] { return self.map {$0.fract()} }

    func sqrt() -> [Self.Iterator.Element] { return self.map {$0.sqrt()} }
    func pow(_ value: Self.Iterator.Element) -> [Self.Iterator.Element] { return self.map {$0.pow(value)} }

    func exp() -> [Self.Iterator.Element] { return self.map {$0.exp()} }
    func log() -> [Self.Iterator.Element] { return self.map {$0.log()} }

    func cos() -> [Self.Iterator.Element] { return self.map {$0.cos()} }
    func sin() -> [Self.Iterator.Element] { return self.map {$0.sin()} }
    func hypot(_ value: Self.Iterator.Element) -> [Self.Iterator.Element] { return self.map {$0.hypot(value)} }
    func atan2(_ value: Self.Iterator.Element) -> [Self.Iterator.Element] { return self.map {$0.atan2(value)} }

    func clamp(_ min: Self.Iterator.Element, _ max: Self.Iterator.Element) -> [Self.Iterator.Element] { return self.map {$0.clamp(min, max)} }
    func clamp(_ range: ClosedRange<Self.Iterator.Element>) -> [Self.Iterator.Element] { return self.map {$0.clamp(range)} }
}

// Operator
precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}
infix operator ** : ExponentiationPrecedence
infix operator **= : AssignmentPrecedence

extension Arithmos {
    /// pozwer operator
    @_transparent public static func ** (lhs: Self, rhs: Self) -> Self {
        return lhs.pow(rhs)
    }

    @_transparent public static func **= (lhs: inout Self, rhs: Self) {
        lhs = lhs ** rhs
    }
}
