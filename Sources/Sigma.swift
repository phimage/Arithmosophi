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

public enum VarianceMode {
    case sample
    case population
}

public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable {

    // Return varianceSample: Σ( (Element - average)^2 ) / (count - 1)
    // https://en.wikipedia.org/wiki/Variance#Sample_variance
  var varianceSample: Self.Iterator.Element? {
        if self.count < 2 { return nil }

        let avgerageValue = average
        let n = self.reduce(Self.Iterator.Element()) { total, value in
            total + (avgerageValue - value) * (avgerageValue - value)
        }

        let count = AveragableDivideType(Int64(self.count)) // XXX check swift 4 conversion...
        return n / (count - 1)
    }

    // Return variancePopulation: Σ( (Element - average)^2 ) / count
    // https://en.wikipedia.org/wiki/Variance#Population_variance
  var variancePopulation: Self.Iterator.Element? {
        if self.count == 0 { return nil }

        let avgerageValue = average
        let numerator = self.reduce(Self.Iterator.Element()) { total, value in
            total +  (avgerageValue - value) * (avgerageValue - value)
        }

        let count = AveragableDivideType(Int64(self.count)) // XXX check swift 4 conversion...
        return numerator / count
    }

  func variance(mode: VarianceMode) ->  Self.Iterator.Element? {
        switch mode {
        case .sample: return varianceSample
        case .population: return variancePopulation
        }
    }

}

public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable & Arithmos {

  var standardDeviationSample: Self.Iterator.Element? {
        return varianceSample?.sqrt() ?? nil
    }

  var standardDeviationPopulation: Self.Iterator.Element? {
        return variancePopulation?.sqrt() ?? nil
    }

  func standardDeviation(mode: VarianceMode) ->  Self.Iterator.Element? {
        switch mode {
        case .sample: return standardDeviationSample
        case .population: return standardDeviationPopulation
        }
    }

  var σSample: Self.Iterator.Element? {
        return standardDeviationSample
    }

  var σPopulation: Self.Iterator.Element? {
        return standardDeviationPopulation
    }

}

// MARK: Moment, kurtosis, skewness
public struct Moment<T: Averagable & ExpressibleByIntegerLiteral & Substractable & Multiplicable & Arithmos & Equatable & Dividable> {

    public private(set) var M0: T = 0
    public private(set) var M1: T = 0
    public private(set) var M2: T = 0
    public private(set) var M3: T = 0
    public private(set) var M4: T = 0

    init?(_ col: [T]) {
        if col.count == 0 { return nil }

        M0 = T(Double(col.count))
        var n: T = 0
        for x in col {
            let n1 = n
            n += 1
            let delta = x - M1
            let delta_n = delta / n
            let delta_n2 = delta_n * delta_n
            let term1 = delta * delta_n * n1
            M1 += delta_n
            let t4 = 6 * delta_n2 * M2 - 4 * delta_n * M3
            let t3 = (n*n - 3*n + 3)
            let t5 = term1 * delta_n2 * t3
            M4 += t5 + t4
            M3 += (term1 * delta_n * (n - 2)) as T - (3 * delta_n * M2) as T
            M2 += term1
        }
    }

    // https://en.wikipedia.org/wiki/Kurtosis#Excess_kurtosis
    public var excessKurtosis: T {
        return kurtosis - 3
    }

    //https://en.wikipedia.org/wiki/Kurtosis
    public var kurtosis: T {
        return (M0 * M4) / (M2 * M2)
    }

    // https://en.wikipedia.org/wiki/Skewness
    public var skewness: T {
        let p: T = 3 / 2
        return M0.sqrt() * M3 / M2.pow(p)
    }

    public var average: T {
        return M1
    }

    public var varianceSample: T {
        return M2 / (M0 - 1)
    }

    public var variancePopulation: T {
        return M2 / M0
    }

    public var standardDeviationSample: T {
        return varianceSample.sqrt()
    }

    public var standardDeviationPopulation: T {
        return variancePopulation.sqrt()
    }
}

public extension Collection where Self.Iterator.Element: Averagable & ExpressibleByIntegerLiteral & Substractable & Multiplicable & Arithmos & Equatable & Dividable {

    //https://en.wikipedia.org/wiki/Kurtosis
  var kurtosis: Self.Iterator.Element? {
        return moment?.kurtosis
    }

    // https://en.wikipedia.org/wiki/Skewness
  var skewness: Self.Iterator.Element? {
        return moment?.skewness
    }

    // https://en.wikipedia.org/wiki/Moment_(mathematics)
  var moment: Moment<Self.Iterator.Element>? {
        return Moment(Array(self))
    }

}

// MARK: covariance
public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable & Arithmos {

  func covariance<W: Collection>
        (_ with: W, type: VarianceMode) -> Self.Iterator.Element? where W.Iterator.Element == Self.Iterator.Element {
        switch type {
        case .sample:
            return covarianceSample(with)
        case .population:
            return covariancePopulation(with)
        }
    }

  func covarianceSample<W: Collection>
        (_ with: W) -> Self.Iterator.Element? where W.Iterator.Element == Self.Iterator.Element {
        if self.count < 2 { return nil }
        guard self.count == with.count else {
            return nil
        }

        let average = self.average
        let withAverage = with.average

        var sum = Self.Iterator.Element()
        for (element, withElement) in zip(self, with) {
            sum += (element - average) * (withElement - withAverage)
        }

        let count = AveragableDivideType(Int64(self.count)) // XXX check swift 4 conversion...
        return sum / (count - 1)
    }

  func covariancePopulation<W: Collection>
        (_ with: W) -> Self.Iterator.Element? where W.Iterator.Element == Self.Iterator.Element {
        if self.count < 2 { return nil }
        guard self.count == with.count else {
            return nil
        }

        let average = self.average
        let withAverage = with.average

        var sum = Self.Iterator.Element()
        for (element, withElement) in zip(self, with) {
            sum += (element - average) * (withElement - withAverage)
        }

        let count = AveragableDivideType(Int64(self.count)) // XXX check swift 4 conversion...
        return sum / count
    }

  func covariance<W: Collection>
        (_ with: W, mode: VarianceMode) -> Self.Iterator.Element? where W.Iterator.Element == Self.Iterator.Element {
        switch mode {
        case .sample: return covarianceSample(with)
        case .population: return covariancePopulation(with)
        }
    }

}

// MARK: Pearson product-moment correlation coefficient
public extension Collection where Self.Iterator.Element: Averagable & Initializable & Substractable & Multiplicable & Arithmos & Equatable & Dividable {

    // http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient
  func pearson<W: Collection>
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

// MARK: percentile
// https://en.wikipedia.org/wiki/Percentile
// NOT IMPLEMENTED YET

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
  func linearRegression<W: Collection>
        (_ with: W, method: LinearRegressionMethod = .ols)  -> (Self.Iterator.Element, Self.Iterator.Element)? where W.Iterator.Element == Self.Iterator.Element {

        guard self.count > 1 else {
            return nil
        }

        guard self.count == with.count else {
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
        case .ols:
            for (element, withElement) in zip(self, with) {
                let elMinusAverage = (element - average)
                sum1 += elMinusAverage * (withElement - withAverage)
                sum2 += elMinusAverage * elMinusAverage
            }
        }

        let slope = sum1 / sum2 // ISSUE Int will failed here by dividing by zero (Int linear regression must return float result)
        let intercept = withAverage - slope * average
        return (intercept, slope)
    }

  func linearRegressionClosure<W: Collection>
        (_ with: W, method: LinearRegressionMethod = .ols)  -> ((Self.Iterator.Element) -> Self.Iterator.Element)? where W.Iterator.Element == Self.Iterator.Element {
        guard let (intercept, slope) = self.linearRegression(with) else {
            return nil
        }
        // y = slope * x + intercept
        return { intercept + slope * $0 }
    }

    // Create a closure : slope * x + intercept with x closure parameters
  static func linearRegressionClosure(_ intercept: Self.Iterator.Element, slope: Self.Iterator.Element)  -> ((Self.Iterator.Element) -> Self.Iterator.Element) {
        return { intercept + slope * $0 }
    }

    // https://en.wikipedia.org/wiki/Coefficient_of_determination
  func coefficientOfDetermination<W: Collection>
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

  func coefficientOfDetermination<W: Collection>
        (_ with: W, intercept: Self.Iterator.Element, slope: Self.Iterator.Element) -> Self.Iterator.Element where W.Iterator.Element == Self.Iterator.Element {
        return self.coefficientOfDetermination(with, linearRegressionClosure: Self.linearRegressionClosure(intercept, slope: slope))
    }

}

// MARK: geometric mean
public extension Sequence where Self.Element: Addable & Arithmos & Dividable & Multiplicable & ExpressibleByIntegerLiteral {

  var geometricMean: Self.Element? {
        let zero: Self.Element  = 0
        var result = zero
        var n = zero
        for value in self {
            // swiftlint:disable:next shorthand_operator
            result = result * value
            n += 1
        }
        if n == 0 {
            return 0
        }
        return result.pow(1 / n)
    }

}

public extension Collection where Self.Element: Hashable {

    typealias HashableElement = Self.Element

    // Most frequent value in data set
    // https://en.wikipedia.org/wiki/Mode_(statistics)
  var mode: [Self.Element] {
        var counter = [HashableElement: Int]()
        var mode = [HashableElement]()
        var max = 0
        for value in self {
            if let c = counter[value] {
                counter[value] = c + 1
            } else {
                counter[value] = 0
            }

            let c = counter[value]!
            if c == max {
                mode.append(value)
            } else if c > max {
                max = c
                mode = [value]
            }
        }
        return mode
    }

}

// MARK: - collection operations

// MARK: multiply
private extension Sequence where Self.Element: Multiplicable {

    func multiply<W: Sequence>
        (_ with: W) -> [Self.Element] where W.Element == Self.Element {
        return zip(self, with).map { s, w in
            return s * w
        }
    }

}

// MARK: add
private extension Sequence where Self.Element: Addable {

    func add<W: Sequence>
        (_ array: W) -> [Self.Iterator.Element] where W.Element == Self.Element {
        return zip(self, array).map { s, w in
            return s + w
        }
    }

}

// MARK: subtract
private extension Sequence where Self.Element: Substractable {

    func subtract<W: Sequence>
        (_ array: W) -> [Self.Iterator.Element] where W.Element == Self.Element {
        return zip(self, array).map { s, w in
            return s - w
        }
    }

}

// MARK: divide
private extension Sequence where Self.Element: Dividable {

    func divide<W: Sequence>
        (_ with: W) -> [Self.Iterator.Element] where W.Element == Self.Element {
        return zip(self, with).map { s, w in
            return s / w // NO ZERO valu
        }
    }

}
