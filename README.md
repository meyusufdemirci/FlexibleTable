# FlexibleTable

[![CI Status](https://img.shields.io/travis/demirciy/FlexibleTable.svg?style=flat)](https://travis-ci.com/demirciy/FlexibleTable)
[![Version](https://img.shields.io/cocoapods/v/FlexibleTable.svg?style=flat)](https://cocoapods.org/pods/FlexibleTable)
[![License](https://img.shields.io/cocoapods/l/FlexibleTable.svg?style=flat)](https://cocoapods.org/pods/FlexibleTable)
[![Platform](https://img.shields.io/cocoapods/p/FlexibleTable.svg?style=flat)](https://cocoapods.org/pods/FlexibleTable)

FlexibleTable written in Swift. You can add customizable header view to table easily.

## Requirements

- iOS 10.0+
- Xcode 11.0+
- Swift 5.0+

## Installation

FlexibleTable is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FlexibleTable'
```

## Usage

```ruby
tableView.stickyHeader.view = YourUIView()
tableView.stickyHeader.height = 300
tableView.stickyHeader.minimumHeight = 100
```
![alt tag](https://media.giphy.com/media/lnaItG2BLVb7GHqcb6/giphy.gif)

If you want to add default mask
```ruby
tableView.stickyHeader.maskColor = UIColor.black.withAlphaComponent(0.7)
```
![alt tag](https://media.giphy.com/media/hQho07szThczKB1AgC/giphy.gif)

If you want to add your custom mask view instead of maskColor
```ruby
tableView.stickyHeader.maskView = YourMaskView()
```

FTDelegate Protocol
```ruby
func didMaskViewAlphaChange(alpha: CGFloat)
```

FTDelegate Closure
```ruby
var didMaskViewAlphaChange: ((CGFloat) -> Void)?
```

## Author

Yusuf Demirci, demirciy94@gmail.com
