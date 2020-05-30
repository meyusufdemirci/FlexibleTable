# FlexibleTable

[![CI Status](https://img.shields.io/travis/demirciy/FlexibleTable.svg?style=flat)](https://travis-ci.com/demirciy/FlexibleTable)
[![Version](https://img.shields.io/cocoapods/v/FlexibleTable.svg?style=flat)](https://cocoapods.org/pods/FlexibleTable)
[![License](https://img.shields.io/cocoapods/l/FlexibleTable.svg?style=flat)](https://cocoapods.org/pods/FlexibleTable)
[![Platform](https://img.shields.io/cocoapods/p/FlexibleTable.svg?style=flat)](https://cocoapods.org/pods/FlexibleTable)

FlexibleTable written in Swift. You can add customizable header view to table easily.

![alt tag](https://media.giphy.com/media/dalGBGZ9TJRm6ZyQWr/giphy.gif)

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

## Author

Yusuf Demirci, demirciy94@gmail.com

## License

FlexibleTable is available under the MIT license. See the LICENSE file for more info.
