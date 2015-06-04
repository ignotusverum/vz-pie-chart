//
//  Utils.swift
//  Charts
//
//  Created by Daniel Cohen Gindi on 23/2/15.

//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation
import UIKit
import Darwin;

internal class ChartUtils
{
    internal struct Math
    {
        internal static let FDEG2RAD = CGFloat(M_PI / 180.0);
        internal static let FRAD2DEG = CGFloat(180.0 / M_PI);
        internal static let DEG2RAD = M_PI / 180.0;
        internal static let RAD2DEG = 180.0 / M_PI;
    };
    
    internal class func roundToNextSignificant(#number: Double) -> Double
    {
        if (isinf(number) || isnan(number) || number == 0)
        {
            return number;
        }
        
        let d = ceil(log10(number < 0.0 ? -number : number));
        let pw = 1 - Int(d);
        let magnitude = pow(Double(10.0), Double(pw));
        let shifted = round(number * magnitude);
        return shifted / magnitude;
    }
    
    internal class func decimals(number: Double) -> Int
    {
        if (number == 0.0)
        {
            return 0;
        }
        
        var i = roundToNextSignificant(number: Double(number));
        return Int(ceil(-log10(i))) + 2;
    }
    
    internal class func nextUp(number: Double) -> Double
    {
        if (isinf(number) || isnan(number))
        {
            return number;
        }
        else
        {
            return number + DBL_EPSILON;
        }
    }

    
    
    
    /// Calculates the position around a center point, depending on the distance from the center, and the angle of the position around the center.
    internal class func getPosition(#center: CGPoint, dist: CGFloat, angle: CGFloat) -> CGPoint
    {
        return CGPoint(
            x: center.x + dist * cos(angle * Math.FDEG2RAD),
            y: center.y + dist * sin(angle * Math.FDEG2RAD)
        );
    }
    
    internal class func drawText(#context: CGContext, text: String, var point: CGPoint, align: NSTextAlignment, attributes: [NSObject : AnyObject]?)
    {
        if (align == .Center)
        {
            point.x -= text.sizeWithAttributes(attributes).width / 2.0;
        }
        else if (align == .Right)
        {
            point.x -= text.sizeWithAttributes(attributes).width;
        }
        
        UIGraphicsPushContext(context);
        (text as NSString).drawAtPoint(point, withAttributes: attributes);
        UIGraphicsPopContext();
    }
    
    internal class func drawMultilineText(#context: CGContext, text: String, var knownTextSize: CGSize, point: CGPoint, align: NSTextAlignment, attributes: [NSObject : AnyObject]?, constrainedToSize: CGSize)
    {
        var rect = CGRect(origin: CGPoint(), size: knownTextSize);
        rect.origin.x += point.x;
        rect.origin.y += point.y;
        
        if (align == .Center)
        {
            rect.origin.x -= rect.size.width / 2.0;
        }
        else if (align == .Right)
        {
            rect.origin.x -= rect.size.width;
        }
        
        UIGraphicsPushContext(context);
        (text as NSString).drawWithRect(rect, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil);
        UIGraphicsPopContext();
    }
    
    internal class func drawMultilineText(#context: CGContext, text: String, point: CGPoint, align: NSTextAlignment, attributes: [NSObject : AnyObject]?, constrainedToSize: CGSize)
    {
        var rect = text.boundingRectWithSize(constrainedToSize, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil);
        drawMultilineText(context: context, text: text, knownTextSize: rect.size, point: point, align: align, attributes: attributes, constrainedToSize: constrainedToSize);
    }
    
    /// returns an angle between 0.0 < 360.0 (not less than zero, less than 360)
    internal class func normalizedAngleFromAngle(var angle: CGFloat) -> CGFloat
    {
        while (angle < 0.0)
        {
            angle += 360.0;
        }
        
        return angle % 360.0;
    }
    
    
    /// MARK: - Bridging functions
    
    internal class func bridgedObjCGetUIColorArray (swift array: [UIColor?]) -> [NSObject]
    {
        var newArray = [NSObject]();
        for val in array
        {
            if (val == nil)
            {
                newArray.append(NSNull());
            }
            else
            {
                newArray.append(val!);
            }
        }
        return newArray;
    }
    
    internal class func bridgedObjCGetUIColorArray (objc array: [NSObject]) -> [UIColor?]
    {
        var newArray = [UIColor?]();
        for object in array
        {
            newArray.append(object as? UIColor)
        }
        return newArray;
    }
    
    internal class func bridgedObjCGetStringArray (swift array: [String?]) -> [NSObject]
    {
        var newArray = [NSObject]();
        for val in array
        {
            if (val == nil)
            {
                newArray.append(NSNull());
            }
            else
            {
                newArray.append(val!);
            }
        }
        return newArray;
    }
    
    internal class func bridgedObjCGetStringArray (objc array: [NSObject]) -> [String?]
    {
        var newArray = [String?]();
        for object in array
        {
            newArray.append(object as? String)
        }
        return newArray;
    }
}