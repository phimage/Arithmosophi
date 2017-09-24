//
//  ArithmosophiOSXTests.swift
//  ArithmosophiOSXTests
//
//  Created by phimage on 16/06/15.
//  Copyright (c) 2015 phimage. All rights reserved.
//

import Cocoa
import XCTest
import Arithmosophi

class ArithmosophiOSXTests: XCTestCase {

    let aInt = [1, 2, 3, 4]
    let aString = ["a", "b", "c", "d"]
    let aArray = [["a", "b"], ["c"], ["d"]]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSumInt() {
        let value = aInt.sum
        let expected = 1 + 2 + 3 + 4
        XCTAssertEqual(value, expected)
    }
    func testProductInt() {
        let value = aInt.product
        let expected = 1 * 2 * 3 * 4
        XCTAssertEqual(value, expected)
    }
    func testSumString() {
        let value = aString.sum
        let expected = aString.joined(separator: "")
        XCTAssertEqual(value, expected)
    }
    func testSumArray() {
        let value = aArray.sum
        let expected = aArray.flatMap {$0}
        XCTAssertEqual(value, expected)
    }

    // MARK: - Complex

    func testComplex() {

        let c = Complex(real: 2, imaginary: 3)
        let c2 = Complex(real: 4, imaginary: 2)

        let c3 = c + c2
        XCTAssertEqual(c3.real, c.real + c2.real)
        XCTAssertEqual(c3.imaginary, c.imaginary + c2.imaginary)

        let c3p = c - c2
        XCTAssertEqual(c3p.real, c.real - c2.real)
        XCTAssertEqual(c3p.imaginary, c.imaginary - c2.imaginary)

        let r4 = 1
        let i4 = 3
        let c4: Complex = r4 + i4.i
        XCTAssertEqual(c4.real, r4)
        XCTAssertEqual(c4.imaginary, i4)

        let c5 = c4 * 1.i
        XCTAssertEqual(c5.real, -i4)
        XCTAssertEqual(c5.imaginary, r4)

        let c6 = c5 * 1.i
        XCTAssertEqual(c4, -c6)

        var c7 = c6
        c7 += c6
        XCTAssertEqual(c7, c6 + c6)

        let sqrt = Complex(real: 4, imaginary: 9).sqrt()
        XCTAssertEqual(sqrt, Complex(real: 2, imaginary: 3))
    }

    // MARK: - Average

    func testAverage() {
        let result = [1, 12, 19.5, -5, 3, 8].average
        XCTAssertEqual(6.4166666667, round10(result))
    }

    func testAverage_whenEmpty() {
        let result = [Double]().average
        XCTAssert(result == 0)
    }

    func testAverageInt() {
        var result =   [1, 2, 3, 4].average
        XCTAssertEqual(2, result)

        result =   [0, 1, 2, 3, 4].average
        XCTAssertEqual(2, result)

        result =   [1, 2, 3, 4, 5].average
        XCTAssertEqual(3, result)
    }

    // MARK: - Median

    func testGcd() {
        XCTAssertEqual(3.gcd(with: 0), 3)
        XCTAssertEqual(0.gcd(with: 3), 3)

        XCTAssertEqual(3.gcd(with: 4), 1)
        XCTAssertEqual(3.gcd(with: 1), 1)
        XCTAssertEqual(34.gcd(with: 1), 1)
        XCTAssertEqual(4.gcd(with: 2), 2)
        XCTAssertEqual(2.gcd(with: 4), 2)
        XCTAssertEqual(4.gcd(with: 4), 4)
        XCTAssertEqual(3.gcd(with: 3), 3)
        XCTAssertEqual(1024.gcd(with: 4), 4)

        XCTAssertEqual([0, 5, 4].gcd, 1)
        XCTAssertEqual([0, 5].gcd, 5)
        XCTAssertEqual([2, 4, 8, 16, 32, 64, 128].gcd, 2)
        XCTAssertEqual([4, 8, 16, 32, 64, 128].gcd, 4)
    }

    // MARK: - Median

    func testMedian_oddNumberOfItems() {
        if let result = [1.0, 12.0, 19.5, 3.0, -5.0].median {
            XCTAssertEqual(3, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedian_evenNumberOfItems() {
        if let result = [1, 12, 19.5, 3, -5, 8].median {
            XCTAssertEqual(5.5, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedian_oneItem() {
        if let result = [8].median {
            XCTAssertEqual(8, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedian_whenEmpty() {
        let result = [Double]().median
        XCTAssertNil(result)
    }

    // MARK: - Median Low

    func testMedianLow_oddNumberOfItems() {
        if let result = [1, 12, 19.5, 3, -5].medianLow {
            XCTAssertEqual(3, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedianLow_evenNumberOfItems() {
        if let result = [1, 12, 19.5, 3, -5, 8].medianLow {
            XCTAssertEqual(3, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedianLow_oneItem() {
        if let result = [8].medianLow {
            XCTAssertEqual(8, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedianLow_whenEmpty() {
        let a = [Double]()
        let result = a.medianLow
        XCTAssertNil(result)
    }

    // MARK: - Median High

    func testMedianHigh_oddNumberOfItems() {
        if let result = [1, 12, 19.5, 3, -5].medianHigh {
            XCTAssertEqual(3, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedianHigh_evenNumberOfItems() {
        if let result = [1, 12, 19.5, 3, -5, 8].medianHigh {
            XCTAssertEqual(8, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedianHigh_oneItem() {
        if let result = [8.0].medianHigh {
            XCTAssertEqual(8.0, result)
        } else {
            XCTFail("no result")
        }
    }

    func testMedianHigh_whenEmpty() {
        let a = [Double]()
        let result = a.medianHigh
        XCTAssertNil(result)
    }

    // MARK: - Sample variance

    func testVarianceSample() {
        if let result = [1, 12, 19.5, -5, 3, 8].varianceSample {
            XCTAssertEqual(75.2416666667, round10(result))
        } else {
            XCTFail("no result")
        }
    }

    func testVarianceSample_whenSame() {
        if let result = [3, 3].varianceSample {
            XCTAssertEqual(0, result)
        } else {
            XCTFail("no result")
        }
    }

    func testVarianceSample_whenOne() {
        let result = [1].varianceSample
        XCTAssertNil(result)

    }

    func testVariancePopulation() {
        if let result = [1, 12, 19.5, -5, 3, 8].variancePopulation {
            XCTAssertEqual(62.7013888889, round10(result))
        } else {
            XCTFail("no result")
        }

    }

    func testVariancePopulation_whenSame() {
        if let result = [3, 3].variancePopulation {
            XCTAssertEqual(0, result)
        } else {
            XCTFail("no result")
        }

    }

    func testVariancePopulation_whenOne() {
        if let result = [1].variancePopulation {
            XCTAssertEqual(0, result)
        } else {
            XCTFail("no result")
        }

    }

    func testVariancePopulation_whenEmpty() {
        let result = [Double]().variancePopulation
        XCTAssertNil(result )
    }

    // MARK: - Sample standard deviation

    func testSampleStandardDeviation() {
        if let result = [1, 12, 19.5, -5, 3, 8].standardDeviationSample {
            XCTAssertEqual(8.6741954478, round10(result))
        } else {
            XCTFail("no result")
        }

    }

    func testSampleStandardDeviation_whenSame() {
        if let result = [3, 3].standardDeviationSample {
            XCTAssertEqual(0, round10(result))
        } else {
            XCTFail("no result")
        }

    }

    func testSampleStandardDeviation_whenOne() {
        let result = [1.0].standardDeviationSample
        XCTAssertNil(result)
    }

    func testSampleStandardDeviation_whenEmpty() {
        let result = [Double]().standardDeviationSample
        XCTAssertNil(result )
    }

    // MARK: - Population standard deviation

    func testPopulationStandardDeviation() {
        if let result = [1, 12, 19.5, -5, 3, 8].standardDeviationPopulation {
            XCTAssertEqual(7.9184208583, round10(result))
        } else {
            XCTFail("no result")
        }

        if let result = [2.0, 4.0, 4.0, 4.0, 5.0, 5.0, 7.0, 9.0].standardDeviationPopulation {
            XCTAssertEqual(2.0, result)
        } else {
            XCTFail("no result")
        }

    }

    func testPopulationStandardDeviation_whenOne() {
        if let result = [1].standardDeviationPopulation {
            XCTAssertEqual(0, result)
        } else {
            XCTFail("no result")
        }

    }

    func testPopulationStandardDeviation_whenEmpty() {
        let result = [Double]().standardDeviationPopulation
        XCTAssertNil(result )
    }

    // MARK: - Sample covariance

    func testSampleCovariance() {
        if let result = [1, 2, 3.5, 3.7, 8, 12].covarianceSample([0.5, 1, 2.1, 3.4, 3.4, 4]) {

            XCTAssertEqual(5.03, round10(result))
        } else {
            XCTFail("no result")
        }

    }

    func testSampleCovariance_unequalSamples() {
        let result = [1, 2, 3.5, 3.7, 8, 12].covarianceSample([0.5, 4])

        XCTAssertNil(result )
    }

    func testSampleCovariance_whenGivenSingleSetOfValues() {
        let result = [1.2].covarianceSample([0.5])

        XCTAssertNil(result )
    }

    func testSampleCovariance_samplesAreEmpty() {
        let result = [Double]().covarianceSample([])

        XCTAssertNil(result )
    }

    // MARK: - Population covariance

    func testPopulationCovariance() {
        if let result = [1, 2, 3.5, 3.7, 8, 12].covariancePopulation([0.5, 1, 2.1, 3.4, 3.4, 4]) {
            XCTAssertEqual(4.1916666667, round10(result))
        } else {
            XCTFail("no result")
        }

    }

    func testPopulationCovariance_unequalSamples() {
        let result = [1, 2, 3.5, 3.7, 8, 12].covariancePopulation([0.5])
        XCTAssertNil(result )
    }

    func testPopulationCovariance_emptySamples() {
        let result = [Double]().covariancePopulation([])

        XCTAssertNil(result )
    }

    // MARK: - Pearson product-moment correlation coefficient

    func testPearson() {
        if let result = [1, 2, 3.5, 3.7, 8, 12].pearson([0.5, 1, 2.1, 3.4, 3.4, 4]) {

            XCTAssertEqual(0.8437608594, round10(result))
        } else {
            XCTFail("no result")
        }

    }

    func testPearson_unequalSamples() {
        let result = [1, 2, 3.5, 3.7, 8, 12].pearson([0.5])

        XCTAssertNil(result)
    }

    func testPearson_emptySamples() {
        let result = [Double]().pearson([])

        XCTAssertNil(result)
    }

    // MARK: - Linear regression

    public typealias LinearRegressionTestData = (x: [Double], y: [Double], intercept: Double, slope: Double)

    func testLinearRegression() {

        let tests: [LinearRegressionTestData] = [
            (x: [1.0, 2.0, 3], y: [2.0, 3, 4], intercept: 1.0, slope: 1.0),
            (x: [1.0, 2, 3], y: [2.0, 4, 6], intercept: 0.0, slope: 2.0),
            (x: [2.0, 4, 6], y: [1.0, 2, 3], intercept: 0.0, slope: 0.5)
        ]

        for test in tests {
            testLinearRegression( test, method: .ols)
        }

        // List of points
        let data = [(0.1, 0.2), (338.8, 337.4), (118.1, 118.2),
            (888.0, 884.6), (9.2, 10.1), (228.1, 226.5), (668.5, 666.3), (998.5, 996.3),
            (449.1, 448.6), (778.9, 777.0), (559.2, 558.2), (0.3, 0.4), (0.1, 0.6), (778.1, 775.5),
            (668.8, 666.9), (339.3, 338.0), (448.9, 447.5), (10.8, 11.6), (557.7, 556.0),
            (228.3, 228.1), (998.0, 995.8), (888.8, 887.6), (119.6, 120.2), (0.3, 0.3),
            (0.6, 0.3), (557.6, 556.8), (339.3, 339.1), (888.0, 887.2), (998.5, 999.0),
            (778.9, 779.0), (10.2, 11.1), (117.6, 118.3), (228.9, 229.2), (668.4, 669.1),
            (449.2, 448.9), (0.2, 0.5)]

        let x = data.map { $0.0 }
        let y = data.map { $0.1 }

        if let (intercept, slope) = y.linearRegression(x, method: .multiply) {
            XCTAssertEqual(-0.262/*323073774029*/, round3(intercept))
            XCTAssertEqual(1.0021168180/*204547*/, round10(slope))
        } else {
            XCTFail("no result")
        }

    }

    func testLinearRegression(_ data: LinearRegressionTestData, method: LinearRegressionMethod) {
        if let (intercept, slope) = data.x.linearRegression(data.y, method: method) {
            XCTAssertEqual(data.intercept, intercept)
            XCTAssertEqual(data.slope, slope)
        } else {
            XCTFail("no result")
        }
    }

    func testLinearRegression_same() {
        let array = [1, 2, 3, 4, 5]
        if let (intercept, slope) = array.linearRegression(array) {
            XCTAssertEqual(0, intercept)
            XCTAssertEqual(1, slope)
        } else {
            XCTFail("no result")
        }
    }

    func testLinearRegression_sameX() {
        let x: Double = 12
        if let (intercept, slope) = [1, 2, 3.5, 3.7, 8, 12].linearRegression([x, x, x, x, x, x]) {
            XCTAssertEqual(x, intercept)
            XCTAssertEqual(0, round10(slope))
        } else {
            XCTFail("no result")
        }

    }

    func testLinearRegression_unequalSamples() {
        let result = [1, 2, 3.5, 3.7, 8, 12].linearRegression([0.5])

        XCTAssertNil(result)
    }

    func testLinearRegression_emptySamples() {
        let result = [Double]().linearRegression([])

        XCTAssertNil(result)
    }
    // from https://www.random.org/gaussian-distributions/
    let normal = [ -5.2915953320, -3.6772947140,
                   1.4557255930, -9.6071756130,
                   -1.1790649220, -7.0769571490,
                   -8.5630216570, 2.7092033120,
                   1.0354204630, -4.7601903490,
                   -2.4656553830, -8.4457472370,
                   1.3116860800, 5.3932010560,
                   -8.3067210290, -2.9978551230,
                   -1.5617564410, 2.8172913100,
                   -7.4367589440, 5.5079234150,
                   -3.1174784250, 5.0074376570,
                   7.6770023300, -6.9221058010,
                   8.9388762580, -7.0601278450,
                   -1.5599111900, -7.4661002020,
                   9.0819772330, 1.7047414380,
                   -8.7470589310, 5.6994461800,
                   5.7906965610, -1.2354097290,
                   -1.1406516450, -7.0258626380,
                   5.2256994890, -1.4152811050,
                   1.1831176040, 1.8354849160,
                   -8.1424724470, 2.1366773060,
                   8.4985054710, 1.2962314850,
                   -1.5712894080, -7.0212303740,
                   -3.2147250270, -4.1866789920,
                   -4.6732570270, -1.4273105910,
                   3.9407343060, 5.5349683550,
                   8.7855289880, 1.6035290570,
                   1.0786710480, 6.0958136180,
                   2.4547870210, 1.5011664410,
                   -9.8014391980, -5.3496840540,
                   5.4229997770, 2.1089126870,
                   -5.5912587730, 6.5240664240,
                   -6.7618207180, -1.6253052660,
                   -6.4307974200, -1.3235495380,
                   2.9666389180, 6.3338374900,
                   -1.3078702770, -2.5370415940,
                   1.4439756110, -7.0100303580,
                   1.1005042140, 1.1959076320,
                   9.4533489840, 1.1038169390,
                   5.6982039450, -2.4824358710,
                   -8.1115556390, 4.7546579320,
                   -2.8402880120, 2.3448283340,
                   7.0971058070, -4.7399041990,
                   -6.7958303030, 1.2216677600,
                   -1.1084760130, 1.1861440530,
                   6.5609134430, 1.8454490790,
                   1.0109369680, 5.1013568660,
                   -9.1403339340, -1.0025365860,
                   4.5729001100, 1.3266714800,
                   -2.5922245540, 4.3362012520]
    // MARK: - moment
    func testMoment() {
        let a = [1, 2, 3.5, 3.7, 8, 12]
        var moment = a.moment

        XCTAssertNotNil(moment)

        XCTAssertEqual(round10(moment?.average ?? Double.max), round10(a.average))

        XCTAssertEqual(round10(moment?.varianceSample ?? Double.max), round10(a.varianceSample ?? Double.min))

        moment = normal.moment

        guard let skewness = moment?.skewness, let excessKurtosis = moment?.excessKurtosis else {
            XCTFail("cannot get moments")
            return
        }

        XCTAssertTrue( -1 < skewness &&  skewness < 1 )
        XCTAssertTrue( -1 < excessKurtosis && excessKurtosis < 1 )
    }

}

func roundToPlaces(_ value: Double, places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(value * divisor) / divisor
}

func round10(_ value: Double) -> Double {
    return roundToPlaces(value, places: 10)
}

func round3(_ value: Double) -> Double {
    return roundToPlaces(value, places: 3)
}
