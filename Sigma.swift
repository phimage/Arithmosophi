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

public extension CollectionType where Self.Generator.Element: protocol<Averagable, Initializable, Substractable, Multiplicable> {
    
    // Return varianceSample: Σ( (Element - average)^2 ) / (count - 1)
    // https://en.wikipedia.org/wiki/Variance#Sample_variance
    public var varianceSample: Self.Generator.Element? {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        
        let avgerageValue = average
        let n = self.reduce(Self.Generator.Element()) { total, value in
            total + (avgerageValue - value) * (avgerageValue - value)
        }
        
        return n / (count - 1)
    }
    
    // Return variancePopulation: Σ( (Element - average)^2 ) / count
    // https://en.wikipedia.org/wiki/Variance#Population_variance
    public var variancePopulation: Self.Generator.Element?{
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count == 0 { return nil }
        
        let avgerageValue = average
        let numerator = self.reduce(Self.Generator.Element()) { total, value in
            total +  (avgerageValue - value) * (avgerageValue - value)
        }
        
        return numerator / count
    }
    
}

public extension CollectionType where Self.Generator.Element: protocol<Averagable, Initializable, Substractable, Multiplicable, Arithmos> {
    
    public var standardDeviationSample: Self.Generator.Element? {
        return varianceSample?.sqrt() ?? nil
    }
    
    public var standardDeviationPopulation: Self.Generator.Element? {
        return variancePopulation?.sqrt() ?? nil
    }
    
    public var σSample: Self.Generator.Element? {
        return standardDeviationSample
    }
    
    public var σPopulation: Self.Generator.Element? {
        return standardDeviationPopulation
    }
    
}

// MARK: covariance
public extension CollectionType where Self.Generator.Element: protocol<Averagable, Initializable, Substractable, Multiplicable, Arithmos> {
    
    
    public func covarianceSample<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W) -> Self.Generator.Element? {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        let withCount = AveragableDivideType(with.count.toIntMax()) // AveragableDivideType...
        guard count == withCount else {
            return nil
        }
        
        let average = self.average
        let withAverage = with.average
        
        var sum = Self.Generator.Element()
        for (element, withElement) in zip(self, with) {
            sum += (element - average) * (withElement - withAverage)
        }
        
        return sum / (count - 1)
    }
    
    public func covariancePopulation<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W) -> Self.Generator.Element? {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        let withCount = AveragableDivideType(with.count.toIntMax()) // AveragableDivideType...
        guard count == withCount else {
            return nil
        }
        
        let average = self.average
        let withAverage = with.average
        
        var sum = Self.Generator.Element()
        for (element, withElement) in zip(self, with) {
            sum += (element - average) * (withElement - withAverage)
        }
        
        return sum / count
    }

}

// MARK: Pearson product-moment correlation coefficient
public extension CollectionType where Self.Generator.Element: protocol<Averagable, Initializable, Substractable, Multiplicable, Arithmos, Equatable, Dividable> {
    
    // http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient
    public func pearson<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W) -> Self.Generator.Element? {
        if let cov = self.covariancePopulation(with),
            σself = self.standardDeviationPopulation,
            σwith = with.standardDeviationPopulation {
            
            let zero = Self.Generator.Element()
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
    case OLS
    case Multiply
    // case Accelerate (use upsurge?)
}

// Use with Double and fFloat (not Int)
public extension CollectionType where Self.Generator.Element: protocol<Averagable, Initializable, Substractable, Multiplicable, Dividable> {

    // @return (intercept, slope) where with = slope * self + intercept
    public func linearRegression<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W, method: LinearRegressionMethod = .OLS)  -> (Self.Generator.Element, Self.Generator.Element)? {
        let count = AveragableDivideType(self.count.toIntMax()) // AveragableDivideType...
        if count < 2 { return nil }
        let withCount = AveragableDivideType(with.count.toIntMax()) // AveragableDivideType...
        guard count == withCount else {
            return nil
        }

        let average = self.average
        let withAverage = with.average
        
        var sum1 = Self.Generator.Element()
        var sum2 = Self.Generator.Element()
        switch method {
        case .Multiply:
            let m1 = multiply(with).average
            sum1 = m1 - average * withAverage
            let m2 = multiply(self).average
            sum2 = m2 - average * average
            break
        case .OLS:
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

    public func linearRegressionClosure<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W, method: LinearRegressionMethod = .OLS)  -> (Self.Generator.Element -> Self.Generator.Element)? {
        guard let (intercept, slope) = self.linearRegression(with) else {
            return nil
        }
        // y = slope * x + intercept
        return { intercept + slope * $0 }
    }
    
    // Create a closure : slope * x + intercept with x closure parameters
    public static func linearRegressionClosure(intercept: Self.Generator.Element, slope: Self.Generator.Element)  -> (Self.Generator.Element -> Self.Generator.Element) {
        return { intercept + slope * $0 }
    }

    // https://en.wikipedia.org/wiki/Coefficient_of_determination
    public func coefficientOfDetermination<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W, linearRegressionClosure: (Self.Generator.Element -> Self.Generator.Element)) -> Self.Generator.Element {

        let withAverage = with.average
        var sumSquareModel = Self.Generator.Element() // sum of squares of the deviations of the estimated values of the response variable of the model
        var sumSquareTotal = Self.Generator.Element() // sum of squares of the deviations of the observed
        
        for (element, withElement) in zip(self, with) {
            let predictedValue = linearRegressionClosure(element)
            let sub1 = predictedValue - withAverage
            sumSquareModel += sub1 * sub1
            let sub2 = withElement - withAverage
            sumSquareTotal += sub2 * sub2
        }
        return sumSquareModel / sumSquareTotal
    }

    public func coefficientOfDetermination<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W, intercept: Self.Generator.Element, slope: Self.Generator.Element) -> Self.Generator.Element {
        return self.coefficientOfDetermination(with, linearRegressionClosure: Self.linearRegressionClosure(intercept, slope: slope))
    }

}

// MARK:- collection operations

// MARK: multiply
private extension CollectionType where Self.Generator.Element: protocol<Multiplicable> {
    
    private func multiply<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W) -> [Self.Generator.Element] {
        return zip(self, with).map { s, w in
            return s * w
        }
    }
    
}

// MARK: add
private extension CollectionType where Self.Generator.Element: protocol<Addable> {
    
    private func add<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (array: W) -> [Self.Generator.Element] {
        return zip(self, array).map { s, w in
            return s + w
        }
    }
    
}

// MARK: subtract
private extension CollectionType where Self.Generator.Element: protocol<Substractable> {
    
    private func subtract<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (array: W) -> [Self.Generator.Element] {
        return zip(self, array).map { s, w in
            return s - w
        }
    }
    
}

// MARK: divide
private extension CollectionType where Self.Generator.Element: protocol<Dividable> {
    
    private func divide<W: CollectionType where W.Generator.Element == Self.Generator.Element>
        (with: W) -> [Self.Generator.Element] {
        return zip(self, with).map { s, w in
            return s / w // NO ZERO valu
        }
    }
    
}
