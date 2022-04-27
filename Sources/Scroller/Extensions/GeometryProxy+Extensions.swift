//
//  GeometryProxy+Extensions.swift
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

extension Comparable {
    @inlinable @inline(__always)
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        Swift.min(Swift.max(self, limits.lowerBound), limits.upperBound)
    }
}

public extension GeometryProxy {

    /// A method that returns a value relative to the scroll offset. It is a value between 0 and 1.
    ///
    /// - Parameters:
    ///   - axes: The scroll view's scrollable axis. The default axis is the vertical axis.
    func scrollerValue(_ axes: Axis.Set = .vertical) -> CGFloat {
        let origin = self.frame(in: .named("Scroller")).origin
        let value: CGFloat
        if axes == .vertical {
            value = -origin.y / self.size.height
        } else {
            value = -origin.x / self.size.width
        }
        return value.clamped(to: 0...1)
    }
}
