//: ## Arithmosophi
//: A set of protocols for Arithmetic, Statistics and Logical operations
import Arithmosophi //  1 + 2 + 3 + 4
//: ### Arithmosophi.swift
[1, 2, 3, 4].sum
[1, 2, 3, 4].product //  1 * 2 * 3 * 4
["a", "b", "c", "d"].sum // "abcd" same as joinWithSeparator("")
[["a", "b"], ["c"], ["d"]].sum // ["a","b","c","d"] same as flatMap{$0}
//: ### Arithmos.swift
//[abs(-2.0), floor(1.1), ceil(1.1), round(1.1), fract(1.1)]
[(-2.0).abs(), (1.1).floor(), (1.1).ceil(), (1.1).round(), (1.1).fract()]
fract(1.1)
//[sqrt(2.0), cbrt(2.0), pow(2.0, 0.5)]
[(2.0).sqrt(), (2.0).cbrt(), (2.0).pow(0.5)]

//[exp(1.0), exp2(10.0), log(1.0), log2(1024.0), log10(1000.0), log1p(1.0)]
[(1.0).exp(), (10.0).exp2(), (1.0).log(), (1024.0).log2(), (1000.0).log10(), (1.0).log1p()]
//[cos(1.0), sin(1.0), tan(1.0), hypot(3.0, 4.0), 4.0*atan2(1.0, 1.0)]
[(1.0).cos(), (1.0).sin(), (1.0).tan(), (3.0).hypot(4.0), 4.0*(1.0).atan2(1.0)]
//[cosh(1.0), sinh(1.0), tanh(1.0)]
[(1.0).cosh(), (1.0).sinh(), (1.0).tanh()]
//[asin(0.5), acos(0.1), atan(1.0)]
[(0.5).asin(), (0.1).acos(), (1.0).atan()]
[Double.random(4.0), Double.random(1.0, 2.0), Double.random(1.0...2.0)]
[(1.1).clamp(3.0), (1.1).clamp(2.0, 3.0), (1.1).clamp(2.0...3.0)]
//: ### LogicalOperationsType.swift
var truth: Bool = true
truth &&= false
truth
truth ||= true
truth

//: ### Statheros.swift
//[cos(Double.π_2), sin(Double.π_2), cos(Double.π), sin(Double.π)]
[(Double.π_2).cos(), (Double.π_2).sin(), (Double.π).cos(), (Double.π).sin()]
//[log(Double.e)]
(Double.e).log()
//: ### MesosOros.swift
[1, 2, 3, 4].average //  (1 + 2 + 3 + 4) / 4
[1, 11, 19, 4, -7].median // 4
[1.0, 11, 19.5, 4, 12, -7].medianLow // 4
[1, 11, 19, 4, 12, -7].medianHigh // 11
//: ### Sigma.swift
[1.0, 11, 19.5, 4, 12, -7].varianceSample
[1.0, 11, 19.5, 4, 12, -7].variancePopulation
[1.0, 11, 19.5, 4, 12, -7].standardDeviationSample
[1.0, 11, 19.5, 4, 12, -7].standardDeviationPopulation
[1.0, 11, 19.5, 4, 12, -7].skewness // or .moment.skewness
[1.0, 11, 19.5, 4, 12, -7].kurtosis // or .moment.kurtosis
[1, 2, 3.5, 3.7, 8, 12].covarianceSample([0.5, 1, 2.1, 3.4, 3.4, 4])
[1, 2, 3.5, 3.7, 8, 12].covariancePopulation([0.5, 1, 2.1, 3.4, 3.4, 4])
[1, 2, 3.5, 3.7, 8, 12].pearson([0.5, 1, 2.1, 3.4, 3.4, 4])
//: ### Complex.swift
let complex = Complex<Double>(real: 12.0, imaginary: 9.0)
complex.description
let result = complex + 8 // Complex(real: 20, imaginary: 9)
result.description
