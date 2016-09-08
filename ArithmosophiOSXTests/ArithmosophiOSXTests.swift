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
    let aString = ["a","b","c","d"]
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
    
    //MARK: - Median High
    
    func testMedianHigh_oddNumberOfItems() {
        if let result = [1, 12, 19.5, 3, -5].medianHigh{
            XCTAssertEqual(3, result)
        } else {
            XCTFail("no result")
        }
    }
    
    func testMedianHigh_evenNumberOfItems() {
        if let result = [1, 12, 19.5, 3, -5, 8].medianHigh{
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
        }
        else {
            XCTFail("no result")
        }
    }
    
    func testVarianceSample_whenSame() {
        if let result = [3, 3].varianceSample {
            XCTAssertEqual(0, result)
        }
        else {
            XCTFail("no result")
        }
    }
    
    func testVarianceSample_whenOne() {
        let result = [1].varianceSample
        XCTAssertNil(result)
        
    }
    
    func testVariancePopulation() {
        if let result = [1, 12, 19.5, -5, 3, 8].variancePopulation{
            XCTAssertEqual(62.7013888889, round10(result))
        } else {
            XCTFail("no result")
        }
        
    }
    
    func testVariancePopulation_whenSame() {
        if let result = [3, 3].variancePopulation{
            XCTAssertEqual(0,result)
        } else {
            XCTFail("no result")
        }
        
    }
    
    func testVariancePopulation_whenOne() {
        if let result = [1].variancePopulation{
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
        if let result = [1, 12, 19.5, -5, 3, 8].standardDeviationSample{
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
        if let result = [1].standardDeviationPopulation{
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
            (x: [2.0, 4, 6] , y: [1.0, 2, 3], intercept: 0.0, slope: 0.5),
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
