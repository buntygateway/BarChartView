# BarChartView
A horizontally scrollable and customizable bar chart view.

## Requirements

`BarChartView` works on iOS 12.0+. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* UIKit.framework

You will need the latest developer tools in order to build `BarChartView`. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate BarChartView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'BarChartView', :git => 'https://github.com/buntygateway/BarChartView.git'
```

## Usage

The main guideline you need to follow, is to create the instance of `BarChartView`, add to the viewController's view and call the show method passing the array of dictionaries. The keys must be `v1`, `v2` and `label` as shown below.

```swift
let barChartView = BarChartView(frame: frame)
self.view.addSubview(barChartView)
barChartView.show(arrData: [
    ["v1":10.0, "v2":20.0, "label": "Jan 1"],
    ["v1":50.0, "v2":20.0, "label": "Jan 2"],
    ["v1":30.0, "v2":20.0, "label": "Jan 3"],
    ["v1":20.0, "v2":20.0, "label": "Jan 4"],
    ["v1":40.0, "v2":80.0, "label": "Jan 5"],
    ["v1":30.0, "v2":40.0, "label": "Jan 6"],
    ["v1":20.0, "v2":20.0, "label": "Jan 7"],
    ["v1":40.0, "v2":80.0, "label": "Jan 8"],
    ["v1":30.0, "v2":40.0, "label": "Jan 9"],
    ["v1":10.0, "v2":20.0, "label": "Jan 10"]
])
```

## Cofiguration of chart view

You can configure the below optional properties of `BarChartView`

```swift
// bar colors configuration
barChartView.bottomColor = UIColor.init(red: 255/255.0, green: 162/255.0, blue: 23/255.0, alpha: 1)
barChartView.topColor = UIColor.init(red: 0/255.0, green: 153/255.0, blue: 255/255.0, alpha: 1)
barChartView.gridBGColor = UIColor(white: 240/255.0, alpha: 0.3)

// bar configuration
barChartView.topGap = 15.0
barChartView.barWidth = 25.0
barChartView.barGap = 14.0

// grid lines
barChartView.showGridLines = true
barChartView.gridLineColor = UIColor.lightGray

// x label configuration
barChartView.xLabelHeight = 30.0
barChartView.xLabelWidth = 28.0
barChartView.xLabelFont = UIFont(name: "Helvetica", size: 9)
barChartView.xLabelColor = UIColor.lightGray

// y label configuration
barChartView.yLabelHeight = 30.0
barChartView.yLabelWidth = 38.0
barChartView.yLabelGap = 12.0
barChartView.yLabelPrefix = "Rs."
barChartView.yLabelDecimalPlaces = 0
barChartView.yLabelFont = UIFont(name: "Helvetica", size: 9)
barChartView.yLabelColor = UIColor.lightGray

// animation configuration
barChartView.animateDuration = 0.5
barChartView.animateDelay = 0.1
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
