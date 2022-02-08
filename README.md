# **Scroller**
You can animate in individual views based on scroll position. Developed with SwiftUI. This library supports iOS/macOS.

[![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS-blue?style=flat-square)](https://developer.apple.com/macOS)
[![iOS](https://img.shields.io/badge/iOS-14.0-blue.svg)](https://developer.apple.com/iOS)
[![macOS](https://img.shields.io/badge/macOS-11.0-blue.svg)](https://developer.apple.com/macOS)
[![instagram](https://img.shields.io/badge/instagram-@dev.fabula-orange.svg?style=flat-square)](https://www.instagram.com/dev.fabula)
[![SPM](https://img.shields.io/badge/SPM-compatible-red?style=flat-square)](https://developer.apple.com/documentation/swift_packages/package/)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)  

## Screenshot
|Example|Vertical|Horizontal|
|:---:|:---:|:---:|
|<img src="Markdown/Scroller.gif">|<img src="Markdown/ScrollerVertical.gif">|<img src="Markdown/ScrollerHorizontal.gif">|

## Example
[https://fabulaapp.page.link/222](https://fabulaapp.page.link/222)
[https://fabulaapp.page.link/223](https://fabulaapp.page.link/223)

## Usages
1. Scroller
    ```swift
    Scroller(.vertical, value: $valueV) {
        ForEach(0...5, id: \.self) { index in
            GeometryReader { proxy in
                ScrollerVContent(value: proxy.scrollerValue(.vertical))
            }
        }
    } lastContent: {
        Rectangle()
            .fill(Color.blue)
            .overlay(Text("LastView"))
            .foregroundColor(Color.white)
    }
    ```

2. Each view only needs to conform to the ScrollerContent protocol.
    ```swift
    struct ScrollerVContent: ScrollerContent {
    
        /// Bind each view's scroll-relative value. It is a value between 0 and 1.
        var value: CGFloat = 0
        
        var body: some View {
            GeometryReader { proxy in
                ScrollerInfoView(axes: .vertical, value: value, proxy: proxy)
                    .offset(y: proxy.size.height * value)
                    .padding(10)
                Rectangle().fill(Color.blue)
                    .frame(width: proxy.size.width * value, height: 5)
                    .offset(y: proxy.size.height * value)
            }
            .background(Color.orange.opacity(1.0 - value))
        }
    }
    ```

## Contact
instagram : [@dev.fabula](https://www.instagram.com/dev.fabula)  
email : [dev.fabula@gmail.com](mailto:dev.fabula@gmail.com)

## License
Scroller is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
