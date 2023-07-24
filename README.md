<p align="center">
    <img src="https://user-images.githubusercontent.com/6216959/156736940-92a9855c-11f8-43d1-9675-1060ba93ac16.png" width="100" height="100"/>
    <h1 align="center">SimultaneouslyScrollView</h1>
    <p align="center">Simultaneously scrolling <code>ScrollView</code>s with <code>SwiftUI</code> support</p>
</p>
<br />

[![Build](https://github.com/stonko1994/SimultaneouslyScrollView/actions/workflows/build.yml/badge.svg)](https://github.com/stonko1994/SimultaneouslyScrollView/actions/workflows/build.yml)
[![SwiftLint](https://github.com/stonko1994/SimultaneouslyScrollView/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/stonko1994/SimultaneouslyScrollView/actions/workflows/swiftlint.yml)

- [Installation](#installation)
    - [Swift Package Manager](#using-swift-package-manager)
- [Usage](#usage)
    - [SwiftUI support](#swiftui-support)
- [Example](#example)

## Installation
### Using [Swift Package Manager](https://swift.org/package-manager/)
[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift frameworks. It integrates with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

#### Using Xcode
To integrate using Xcode 13, open your Project file and specify it in `Project > Package Dependencies` using the following URL:

```
https://github.com/stonko1994/SimultaneouslyScrollView.git
```

## Usage
```swift
import SimultaneouslyScrollView
```

### Synchronize multiple `UIScrollView`s
1) Create an `SimultaneouslyScrollViewHandler` instance by using the factory method and the create function:
    ```swift
    let simultaneouslyScrollViewHandler = SimultaneouslyScrollViewHandlerFactory.create()
    ```
1) Register `UIScrollViews` that should be synchronized:
    ```swift
    simultaneouslyScrollViewHandler.register(scrollView: scrollView)
    ```

### SwiftUI support
To enable simultaneously scrolling in `SwiftUI` we need to utilize another library that allows access to the underlying `UIScrollView` for a `SwiftUI.ScrollView`.

[SwiftUI-Introspect](https://github.com/siteline/SwiftUI-Introspect) 🚀

#### Synchronize multiple `ScrollView`s
1) Follow the installataion steps from [SwiftUI-Introspect](https://github.com/siteline/SwiftUI-Introspect)
    ```
    Recommended is to use version 0.10.0 or higher.
    ```
1) Import `Introspect` in addition to `SimultaneouslyScrollView`
    ```swift
    import SimultaneouslyScrollView
    import SwiftUIIntrospect
    ```
1) Access the `UIScrollView` from your `ScrollView` and register it to the `SimultaneouslyScrollViewHandler`.
    ```swift
    ScrollView {
        ...
    }
    .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17)) {
        viewModel.simultaneouslyScrollViewHandler.register(scrollView: $0)
    }
    ```
1) That's it 🥳🎉

    I recommend storing the `simultaneouslyScrollViewHandler` inside some view-model. E.g. an `@ObservedObject` or a `@StateObject`.

#### How it works
`SwiftUI` doesn't provide any API to specify the `contentOffset` for `ScrollViews`. Therefore we need to access the underlying `UIKit` element and set the `contentOffset` there. This is where [SwiftUI-Introspect](https://github.com/siteline/SwiftUI-Introspect) comes in handy by providing access to the `UIKit` elements.

As every redraw of the `View` creates a new `ScrollView` and a new `UIScrollView` instance, it is important not to store strong references of the registered `UIScrollView`s. The `SimultaneouslyScrollViewHandler` manages this using a custom implementation using the `WeakObjectStore`.

When a `ScrollView` is scrolled by the user, the `SimultaneouslyScrollViewHandler` gets notified about this via the `UIScrollViewDelegate`. When this happens, the `contentOffset` of every other registered `UIScrollView` will be adapted to the new `contentOffset` of the currently scrolled `UIScrollView`.

## Example
I use this package in one of my own Apps that is currently in the Appstore. So there shouldn't be any issues using this in any production code except the possibility that new SwiftUI versions could break [SwiftUI-Introspect](https://github.com/siteline/SwiftUI-Introspect).

> Please note that this introspection method might break in future SwiftUI releases. Future implementations might not use the same hierarchy, or might not use UIKit elements that are being looked for. Though the library is unlikely to crash, the .introspect() method will not be called in those cases.

<p align="center">
    <img src="https://user-images.githubusercontent.com/6216959/156744968-bf4ea285-36c6-47c7-b37a-9ae5ada9a487.gif" width="600" height="419"/>
    <p align="center">
        <small align="center">Download <a href="https://apps.apple.com/us/app/scoretastic/id1510107568">Scoretastic</a> 🥳</small>
    </p>
</p>

---

<a href="https://www.buymeacoffee.com/davidsteinacher" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/yellow_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
