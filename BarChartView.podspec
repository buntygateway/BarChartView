#
#  Be sure to run `pod spec lint BarChartView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  #   Spec Metadata  ― #
  spec.platform     = :ios
  spec.ios.deployment_target = "12.0"
  spec.swift_version = "4.2"
  spec.name         = "BarChartView"
  spec.version      = "0.1.2"
  spec.summary      = "A horizontally scrollable and customizable bar chart view."
  spec.requires_arc = true

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = "A horizontally scrollable and customizable bar chart view. This libaray allows you to customize the bar chart elements, e.g. labels on x and y axis, bar width, bar gaps, different colors for bars, etc. Most important part is that it is horizontally scrollable to show more veritical bars instead of decreasing the bar width"
                   

  spec.homepage     = "https://github.com/buntygateway/BarChartView"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  #   Spec License   #
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  #  Author Metadata   #
  spec.author             = { "Bunty Nara" => "bunty.nara@thegatewaycorp.com" }

  #  Source Location ― #
  spec.source       = { :git => "https://github.com/buntygateway/BarChartView.git", :tag => "#{spec.version}" }


  #  Source Code  #
  spec.source_files  = "BarChartView/**/*.{swift}"
  
  #  Project Linking ― #
  spec.framework  = "UIKit"
  
end
