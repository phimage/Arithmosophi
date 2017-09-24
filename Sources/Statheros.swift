//
//  Statheros.swift
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

public protocol Statheros {
    static var π: Self {get}
    static var pi: Self {get}
    static var π_2: Self {get}
    static var pi_2: Self {get}
    static var π_4: Self {get}
    static var pi_4: Self {get}
    static var π2: Self {get}
    static var pi2: Self {get}
    static var _1_π: Self {get}
    static var _1_pi: Self {get}
    static var _2_π: Self {get}
    static var _2_pi: Self {get}

    static var SQRT2: Self {get}

    static var e: Self {get}
    static var LOG2E: Self {get}
    static var LOG10E: Self {get}
    static var LN2: Self {get}
    static var LN10: Self {get}

    static var φ: Self {get}
    static var phi: Self {get}
}

extension Double: Statheros {
    public static var π = Double.pi
    public static var π_2 = Double.pi / 2
    public static var pi_2 = Double.pi / 2
    public static var π_4 = Double.pi / 4
    public static var pi_4 = Double.pi / 4
    public static var π2 = 2 * Double.pi
    public static var pi2 = 2 * Double.pi
    public static var _1_π = M_1_PI
    public static var _1_pi = M_1_PI
    public static var _2_π = M_2_PI
    public static var _2_pi = M_2_PI

    public  static var SQRT2: Double = 2.squareRoot()

    public static var e = M_E
    public static var LOG2E = M_LOG2E
    public static var LOG10E = M_LOG10E
    public static var LN2 = M_LN2
    public static var LN10 = M_LN10

    public static var φ = (1.0 + Darwin.sqrt(5.0)) / 2.0 // 1.618033988749895
    public static var phi = Double.φ
}

extension Float: Statheros {
    public static var π = Float.pi
    public static var π_2 = Float(Double.pi / 2)
    public static var pi_2 = Float(Double.pi / 2)
    public static var π_4 = Float(Double.pi / 4)
    public static var pi_4 = Float(Double.pi / 4)
    public static var π2 = Float(2 * Double.pi)
    public static var pi2 = Float(2 * Double.pi)
    public static var _1_π = Float(M_1_PI)
    public static var _1_pi = Float(M_1_PI)
    public static var _2_π = Float(M_2_PI)
    public static var _2_pi = Float(M_2_PI)

    public  static var SQRT2 = Float(2.squareRoot())

    public static var e = Float(M_E)
    public static var LOG2E = Float(M_LOG2E)
    public static var LOG10E = Float(M_LOG10E)
    public static var LN2 = Float(M_LN2)
    public static var LN10 = Float(M_LN10)

    public static var φ = Float((1.0 + Darwin.sqrt(5.0)) / 2.0)
    public static var phi = Float.φ
}

#if !os(Linux)
    extension CGFloat: Statheros {
        public static var π = CGFloat.pi
        public static var π_2 = CGFloat(Double.pi / 2)
        public static var pi_2 = CGFloat(Double.pi / 2)
        public static var π_4 = CGFloat(Double.pi / 4)
        public static var pi_4 = CGFloat(Double.pi / 4)
        public static var π2 = CGFloat(2 * Double.pi)
        public static var pi2 = CGFloat(2 * Double.pi)
        public static var _1_π = CGFloat(M_1_PI)
        public static var _1_pi = CGFloat(M_1_PI)
        public static var _2_π = CGFloat(M_2_PI)
        public static var _2_pi = CGFloat(M_2_PI)

        public  static var SQRT2 = CGFloat(2.squareRoot())

        public static var e = CGFloat(M_E)
        public static var LOG2E = CGFloat(M_LOG2E)
        public static var LOG10E = CGFloat(M_LOG10E)
        public static var LN2 = CGFloat(M_LN2)
        public static var LN10 = CGFloat(M_LN10)

        public static var φ = CGFloat((1.0 + CoreGraphics.sqrt(5.0)) / 2.0)
        public static var phi = CGFloat.φ
    }
#endif
