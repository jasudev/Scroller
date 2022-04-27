//
//  Scroller.swift
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

extension View {
    func frame(
        size: CGSize,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            width: size.width,
            height: size.height,
            alignment: alignment
        )
    }
}

public struct Scroller<Content, LastContent>: View where Content: View, LastContent: View {

    /// The scroll view's scrollable axis. The default axis is the vertical axis.
    private var axes: Axis.Set = .vertical

    /// A Boolean value that indicates whether the scroll
    /// view displays the scrollable component of the content offset, in a way
    /// suitable for the platform. The default value for this parameter is `true`.
    private var showsIndicators: Bool = true

    /// Bind the full scroll relative value. It is a value between 0 and 1.
    @Binding private var value: CGFloat

    /// The view builder that creates the scrollable view, Pass a view that conforms to ScrollerContent.
    @ViewBuilder private var content: () -> Content

    /// Pass the last view. default is a blank screen.
    private var lastContent: (() -> LastContent?)?

    public var body: some View {
        GeometryReader { proxy in
            ScrollView(axes, showsIndicators: showsIndicators) {
                ZStack {
                    LazyStack(axes) {
                        content().frame(size: proxy.size)
                        ZStack {
                            if let content = lastContent {
                                content()
                            } else {
                                Rectangle().fill(Color.clear)
                            }
                        }
                        .frame(size: proxy.size)
                    }
                    OffsetScrollView()
                }
            }
            .coordinateSpace(name: "Scroller")
            .modifier(ScrollContentModifier(axes, size: proxy.size, value: $value))
        }
    }
}

public extension Scroller where Content: View, LastContent == EmptyView {
    /// Initializes `Scroller`
    ///
    /// - Parameters:
    ///   - axes: The scroll view's scrollable axis. The default axis is the vertical axis.
    ///   - showsIndicators: A Boolean value that indicates whether the scroll
    ///     view displays the scrollable component of the content offset, in a way
    ///     suitable for the platform. The default value for this parameter is `true`.
    ///   - value: Bind the full scroll relative value. It is a value between 0 and 1.
    ///   - content: The view builder that creates the scrollable view, Pass a view that conforms to ScrollerContent.
    init(
        _ axes: Axis.Set,
        showsIndicators: Bool = true,
        value: Binding<CGFloat>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self._value = value
        self.content = content
    }
}

public extension Scroller where Content: View, LastContent: View {
    /// Initializes `Scroller`
    ///
    /// - Parameters:
    ///   - axes: The scroll view's scrollable axis. The default axis is the vertical axis.
    ///   - showsIndicators: A Boolean value that indicates whether the scroll
    ///     view displays the scrollable component of the content offset, in a way
    ///     suitable for the platform. The default value for this parameter is `true`.
    ///   - value: Bind the full scroll relative value. It is a value between 0 and 1.
    ///   - content: The view builder that creates the scrollable view, Pass a view that conforms to ScrollerContent.
    ///   - lastContent: Pass the last view. default is a blank screen.
    init(
        _ axes: Axis.Set,
        showsIndicators: Bool = true,
        value: Binding<CGFloat>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder lastContent: @escaping () -> LastContent
    ) {
        self.axes = axes
        self._value = value
        self.content = content
        self.lastContent = lastContent
    }
}
