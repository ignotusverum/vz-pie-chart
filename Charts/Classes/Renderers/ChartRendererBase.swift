//
//  ChartRendererBase.swift
//  Charts
//
//  Created by Daniel Cohen Gindi on 3/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation
import CoreGraphics.CGBase

public class ChartRendererBase: NSObject
{
    /// the component that handles the drawing area of the chart and it's offsets
    public var viewPortHandler: ChartViewPortHandler!;
    
    /// the minimum value on the x-axis that should be plotted
    internal var _minX: Int = 0;
    
    /// the maximum value on the x-axis that should be plotted
    internal var _maxX: Int = 0;
    
    public override init()
    {
        super.init();
    }
    
    public init(viewPortHandler: ChartViewPortHandler)
    {
        super.init();
        self.viewPortHandler = viewPortHandler;
    }

    /// Returns true if the specified value fits in between the provided min and max bounds, false if not.
    internal func fitsBounds(val: Double, min: Double, max: Double) -> Bool
    {
        if (val < min || val > max)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
}
        