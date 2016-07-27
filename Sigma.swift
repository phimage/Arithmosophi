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


// MARK: median
public extension CollectionType where Self.Generator.Element: protocol<Averagable, Comparable, Initializable> {
    
    public var median: Self.Generator.Element? {
        let count = AveragableDivideType(self.count.toIntMax()) // Int64...
        if count == 0 {
            return nil
        }
        let sorted = self.sort { (l, r) -> Bool in
            return l < r
        }
        
        if count % 2 == 0 {
            let leftIndex = Int(count / 2 - 1)
            let leftValue = sorted[leftIndex]
            let rightValue = sorted[leftIndex + 1]
            return (leftValue + rightValue) / 2
        } else {
            return sorted[Int(count / 2)]
        }
    }
    
    public var medianLow: Self.Generator.Element? {
        let count = AveragableDivideType(self.count.toIntMax()) // Int64...
        if count == 0 {
            return nil
        }
        let sorted = self.sort { (l, r) -> Bool in
            return l < r
        }
        
        if count % 2 == 0 {
            return sorted[Int(count / 2) - 1]
        } else {
            return sorted[Int(count / 2)]
        }
    }
    
    public var medianHigh: Self.Generator.Element? {
        let count = AveragableDivideType(self.count.toIntMax()) // Int64...
        if count == 0 {
            return nil
        }
        let sorted = self.sort { (l, r) -> Bool in
            return l < r
        }
        return sorted[Int(count / 2)]
    }
}

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
