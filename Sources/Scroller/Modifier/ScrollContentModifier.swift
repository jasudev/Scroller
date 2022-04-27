//
//  ScrollContentModifier.swift
//  Scroller
//
//  Created by jasu on 2022/02/02.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftUI

struct ScrollContentModifier: ViewModifier {

    /// The scroll view's scrollable axis. The default axis is the vertical axis.
    private var axes: Axis.Set = .vertical

    /// The size of the ScrollView.
    private let size: CGSize

    /// Bind the full scroll relative value. It is a value between 0 and 1.
    @Binding private var value: CGFloat

    /// Initializes `ScrollContentModifier`
    ///
    /// - Parameters:
    ///   - axes: The scroll view's scrollable axis. The default axis is the vertical axis.
    ///   - size: The size of the ScrollView.
    ///   - value: Bind the full scroll relative value. It is a value between 0 and 1.
    init(_ axes: Axis.Set, size: CGSize, value: Binding<CGFloat>) {
        self.axes = axes
        self.size = size
        self._value = value
    }

    func body(content: Content) -> some View {
        content
            .coordinateSpace(name: "Scroller")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                self.value = getValue(value)
            }
    }

    /// Method that returns the size and offset of the content from ScrollView.
    ///
    /// - Parameters:
    ///   - contentValue: The size and offset of the content.
    private func getValue(_ contentValue: ContentValue) -> CGFloat {
        var value: CGFloat = 0
        if axes == .vertical {
            value = -contentValue.offset.y / (contentValue.size.height - size.height)
        } else {
            value = -contentValue.offset.x / (contentValue.size.width - size.width)
        }
        return value.clamped(to: 0...1)
    }
}

/// The size and offset of the content.
struct ContentValue: Equatable {
    var offset: CGPoint = .zero
    var size: CGSize = .zero
}

/// The offset of the content.
struct ScrollOffsetKey: PreferenceKey {
    typealias Value = ContentValue
    static var defaultValue = ContentValue()
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

/// A view that passes the total size and offset of the content.
struct OffsetScrollView: View {
    let name: String = "Scroller"
    var body: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named(name)).origin
            Color.clear.preference(
                key: ScrollOffsetKey.self,
                value: ContentValue(offset: offset, size: proxy.size)
            )
        }
    }
}
