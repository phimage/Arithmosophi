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

public protocol Arithmos {

    func abs() -> Self
    func floor () -> Self
    func ceil () -> Self
    func round () -> Self
    func fract() -> Self

    func sqrt() -> Self
    func pow(value: Self) -> Self

    func cos() -> Self
    func exp() -> Self
    func log() -> Self
    func sin() -> Self
    func hypot(value: Self) -> Self
    func atan2(value: Self) -> Self

    static func random(max: Self) -> Self
    static func random(min: Self, max: Self) -> Self

    func clamp (min: Self, _ max: Self) -> Self
    func clamp (range: Range<Int>) -> Self


    init(_ double: Double)
    
    var isFinite: Bool {get}
    var isInfinite: Bool {get}
}

extension Arithmos where Self: ArithmeticType {
    
    public var isSignMinus: Bool {
        return self != self.abs()
    }

    public var isZero: Bool {
        return self == Self()
    }

}

extension Double: Arithmos {

    #if os(Linux)
    public func abs() -> Double { return Glibc.fabs(self) }
    public func floor () -> Double { return Glibc.floor(self) }
    public func ceil () -> Double { return Glibc.ceil(self) }
    public func round () -> Double { return Glibc.round(self) }
    public func fract() -> Double { return self - self.floor() }
    
    public func sqrt() -> Double { return Glibc.sqrt(self) }
    public func pow(value: Double) -> Double { return Glibc.pow(self, value) }
    
    public func cos() -> Double { return Glibc.cos(self) }
    public func exp() -> Double { return Glibc.exp(self) }
    public func log() -> Double { return Glibc.log(self) }
    public func sin() -> Double { return Glibc.sin(self) }
    public func hypot(value: Double) -> Double { return Glibc.hypot(self, value) }
    public func atan2(value: Double) -> Double { return Glibc.atan2(self, value) }

    #else
    public func abs() -> Double { return Darwin.fabs(self) }
    public func floor () -> Double { return Darwin.floor(self) }
    public func ceil () -> Double { return Darwin.ceil(self) }
    public func round () -> Double { return Darwin.round(self) }
    public func fract() -> Double { return self - self.floor() }

    public func sqrt() -> Double { return Darwin.sqrt(self) }
    public func pow(value: Double) -> Double { return Darwin.pow(self, value) }

    public func cos() -> Double { return Darwin.cos(self) }
    public func exp() -> Double { return Darwin.exp(self) }
    public func log() -> Double { return Darwin.log(self) }
    public func sin() -> Double { return Darwin.sin(self) }
    public func hypot(value: Double) -> Double { return Darwin.hypot(self, value) }
    public func atan2(value: Double) -> Double { return Darwin.atan2(self, value) }
    #endif

    public static func random(max: Double) -> Double {
        return random(0, max: max)
    }
    public static func random(min: Double, max: Double) -> Double {
        let diff = max - min
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min
    }

    public func clamp (min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }

    public func clamp (range: Range<Int>) -> Double {
        return Swift.max(Double(range.startIndex), Swift.min(Double(range.endIndex), self))
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
    public func pow(value: Float) -> Float { return Glibc.pow(self, value) }
    
    public func cos() -> Float { return Glibc.cos(self) }
    public func exp() -> Float { return Glibc.exp(self) }
    public func log() -> Float { return Glibc.log(self) }
    public func sin() -> Float { return Glibc.sin(self) }
    public func hypot(value: Float) -> Float { return Glibc.hypot(self, value) }
    public func atan2(value: Float) -> Float { return Glibc.atan2(self, value) }
    
    #else

    public func abs() -> Float { return Darwin.fabs(self) }
    public func floor () -> Float { return Darwin.floor(self) }
    public func ceil () -> Float { return Darwin.ceil(self) }
    public func round () -> Float { return Darwin.round(self) }
    public func fract() -> Float { return self - self.floor() }

    public func sqrt() -> Float { return Darwin.sqrt(self) }
    public func pow(value: Float) -> Float { return Darwin.pow(self, value) }

    public func cos() -> Float { return Darwin.cos(self) }
    public func exp() -> Float { return Darwin.exp(self) }
    public func log() -> Float { return Darwin.log(self) }
    public func sin() -> Float { return Darwin.sin(self) }
    public func hypot(value: Float) -> Float { return Darwin.hypot(self, value) }
    public func atan2(value: Float) -> Float { return Darwin.atan2(self, value) }
    #endif

    public static func random(max: Float) -> Float {
        return random(0, max: max)
    }
    public static func random(min: Float, max: Float) -> Float {
        let diff = max - min
        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min
    }

    public func clamp (min: Float, _ max: Float) -> Float {
        return Swift.max(min, Swift.min(max, self))
    }

    public func clamp (range: Range<Int>) -> Float {
        return Swift.max(Float(range.startIndex), Swift.min(Float(range.endIndex), self))
    }
}

#if !os(Linux)
extension CGFloat: Arithmos {

    public func abs() -> CGFloat { return CoreGraphics.fabs(self) }
    public func floor () -> CGFloat { return CoreGraphics.floor(self) }
    public func ceil () -> CGFloat { return CoreGraphics.ceil(self) }
    public func round () -> CGFloat { return CoreGraphics.round(self) }
    public func fract() -> CGFloat { return self - self.floor() }

    public func sqrt() -> CGFloat { return CoreGraphics.sqrt(self) }
    public func pow(value: CGFloat) -> CGFloat { return CoreGraphics.pow(self, value) }

    public func cos() -> CGFloat { return CoreGraphics.cos(self) }
    public func exp() -> CGFloat { return CoreGraphics.exp(self) }
    public func log() -> CGFloat { return CoreGraphics.log(self) }
    public func sin() -> CGFloat { return CoreGraphics.sin(self) }
    public func hypot(value: CGFloat) -> CGFloat { return CoreGraphics.hypot(self, value) }
    public func atan2(value: CGFloat) -> CGFloat { return CoreGraphics.atan2(self, value) }

    public static func random(max: CGFloat) -> CGFloat {
        return random(0, max: max)
    }
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        let diff = max - min
        let rand = CGFloat(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / CGFloat(RAND_MAX)) * diff) + min
    }

    public func clamp (min: CGFloat, _ max: CGFloat) -> CGFloat {
        return Swift.max(min, Swift.min(max, self))
    }

    public func clamp (range: Range<Int>) -> CGFloat {
        return Swift.max(CGFloat(range.startIndex), Swift.min(CGFloat(range.endIndex), self))
    }
}
#endif
