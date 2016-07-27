# Arithmosophi - Arithmosoϕ

[![Join the chat at https://gitter.im/phimage/Arithmosophi](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/phimage/Arithmosophi?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat
            )](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-ios_osx-tvos-lightgrey.svg?style=flat
             )](https://developer.apple.com/resources/)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat
             )](https://developer.apple.com/swift)
[![Issues](https://img.shields.io/github/issues/phimage/Arithmosophi.svg?style=flat
           )](https://github.com/phimage/Arithmosophi/issues)
[![Cocoapod](http://img.shields.io/cocoapods/v/Arithmosophi.svg?style=flat)](http://cocoadocs.org/docsets/Arithmosophi/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

[<img align="left" src="logo.png" hspace="20">](#logo) Arithmosophi is a set of missing protocols that simplify arithmetic and statistics on generic objects or functions.
As `Equatable` define the `==` operator , `Addable` will define the `+` operator.
```swift
protocol Addable {
    func + (lhs: Self, rhs: Self) -> Self
}
[1, 2, 3, 4].sum //  1 + 2 + 3 + 4
[0, 1, 2, 3, 4].average // 2
[13, 2.4, 3, 4].varianceSample
```

- As you might guess `Substractable` define `-` operator, `Multiplicatable` define `*` operator, etc..., all defined in [Arithmosophi.swift](Arithmosophi.swift)

## Contents ##
- [Generic functions](#generic-functions)
- [CollectionType](#collectiontype)
  - [Average](#average)
  - [Median](#median)
  - [Variance](#variance)
  - [Standard deviation](#standard-deviation)
  - [Covariance](#covariance)
- [Object attributes](#object-attributes)
- [Logical operations](#logical-operations)
- [Complex](#complex)
- [Geometry](#geometry)
- [Setup](#setup)

## Generic functions ##
Take a look at `sumOf` function
```swift
func sumOf<T where T:Addable, T:Initializable>(input : [T]) -> T {
    return reduce(input, T()) {$0 + $1}
}
```
Array of `Int`, `Double` and even `String` could be passed as argument to this function. Any `Addable` objects.

No need to implement a function for `Double`, one for `Float`, one more for `Int`, etc...

*`sumOf` and `productOf` functions are available in [Arithmosophi.swift](Arithmosophi.swift)*


## CollectionType ##
This framework contains some useful extensions on `CollectionType`
```swift
[1, 2, 3, 4].sum //  1 + 2 + 3 + 4
[1, 2, 3, 4].product //  1 * 2 * 3 * 4

["a","b","c","d"].sum // "abcd" same as joinWithSeparator("")
[["a","b"],["c"],["d"]].sum // ["a","b","c","d"] same as flatMap{$0}
```

### Average ###
_with [MesosOros.swift](MesosOros.swift)_

Computes [arithmetic average/mean](http://en.wikipedia.org/wiki/Arithmetic_mean)
```swift
[1, 2, 3, 4].average //  (1 + 2 + 3 + 4) / 4
```

A type is `Averagable` if it can be dividable by an `Int` and define an operator to do that
```swift
func /(lhs: Self, rhs: Int) -> Self
```
All arithmetic type conform to this protocol and you can get an average for a `CollectionType`

P.S. You can conform to this protocol and `Addable` to make a custom average.

### Median ###
_with [MesosOros.swift](MesosOros.swift)_

Get the [median value](http://en.wikipedia.org/wiki/Median) from the array

- Returns the average of the two middle values if there is an even number of elements in the `CollectionType`.
```swift
[1, 11, 19, 4, -7].median // 4
```
- Returns the lower of the two middle values if there is an even number of elements in the `CollectionType`.
```swift
[1.0, 11, 19.5, 4, 12, -7].medianLow // 4
```
- Returns the higher of the two middle values if there is an even number of elements in the `CollectionType`.
```swift
[1, 11, 19, 4, 12, -7].medianHigh // 11
```

### Variance ###
_with [Sigma.swift](Sigma.swift)_

Computes [variance](http://en.wikipedia.org/wiki/Variance).

- [The sample variance](https://en.wikipedia.org/wiki/Variance#Sample_variance): Σ( (Element - average)^2 ) / (count - 1)

```swift
[1.0, 11, 19.5, 4, 12, -7].varianceSample
```
- [The population variance](https://en.wikipedia.org/wiki/Variance#Sample_variance): Σ( (Element - average)^2 ) / count

```swift
[1.0, 11, 19.5, 4, 12, -7].variancePopulation
```

### Standard deviation ###
_with [Sigma.swift](Sigma.swift)_

Computes [standard deviation](http://en.wikipedia.org/wiki/Standard_deviation).

- [sample based](https://en.wikipedia.org/wiki/Standard_deviation#Sample-based_statistics)
```swift
[1.0, 11, 19.5, 4, 12, -7].standardDeviationSample
```
- [population based](https://en.wikipedia.org/wiki/Standard_deviation#Population-based_statistics)
```swift
[[1.0, 11, 19.5, 4, 12, -7].standardDeviationPopulation
```

### Covariance ###
_with [Sigma.swift](Sigma.swift)_

Computes [covariance](http://en.wikipedia.org/wiki/Covariance) with another `CollectionType`

- [sample covariance](http://en.wikipedia.org/wiki/Sample_mean_and_sample_covariance)
```swift
[1, 2, 3.5, 3.7, 8, 12].covarianceSample([0.5, 1, 2.1, 3.4, 3.4, 4])
```
- population covariance
```swift
[1, 2, 3.5, 3.7, 8, 12].covariancePopulation([0.5, 1, 2.1, 3.4, 3.4, 4])
```

- [Pearson product-moment correlation coefficient](http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient)
```swift
[1, 2, 3.5, 3.7, 8, 12].pearson([0.5, 1, 2.1, 3.4, 3.4, 4])
```

## Complex ##
_with [Complex.swift](Complex.swift)_
`Complex` is a struct of two `ArithmeticType`, the real and the imaginary component

```swift
var complex = Complex(real: 12, imaginary: 9)
complex = 12 + 9.i
```
You can apply operation on it `(+, -, *, /, ++, --, -)`

```
result = complex + 8 // Complex(real: 20, imaginary: 9)

Complex(real: 12, imaginary: 9) + Complex(real: 8, imaginary: 1)
 // Complex(real: 20, imaginary: 10)
```

## Object attributes ##
The power of this simple arithmetic protocols are released when using operators

If we implement a box object containing a generic `T` value
```swift
class Box<T> {
	var value: T
}
```
we can define some operators on it, in a generic way, like we can do with `Equatable` or `Comparable`
```swift
func +=<T where T:Addable> (inout box: Box<T>, addend: T) {
    box.value = box.value + addend
}
func -=<T where T:Substractable> (inout box: Box<T>, addend: T) {
    box.value = box.value - addend
}
```
how to use this operator:
```swift
var myInt: Box<Int>(5)
myInt += 37
```

For a full example, see [Prephirence](https://github.com/phimage/Prephirences/blob/master/Prephirences/Preference.swift) file from [Prephirences](https://github.com/phimage/Prephirences) framework, or sample [Box.swift](Samples/Box.swift)

### Optional trick ###
For optional attribute you can use `Initializable` or any protocol which define a way to get a value
```swift
class Box<T> {
	var value: T?
}
func +=<T where T:Addable, T:Initializable> (inout box: Box<T>, addend: T) {
    box.value = (box.value ?? T()) + addend
}
```

## Logical operations  ##
[`LogicalOperationsType`](LogicalOperationsType.swift) is a missing protocol for `Bool` inspired from `BitwiseOperationsType` (or `IntegerArithmeticType`)

The purpose is the same, implement functions without knowing the base type

You can for instance implement your own [`Boolean` enum](Samples/Boolean.swift) and implement the protocol
```swift
enum Boolean: LogicalOperationsType {case True, False}
func && (left: Boolean, @autoclosure right:  () -> Boolean) -> Boolean {
    switch left {
    case .False: return .False
    case .True:  return right()
    }
}
...
```
then create only **one** operator on `Box` for `Bool`, `Boolean` and any `LogicalOperationsType`
```swift
func &&=<T:LogicalOperationsType> (inout box: Box<T>, @autoclosure right:  () -> TT) {
    box.value = box.value && right()
}
```

Take a look at a more complex enum [Optional](Samples/Optional.swift) which implement also `LogicalOperationsType`

## Geometry ##
with `Arithmos`(number) & `Statheros`(constant)

[`Arithmos`](Arithmos.swift) and [`Statheros`](Statheros.swift) add respectively functions and  mathematical constants for `Double`, `Float` and `CGFloat`, allowing to implement generic functions without taking care of type

```swift
func distance<T: Arithmos>(#x: T, y: T) -> T {
	return x.hypot(y)
}

func radiansFromDegrees<T where T: Multiplicable, T:Dividable, T: Arithmos, T: Statheros>(degrees: T) -> T {
	return degrees * T.PI / T(180.0)
}
```

Take a look at [Geometry.swift](Samples/Geometry.swift) for more examples

## Setup
### Using [cocoapods](http://cocoapods.org/) ##
```ruby
pod 'Arithmosophi'
```
Not interested in full framework ? install a subset with:
```ruby
pod 'Arithmosophi/Core' # Arithmosophi.swift
pod 'Arithmosophi/Logical' # LogicalOperationsType.swift
pod 'Arithmosophi/Complex' # Complex.swift
pod 'Arithmosophi/MesosOros' # MesosOros.swift
pod 'Arithmosophi/Arithmos' # Arithmos.swift
pod 'Arithmosophi/Sigma' # Sigma.swift
pod 'Arithmosophi/Statheros' # Statheros.swift

pod 'Arithmosophi/Samples' # Samples/*.swift (not installed by default)
```

*Add `use_frameworks!` to the end of the `Podfile`.*

#### Make your own framework dependent
In podspec file
```ruby
s.dependency 'Arithmosophi'
```
or define only wanted targets
```ruby
s.dependency 'Arithmosophi/Core'
s.dependency 'Arithmosophi/Logical'
```

## Using xcode ##
Drag files to your projects
