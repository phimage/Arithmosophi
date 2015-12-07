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

public class Geometry {

    // MARK: area, volume
    public class func area<T: Multiplicable>(x x: T, y: T) -> T { return x * y }
    public class func volume<T: Multiplicable>(x x: T, y: T, z: T) -> T { return x * y * z }

    // MARK: distance

    public class func distance<T: Arithmos>(x x: T, y: T) -> T {
        return x.hypot(y)
    }
    public class func distance<T where T: Substractable, T: Arithmos>(x1 x1: T, y1: T, x2: T, y2: T) -> T {
        return distance(x: x2 - x1, y: y2 - y1)
    }
    public class func distance<T where T: Addable, T: Multiplicable, T: Substractable, T: Arithmos>(x x: T, y: T, z: T) -> T {
        return distanceSquared(x: x, y: y, z: z).sqrt()
    }

    public class func distance<T where T: Addable, T: Multiplicable, T: Substractable, T: Arithmos>(x1 x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> T {
        return distance(x: x2 - x1, y: y2 - y1, z: z2 - z1).sqrt()
    }

    public class func distanceSquared<T where T: Addable, T: Multiplicable>(x x: T, y: T) -> T {
        return x * x + y * y
    }
    public class func distanceSquared<T where T: Addable, T: Multiplicable, T: Substractable>(x1 x1: T, y1: T, x2: T, y2: T) -> T {
        return distanceSquared(x: x2 - x1, y: y2 - y1)
    }
    public class func distanceSquared<T where T: Addable, T: Multiplicable>(x x: T, y: T, z: T) -> T {
        return x * x + y * y + z * z
    }
    public class func distanceSquared<T where T: Addable, T: Multiplicable, T: Substractable>(x1 x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> T {
        return distanceSquared(x: x2 - x1, y: y2 - y1, z: z2 - z1)
    }

    public class func normalize<T: Arithmos where T: Dividable>(x x: T, y: T) -> (x: T, y: T) {
        let d = distance(x: x, y: y)
        return (x: x / d, y: y / d)
    }
    public class func normalize<T where T: Addable, T: Multiplicable, T: Substractable, T: Dividable, T: Arithmos>(x x: T, y: T, z: T) -> (x: T, y: T, z: T) {
        let d = distance(x: x, y: y, z: z)
        return (x: x / d, y: y / d, z: z / d)
    }

    // MARK: point, cross
    public class func dot<T where T: Addable, T: Multiplicable>(x1 x1: T, y1: T, x2: T, y2: T) -> T {
        return x1 * x2 + y1 * y2
    }
    public class func dot<T where T: Addable, T: Multiplicable>(x1 x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> T {
        return x1 * x2 + y1 * y2 + z1 * z2
    }

    public class func cross<T where T: Substractable, T: Multiplicable>(x1 x1: T, y1: T, z1: T, x2: T, y2: T, z2: T) -> (x: T, y: T, z: T) {
        return (x:z2 * y1 - y2 * z1, y:x2 * z1 - z2 * x1, z:y2 * x1 - x2 * y1)
    }

    // MARK: scale
    public class func scale<T: Multiplicable>(dx dx: T, dy: T, s: T) -> (dx: T, dy: T) { return (dx: dx * s, dy: dy * s) }
    public class func scale<T: Multiplicable>(dx dx: T, dy: T, dz: T, s: T) -> (dx: T, dy: T, dz: T) { return (dx: dx * s, dy: dy * s, dz: dz * s) }
    public class func scale<T: Multiplicable>(dx dx: T, dy: T, sx: T, sy: T) -> (dx: T, dy: T) { return (dx: dx * sx, dy: dy * sy) }
    public class func scale<T: Multiplicable>(dx dx: T, dy: T, dz: T, sx: T, sy: T, sz: T) -> (dx: T, dy: T, dz: T) { return (dx: dx * sx, dy: dy * sy, dz: dz * sz) }

    public class func scaleForAspectFit<T where T:Dividable, T:Comparable>(dxContent dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> T {
        return Swift.min(dxArea / dxContent, dyArea / dyContent)
    }

    public class func scaleForAspectFill<T where T:Dividable, T:Comparable>(dxContent dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> T {
        return Swift.min(dxArea / dxContent, dyArea / dyContent)
    }

    public class func aspectFit<T where T:Dividable, T:Multiplicable, T:Comparable>(dxContent dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> (dx: T, dy: T) {
        let s = scaleForAspectFit(dxContent: dxContent, dyContent: dyContent, dxArea: dxArea, dyArea: dyArea)
        return scale(dx: dxContent, dy: dyContent, s: s)
    }

    public class func aspectFill<T where T:Dividable, T:Multiplicable, T:Comparable>(dxContent dxContent: T, dyContent: T, dxArea: T, dyArea: T) -> (dx: T, dy: T) {
        let s = scaleForAspectFill(dxContent: dxContent, dyContent: dyContent, dxArea: dxArea, dyArea: dyArea)
        return scale(dx: dxContent, dy: dyContent, s: s)
    }

    // MARK: utility

    public class func normalize<T where T: Substractable, T: Dividable>(value: T, _ i1: T, _ i2: T) -> T {
        return (value - i1) / (i2 - i1)
    }
    public class func denormalize<T where T: Substractable, T: Multiplicable, T: Addable>(value: T, _ i1: T, _ i2: T) -> T {
        return value * (i2 - i1) + i1
    }
    public class func interpolate<T where T: Substractable, T: Multiplicable, T: Addable>(value: T, _ i1: T, _ i2: T) -> T {
        return value * (i2 - i1) + i1
    }
    public class func map<T where T: Addable, T: Substractable, T: Multiplicable, T: Dividable>(value: T, _ a1: T, _ a2: T, _ b1: T, _ b2: T) -> T {
        return b1 + ((b2 - b1) * (value - a1)) / (a2 - a1)
    }

    public class func interpolate<T where T: Substractable, T: Multiplicable, T: Addable>(x1 x1: T, y1: T, x2: T, y2: T, t: T) -> (x: T, y: T) {
        return (x: interpolate(t, x1, x2), y: interpolate(t, y1, y2))
    }

}
