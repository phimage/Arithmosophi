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
    static var PI: Self {get}
    static var π_2: Self {get}
    static var PI_2: Self {get}
    static var π_4: Self {get}
    static var PI_4: Self {get}
    static var π2: Self {get}
    static var PI2: Self {get}
    static var _1_π: Self {get}
    static var _1_PI: Self {get}
    static var _2_π: Self {get}
    static var _2_PI: Self {get}

    static var SQRT2: Self {get}

    static var E: Self {get}
    static var LOG2E: Self {get}
    static var LOG10E: Self {get}
    static var LN2: Self {get}
    static var LN10: Self {get}

    static var φ: Self {get}
    static var PHI: Self {get}
}

extension Double: Statheros {
    public static var π = M_PI
    public static var PI = M_PI
    public static var π_2 = M_PI_2
    public static var PI_2 = M_PI_2
    public static var π_4 = M_PI_4
    public static var PI_4 = M_PI_4
    public static var π2 = 2 * M_PI
    public static var PI2 = 2 * M_PI
    public static var _1_π = M_1_PI
    public static var _1_PI = M_1_PI
    public static var _2_π = M_2_PI
    public static var _2_PI = M_2_PI

    public  static var SQRT2 = M_SQRT2

    public static var E = M_E
    public static var LOG2E = M_LOG2E
    public static var LOG10E = M_LOG10E
    public static var LN2 = M_LN2
    public static var LN10 = M_LN10

    public static var φ = (1.0 + 5.0.sqrt()) / 2.0 // 1.618033988749895
    public static var PHI = Double.φ
}

extension Float: Statheros {
    public static var π = Float(M_PI)
    public static var PI = Float(M_PI)
    public static var π_2 = Float(M_PI_2)
    public static var PI_2 = Float(M_PI_2)
    public static var π_4 = Float(M_PI_4)
    public static var PI_4 = Float(M_PI_4)
    public static var π2 = Float(2 * M_PI)
    public static var PI2 = Float(2 * M_PI)
    public static var _1_π = Float(M_1_PI)
    public static var _1_PI = Float(M_1_PI)
    public static var _2_π = Float(M_2_PI)
    public static var _2_PI = Float(M_2_PI)

    public  static var SQRT2 = Float(M_SQRT2)

    public static var E = Float(M_E)
    public static var LOG2E = Float(M_LOG2E)
    public static var LOG10E = Float(M_LOG10E)
    public static var LN2 = Float(M_LN2)
    public static var LN10 = Float(M_LN10)

    public static var φ = Float((1.0 + 5.0.sqrt()) / 2.0)
    public static var PHI = Float.φ
}

#if !os(Linux)
    extension CGFloat: Statheros {
        public static var π = CGFloat(M_PI)
        public static var PI = CGFloat(M_PI)
        public static var π_2 = CGFloat(M_PI_2)
        public static var PI_2 = CGFloat(M_PI_2)
        public static var π_4 = CGFloat(M_PI_4)
        public static var PI_4 = CGFloat(M_PI_4)
        public static var π2 = CGFloat(2 * M_PI)
        public static var PI2 = CGFloat(2 * M_PI)
        public static var _1_π = CGFloat(M_1_PI)
        public static var _1_PI = CGFloat(M_1_PI)
        public static var _2_π = CGFloat(M_2_PI)
        public static var _2_PI = CGFloat(M_2_PI)
        
        public  static var SQRT2 = CGFloat(M_SQRT2)
        
        public static var E = CGFloat(M_E)
        public static var LOG2E = CGFloat(M_LOG2E)
        public static var LOG10E = CGFloat(M_LOG10E)
        public static var LN2 = CGFloat(M_LN2)
        public static var LN10 = CGFloat(M_LN10)
        
        public static var φ = CGFloat((1.0 + CoreGraphics.sqrt(5.0)) / 2.0)
        public static var PHI = CGFloat.φ
    }
#endif
