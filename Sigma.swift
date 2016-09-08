//
//  Sigma.swift
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

// MARK: variance
// http://en.wikipedia.org/wiki/Variance

public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable {
    
    // Return varianceSample: Σ( (Element - average)^2 ) / (count - 1)
    // https://en.wikipedia.org/wiki/Variance#Sample_variance
    public var varianceSample: Self.Iterator.Element? {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        
        let avgerageValue = average
        let n = self.reduce(Self.Iterator.Element()) { total, value in
            total + (avgerageValue - value) * (avgerageValue - value)
        }
        
        return n / (count - 1)
    }
    
    // Return variancePopulation: Σ( (Element - average)^2 ) / count
    // https://en.wikipedia.org/wiki/Variance#Population_variance
    public var variancePopulation: Self.Iterator.Element?{
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count == 0 { return nil }
        
        let avgerageValue = average
        let numerator = self.reduce(Self.Iterator.Element()) { total, value in
            total +  (avgerageValue - value) * (avgerageValue - value)
        }
        
        return numerator / count
    }
    
}

public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable & Arithmos {
    
    public var standardDeviationSample: Self.Iterator.Element? {
        return varianceSample?.sqrt() ?? nil
    }
    
    public var standardDeviationPopulation: Self.Iterator.Element? {
        return variancePopulation?.sqrt() ?? nil
    }
    
    public var σSample: Self.Iterator.Element? {
        return standardDeviationSample
    }
    
    public var σPopulation: Self.Iterator.Element? {
        return standardDeviationPopulation
    }
    
}

// MARK: covariance
public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable & Arithmos {
    
    
    public func covarianceSample<W: Collection>
        (_ with: W) -> Self.Iterator.Element? where W.Iterator.Element == Self.Iterator.Element {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        let withCount = AveragableDivideType(with.count.toIntMax()) // AveragableDivideType...
        guard count == withCount else {
            return nil
        }
        
        let average = self.average
        let withAverage = with.average
        
        var sum = Self.Iterator.Element()
        for (element, withElement) in zip(self, with) {
            sum += (element - average) * (withElement - withAverage)
        }
        
        return sum / (count - 1)
    }
    
    public func covariancePopulation<W: Collection>
        (_ with: W) -> Self.Iterator.Element? where W.Iterator.Element == Self.Iterator.Element {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        let withCount = AveragableDivideType(with.count.toIntMax()) // AveragableDivideType...
        guard count == withCount else {
            return nil
        }
        
        let average = self.average
        let withAverage = with.average
        
        var sum = Self.Iterator.Element()
        for (element, withElement) in zip(self, with) {
            sum += (element - average) * (withElement - withAverage)
        }
        
        return sum / count
    }

}

// MARK: Pearson product-moment correlation coefficient
public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable & Arithmos & Equatable & Dividable {
    
    // http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient
    public func pearson<W: Collection>
        (_ with: W) -> Self.Iterator.Element? where W.Iterator.Element == Self.Iterator.Element {
        if let cov = self.covariancePopulation(with),
            let σself = self.standardDeviationPopulation,
            let σwith = with.standardDeviationPopulation {
            
            let zero = Self.Iterator.Element()
            if σself == zero || σwith == zero {
                return nil
            }
            return cov / (σself * σwith)
        }
        return nil
    }
}

// TODO: percentile
// https://en.wikipedia.org/wiki/Percentile


// MARK: linear regression
// https://en.wikipedia.org/wiki/Linear_regression


public enum LinearRegressionMethod {
    case ols
    case multiply
    // case Accelerate (use upsurge?)
}

// Use with Double and fFloat (not Int)
public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable & Dividable {

    // @return (intercept, slope) where with = slope * self + intercept
    public func linearRegression<W: Collection>
        (_ with: W, method: LinearRegressionMethod = .ols)  -> (Self.Iterator.Element, Self.Iterator.Element)? where W.Iterator.Element == Self.Iterator.Element {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        let withCount = AveragableDivideType(with.count.toIntMax()) // AveragableDivideType...
        guard count == withCount else {
            return nil
        }

        let average = self.average
        let withAverage = with.average
        
        var sum1 = Self.Iterator.Element()
        var sum2 = Self.Iterator.Element()
        switch method {
        case .multiply:
            let m1 = multiply(with).average
            sum1 = m1 - average * withAverage
            let m2 = multiply(self).average
            sum2 = m2 - average * average
            break
        case .ols:
            for (element, withElement) in zip(self, with) {
                let elMinusAverage = (element - average)
                sum1 += elMinusAverage * (withElement - withAverage)
                sum2 += elMinusAverage * elMinusAverage
            }
            break
        }

        let slope = sum1 / sum2 // FIXME Int will failed here by dividing by zero (Int linear regression must return float result)
        let intercept = withAverage - slope * average
        return (intercept, slope)
    }

    public func linearRegressionClosure<W: Collection>
        (_ with: W, method: LinearRegressionMethod = .ols)  -> ((Self.Iterator.Element) -> Self.Iterator.Element)? where W.Iterator.Element == Self.Iterator.Element {
        guard let (intercept, slope) = self.linearRegression(with) else {
            return nil
        }
        // y = slope * x + intercept
        return { intercept + slope * $0 }
    }
    
    // Create a closure : slope * x + intercept with x closure parameters
    public static func linearRegressionClosure(_ intercept: Self.Iterator.Element, slope: Self.Iterator.Element)  -> ((Self.Iterator.Element) -> Self.Iterator.Element) {
        return { intercept + slope * $0 }
    }

    // https://en.wikipedia.org/wiki/Coefficient_of_determination
    public func coefficientOfDetermination<W: Collection>
        (_ with: W, linearRegressionClosure: ((Self.Iterator.Element) -> Self.Iterator.Element)) -> Self.Iterator.Element where W.Iterator.Element == Self.Iterator.Element {

        let withAverage = with.average
        var sumSquareModel = Self.Iterator.Element() // sum of squares of the deviations of the estimated values of the response variable of the model
        var sumSquareTotal = Self.Iterator.Element() // sum of squares of the deviations of the observed
        
        for (element, withElement) in zip(self, with) {
            let predictedValue = linearRegressionClosure(element)
            let sub1 = predictedValue - withAverage
            sumSquareModel += sub1 * sub1
            let sub2 = withElement - withAverage
            sumSquareTotal += sub2 * sub2
        }
        return sumSquareModel / sumSquareTotal
    }

    public func coefficientOfDetermination<W: Collection>
        (_ with: W, intercept: Self.Iterator.Element, slope: Self.Iterator.Element) -> Self.Iterator.Element where W.Iterator.Element == Self.Iterator.Element {
        return self.coefficientOfDetermination(with, linearRegressionClosure: Self.linearRegressionClosure(intercept, slope: slope))
    }

}

// MARK:- collection operations

// MARK: multiply
private extension Collection where Self.Iterator.Element: Multiplicable {
    
    func multiply<W: Collection>
        (_ with: W) -> [Self.Iterator.Element] where W.Iterator.Element == Self.Iterator.Element {
        return zip(self, with).map { s, w in
            return s * w
        }
    }
    
}

// MARK: add
private extension Collection where Self.Iterator.Element: Addable {
    
    func add<W: Collection>
        (_ array: W) -> [Self.Iterator.Element] where W.Iterator.Element == Self.Iterator.Element {
        return zip(self, array).map { s, w in
            return s + w
        }
    }
    
}

// MARK: subtract
private extension Collection where Self.Iterator.Element: Substractable {
    
    func subtract<W: Collection>
        (_ array: W) -> [Self.Iterator.Element] where W.Iterator.Element == Self.Iterator.Element {
        return zip(self, array).map { s, w in
            return s - w
        }
    }
    
}

// MARK: divide
private extension Collection where Self.Iterator.Element: Dividable {
    
    func divide<W: Collection>
        (_ with: W) -> [Self.Iterator.Element] where W.Iterator.Element == Self.Iterator.Element {
        return zip(self, with).map { s, w in
            return s / w // NO ZERO valu
        }
    }
    
}
