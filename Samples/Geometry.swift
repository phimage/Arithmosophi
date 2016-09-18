//
//  Geometry.swift
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

// examples
import Arithmosophi

open class Geometry {

    // MARK: area, volume
    open class func area<T: Multiplicable>(x: T, y: T) -> T { return x * y }
    open class func volume<T: Multiplicable>(x: T, y: T, z: T) -> T { return x * y * z }

    // MARK: distance

    open class func distance<T: Arithmos>(x: T, y: T) -> T {
        return x.hypot(y)
    }
    open class func distance<T>(x1: T, y1: T, x2: T, y2: T) -> T where T: Substractable, T: Arithmos {
        return distance(x: x2 - x1, y: y2 - y1)
    }
    open class func distance<T>(x: T, y: T, z: T) -> T where T: Addable, T: Multiplicable, T: Substractable, T: Arithmos {
        return distanceSquared(x: x, y: y, z: z).sqrt()
    }

    open class func distance<T>(x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> T where T: Addable, T: Multiplicable, T: Substractable, T: Arithmos {
        return distance(x: x2 - x1, y: y2 - y1, z: z2 - z1).sqrt()
    }

    open class func distanceSquared<T>(x: T, y: T) -> T where T: Addable, T: Multiplicable {
        return x * x + y * y
    }
    open class func distanceSquared<T>(x1: T, y1: T, x2: T, y2: T) -> T where T: Addable, T: Multiplicable, T: Substractable {
        return distanceSquared(x: x2 - x1, y: y2 - y1)
    }
    open class func distanceSquared<T>(x: T, y: T, z: T) -> T where T: Addable, T: Multiplicable {
        return x * x + y * y + z * z
    }
    open class func distanceSquared<T>(x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> T where T: Addable, T: Multiplicable, T: Substractable {
        return distanceSquared(x: x2 - x1, y: y2 - y1, z: z2 - z1)
    }

    open class func normalize<T: Arithmos>(x: T, y: T) -> (x: T, y: T) where T: Dividable {
        let d = distance(x: x, y: y)
        return (x: x / d, y: y / d)
    }
    open class func normalize<T>(x: T, y: T, z: T) -> (x: T, y: T, z: T) where T: Addable, T: Multiplicable, T: Substractable, T: Dividable, T: Arithmos {
        let d = distance(x: x, y: y, z: z)
        return (x: x / d, y: y / d, z: z / d)
    }

    // MARK: point, cross
    open class func dot<T>(x1: T, y1: T, x2: T, y2: T) -> T where T: Addable, T: Multiplicable {
        return x1 * x2 + y1 * y2
    }
    open class func dot<T>(x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> T where T: Addable, T: Multiplicable {
        return x1 * x2 + y1 * y2 + z1 * z2
    }

    open class func cross<T>(x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> (x: T, y: T, z: T) where T: Substractable, T: Multiplicable {
        return (x:z2 * y1 - y2 * z1, y:x2 * z1 - z2 * x1, z:y2 * x1 - x2 * y1)
    }

    // MARK: scale
    open class func scale<T: Multiplicable>(dx: T, dy: T, s: T) -> (dx: T, dy: T) { return (dx: dx * s, dy: dy * s) }
    open class func scale<T: Multiplicable>(dx: T, dy: T, dz: T, s: T) -> (dx: T, dy: T, dz: T) { return (dx: dx * s, dy: dy * s, dz: dz * s) }
    open class func scale<T: Multiplicable>(dx: T, dy: T, sx: T, sy: T) -> (dx: T, dy: T) { return (dx: dx * sx, dy: dy * sy) }
    open class func scale<T: Multiplicable>(dx: T, dy: T, dz: T, sx: T, sy: T, sz: T) -> (dx: T, dy: T, dz: T) { return (dx: dx * sx, dy: dy * sy, dz: dz * sz) }

    open class func scaleForAspectFit<T>(dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> T where T:Dividable, T:Comparable {
        return Swift.min(dxArea / dxContent, dyArea / dyContent)
    }

    open class func scaleForAspectFill<T>(dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> T where T:Dividable, T:Comparable {
        return Swift.min(dxArea / dxContent, dyArea / dyContent)
    }

    open class func aspectFit<T>(dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> (dx: T, dy: T) where T:Dividable, T:Multiplicable, T:Comparable {
        let s = scaleForAspectFit(dxContent: dxContent, dyContent: dyContent, dxArea: dxArea, dyArea: dyArea)
        return scale(dx: dxContent, dy: dyContent, s: s)
    }

    open class func aspectFill<T>(dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> (dx: T, dy: T) where T:Dividable, T:Multiplicable, T:Comparable {
        let s = scaleForAspectFill(dxContent: dxContent, dyContent: dyContent, dxArea: dxArea, dyArea: dyArea)
        return scale(dx: dxContent, dy: dyContent, s: s)
    }

    // MARK: utility

    open class func normalize<T>(_ value: T, _ i1: T, _ i2: T) -> T where T: Substractable, T: Dividable {
        return (value - i1) / (i2 - i1)
    }
    open class func denormalize<T>(_ value: T, _ i1: T, _ i2: T) -> T where T: Substractable, T: Multiplicable, T: Addable {
        return value * (i2 - i1) + i1
    }
    open class func interpolate<T>(_ value: T, _ i1: T, _ i2: T) -> T where T: Substractable, T: Multiplicable, T: Addable {
        return value * (i2 - i1) + i1
    }
    open class func map<T>(_ value: T, _ a1: T, _ a2: T, _ b1: T, _ b2: T) -> T where T: Addable, T: Substractable, T: Multiplicable, T: Dividable {
        let v = ((b2 - b1) * (value - a1))
        return b1 + v / (a2 - a1)
    }

    open class func interpolate<T>(x1: T, y1: T, x2: T, y2: T, t: T) -> (x: T, y: T) where T: Substractable, T: Multiplicable, T: Addable {
        return (x: interpolate(t, x1, x2), y: interpolate(t, y1, y2))
    }

}
