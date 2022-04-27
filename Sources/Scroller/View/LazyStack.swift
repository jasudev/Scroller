//
//  LazyStack.swift
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

struct LazyStack<Content>: View where Content: View {

    /// The scroll view's scrollable axis. The default axis is the vertical axis.
    private var axes: Axis.Set = .vertical

    /// The distance between adjacent subviews, or `nil` if you want the stack to choose a default
    /// distance for each pair of subviews.
    private var spacing: CGFloat?

    /// The view builder that creates the scrollable view, Pass a view that conforms to ScrollerContent.
    @ViewBuilder private var content: () -> Content

    /// Initializes `LazyStack`
    ///
    /// - Parameters:
    ///   - axes: The scroll view's scrollable axis. The default axis is the vertical axis.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you want the stack to choose a default
    ///     distance for each pair of subviews.
    ///   - content: The view builder that creates the scrollable view, Pass a view that conforms to ScrollerContent.
    public init(_ axes: Axis.Set = .vertical, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.axes = axes
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        if axes == .vertical {
            LazyVStack(alignment: .leading, spacing: spacing) {
                content()
            }
        } else {
            LazyHStack(alignment: .top, spacing: spacing) {
                content()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            LazyStack(.horizontal, spacing: 16) {
                Text("Horizontal 1")
                Text("Horizontal 2")
            }
            LazyStack(.vertical, spacing: 16) {
                Text("Vertical 1")
                Text("Vertical 2")
            }
        }
        .padding()
    }
}
