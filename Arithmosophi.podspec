Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "Arithmosophi"
  s.version      = "1.0.0"
  s.summary      = "A set of protocols for Arithmetic and Logic"
  s.description  = <<-DESC
                   Arithmosophi is a set of missing protocols that simplify
                   arithmetic and logicals operations on generic objects or functions.
                   DESC
  s.homepage     = "https://github.com/phimage/Arithmosophi"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "phimage" => "eric.marchand.n7@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/phimage/Arithmosophi.git", :tag => s.version }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.default_subspec = 'All'

  s.subspec "Core" do  |sp|
    sp.source_files = "Arithmosophi.swift"
  end

  s.subspec "Logical" do  |sp|
    sp.source_files = ['LogicalOperationsType.swift']
  end

  s.subspec "Arithmos" do  |sp|
    sp.source_files = ['Arithmos.swift']
  end

  s.subspec "Statheros" do  |sp|
    sp.source_files = ['Statheros.swift']
  end

  s.subspec "Samples" do  |sp|
    sp.source_files = "Samples/*.swift"
    sp.dependency 'Arithmosophi/All'
  end

  s.subspec "All" do  |sp|
    sp.dependency 'Arithmosophi/Core'
    sp.dependency 'Arithmosophi/Logical'
    sp.dependency 'Arithmosophi/Arithmos'
    sp.dependency 'Arithmosophi/Statheros'
  end

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.resource  = "logo-128x128.png"

end
