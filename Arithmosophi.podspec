Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "Arithmosophi"
  s.version      = "4.3.0"
  s.summary      = "A set of protocols for Arithmetic and Logic"
  s.description  = <<-DESC
                   Arithmosophi is a set of missing protocols that simplify
                   arithmetic, statistics and logicals operations on generic objects or functions.
                   DESC
  s.homepage     = "https://github.com/phimage/Arithmosophi"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "phimage" => "eric.marchand.n7@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/phimage/Arithmosophi.git", :tag => s.version }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.default_subspec = 'All'

  s.subspec "Core" do  |sp|
    sp.source_files = "Sources/Arithmosophi.swift"
  end

  s.subspec "Logical" do  |sp|
    sp.source_files = ['Sources/LogicalOperationsType.swift']
  end

  s.subspec "Arithmos" do  |sp|
    sp.source_files = ['Sources/Arithmos.swift']
  end

  s.subspec "Statheros" do  |sp|
    sp.source_files = ['Sources/Statheros.swift']
  end

  s.subspec "Complex" do  |sp|
    sp.source_files = "Sources/Complex.swift"
    sp.dependency 'Arithmosophi/Core'
    sp.dependency 'Arithmosophi/Arithmos'
  end

  s.subspec "MesosOros" do  |sp|
    sp.source_files = ['Sources/MesosOros.swift']
    sp.dependency 'Arithmosophi/Core'
  end

  s.subspec "Sigma" do  |sp|
    sp.source_files = ['Sources/Sigma.swift']
    sp.dependency 'Arithmosophi/MesosOros'
    sp.dependency 'Arithmosophi/Arithmos'
  end

  s.subspec "Samples" do  |sp|
    sp.source_files = "Samples/*.swift"
    sp.dependency 'Arithmosophi/All'
  end

  s.subspec "All" do  |sp|
    sp.dependency 'Arithmosophi/Core'
    sp.dependency 'Arithmosophi/Logical'
    sp.dependency 'Arithmosophi/Arithmos'
    sp.dependency 'Arithmosophi/Complex'
    sp.dependency 'Arithmosophi/Statheros'
    sp.dependency 'Arithmosophi/MesosOros'
    sp.dependency 'Arithmosophi/Sigma'
  end
 
end
