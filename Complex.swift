

public struct Complex: CustomStringConvertible, UnsignedArithmeticType {
    public var real:UnsignedArithmeticType
    public var imaginary:UnsignedArithmeticType
    
    public var description: String {
        return "\(self.real) + \(self.imaginary)i"
    }
    
    public var modululus: Double {
        let squaredReal = real * real
        let squaredImaginary = imaginary * imaginary
        return sqrt((squaredImaginary + squaredReal).asDouble())
    }
    
    public var conjugate: Complex {
        let inversImaginary = imaginary * -1
        return Complex(real: real, imaginary: inversImaginary)
    }
    
    func combine(rhs:Complex, combineBehavior:(BaseNumeric, BaseNumeric) -> BaseNumeric) -> Complex {
        var realPart = combineBehavior(self.real, rhs.real)
        var imaginaryPart = combineBehavior(self.imaginary, rhs.imaginary)
        return Complex(real: realPart, imaginary: imaginaryPart)
    }
}

public func +(lhs:Complex, rhs:BaseNumeric) -> Complex {
    return lhs + Complex(real: rhs, imaginary: 0)
}
public func +(lhs:BaseNumeric, rhs:Complex) -> Complex {
    return Complex(real: lhs, imaginary: 0) * rhs
}
public func +(lhs: Complex, rhs: Complex) -> Complex {
    return lhs.combine(rhs, combineBehavior: {(leftValue:BaseNumeric,rightValue:BaseNumeric) -> BaseNumeric in
        return leftValue + rightValue
    })
}

public func -(lhs:Complex, rhs:BaseNumeric) -> Complex {
    return lhs - Complex(real: rhs, imaginary: 0)
}
public func -(lhs:BaseNumeric, rhs:Complex) -> Complex {
    return Complex(real: lhs, imaginary: 0) - rhs
}
public func -(lhs: Complex, rhs: Complex) -> Complex {
    return lhs.combine(rhs, combineBehavior: {(leftValue:BaseNumeric,rightValue:BaseNumeric) -> BaseNumeric in
        return leftValue - rightValue
    })
}

public func *(lhs:Complex, rhs: BaseNumeric) -> Complex {
    return lhs * Complex(real: rhs, imaginary: 0)
}
public func *(lhs:BaseNumeric, rhs:Complex) -> Complex {
    return Complex(real: lhs, imaginary: 0) * rhs
}
public func *(lhs: Complex, rhs: Complex) -> Complex {
    let productOfReals = lhs.real * rhs.real
    let productOfImaginaries = rhs.imaginary * lhs.imaginary
    let realPart = productOfReals - productOfImaginaries
    let imaginaryPart = ((lhs.real + lhs.imaginary) * (rhs.real + rhs.imaginary)) - productOfReals - productOfImaginaries
    return Complex(real:realPart, imaginary:imaginaryPart)
}

public func /(lhs: Complex, rhs:BaseNumeric) -> Complex {
    return lhs / Complex(real: rhs, imaginary: 0)
}
public func /(lhs:BaseNumeric, rhs:Complex) -> Complex {
    return Complex(real: lhs, imaginary: 0) / rhs
}
public func /(lhs: Complex, rhs: Complex) -> Complex {
    let denominator = rhs.real * rhs.real + rhs.imaginary * rhs.imaginary
    let realPart = (lhs.real * rhs.real + lhs.imaginary * rhs.imaginary) / denominator
    let imaginaryPart = (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary) / denominator
    return Complex(real: realPart,imaginary: imaginaryPart)
}

public prefix func - (instance: Complex) -> Complex {
    return Complex(real: -instance.real, imaginary: -instance.imaginary)
}

public prefix func ++(inout x: Complex) -> Complex {
    x.real++
    x.imaginary++
    return self
}
public postfix func ++(inout x: Complex) -> Complex {
    let real = x.real
    let imaginary = x.imaginary
    x.real++
    x.imaginary++
    return Complex(real: real, imaginary: imaginary)
}
public prefix func --(inout x: Complex) -> Complex {
    x.real--
    x.imaginary--
    return self
}
public postfix func --(inout x: Complex) -> Complex {
    let real = x.real
    let imaginary = x.imaginary
    x.real--
    x.imaginary--
    return Complex(real: real, imaginary: imaginary)
}

public func % (lhs: Complex, rhs: Complex) -> Complex {
    return Complex(real: 0, imaginary: 0) // FIXME
}
