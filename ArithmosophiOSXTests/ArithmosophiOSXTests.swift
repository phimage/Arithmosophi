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
        let expected = aString.joinWithSeparator("")
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
        
        
        let c4: Complex = 1 + 3.i
        XCTAssertEqual(c4.real, 1)
        XCTAssertEqual(c4.imaginary, 3)
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
        if let result = [1, 12, 19.5, -5, 3, 8].standardDeviationPopulation{
            XCTAssertEqual(7.9184208583, round10(result))
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
    
 
   
}

func roundToPlaces(value: Double, places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(value * divisor) / divisor
}

func round10(value: Double) -> Double {
    return roundToPlaces(value, places: 10)
}
