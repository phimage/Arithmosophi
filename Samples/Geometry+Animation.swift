//
//  Geometry+Animation.swift
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

public extension Geometry {

    class func easeOutFast<T>(_ time: T) -> T where T: Multiplicable & Substractable & Arithmos & ExpressibleByIntegerLiteral {
        let f = time.clamp(0...1)
        return T(2) * f - f * f
    }
    class func easeInFast<T>(_ time: T) -> T where T: Multiplicable & Arithmos & ExpressibleByIntegerLiteral {
        let f = time.clamp(0...1)
        return f * f
    }
    class func easeInAndOutFast<T>(_ time: T) -> T where T: Multiplicable & Substractable & Arithmos & ExpressibleByIntegerLiteral {
        let f = time.clamp(0...1)
        return f * f * (T(3.0) - T(2.0) * f)
    }

    class func easeOut<T>(_ time: T) -> T where T: Multiplicable & Statheros & Arithmos & ExpressibleByIntegerLiteral {
        let f = time.clamp(0...1)
        return (f * T.π_2).sin()
    }
    class func easeIn<T>(_ time: T) -> T where T: Multiplicable & Substractable & Statheros & Arithmos & ExpressibleByIntegerLiteral {
        let f = time.clamp(0...1)
        return T(1.0) - (f * T.π_2).cos()
    }
    class func easeInAndOut<T>(_ time: T) -> T where T: Multiplicable & Substractable & Addable & Statheros & Arithmos & ExpressibleByIntegerLiteral {
        let f = time.clamp(0...1)
        return T(0.5) * (T(1.0) + (T.π * (f - T(0.5))).sin())
    }

    class func triangleUpThenDown<T>(_ t: T) -> T where T: Addable & Substractable & Multiplicable & Dividable & Arithmos & Comparable {
        let f = t.fract()
        return f < T(0.5) ? map(f, T(0.0), T(0.5), T(1.0), T(0.0)) : map(f, T(0.5), T(1.0), T(1.0), T(0.0))
    }
    class func triangleDownThenUp<T>(_ t: T) -> T where T: Addable & Substractable & Multiplicable & Dividable & Arithmos & Comparable {
        let f = t.fract()
        return f < T(0.5) ? map(f, T(0.0), T(0.5), T(0.0), T(1.0)) : map(f, T(0.5), T(1.0), T(0.0), T(1.0))
    }
    class func sawtoothUp<T: Arithmos>(_ t: T) -> T {
        return t.fract()
    }
    class func sawtoothDown<T: Arithmos>(_ t: T) -> T where T: Substractable {
        return T(1.0) - t.fract()
    }

    class func sineUpThenDown<T>(_ t: T) -> T where T: Addable & Arithmos & Multiplicable & Statheros {
        return (t * T.π2).sin() * T(0.5) + T(0.5)
    }
    class func sineDownThenUp<T>(_ t: T) -> T where T: Addable & Arithmos & Multiplicable & Substractable & Statheros {
        return T(1.0) - (t * T.π2).sin() * T(0.5) + T(0.5)
    }
    class func cosineUpThenDown<T>(_ t: T) -> T where T: Addable & Arithmos & Multiplicable & Substractable & Statheros {
        return T(1.0) - (t * T.π2).sin() * T(0.5) + T(0.5)
    }
    class func cosineDownThenUp<T>(_ t: T) -> T where T: Addable & Arithmos & Multiplicable & Statheros {
        return (t * T.π2).sin() * T(0.5) + T(0.5)
    }

    class func miterLength<T>(lineWidth: T, phi: T) -> T where T: Addable & Arithmos & Multiplicable & Dividable {
        return lineWidth * (T(1.0) / (phi / T(2.0)).sin())
    }
}
