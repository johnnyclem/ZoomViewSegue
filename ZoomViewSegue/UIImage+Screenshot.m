//
//  UIImage+Screenshot.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/11/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIImage+Screenshot.h"

@implementation UIImage (Screenshot)

// Return a image of the given view.
+ (UIImage *)screenshotFromView:(UIView *)aView
{
    // Create a new context to draw an image the size of the view.
    UIGraphicsBeginImageContext(aView.bounds.size);
    
    // Draw the view's layer into the newly created context.
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // Extract the image from the context.
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Done with the current context.
    UIGraphicsEndImageContext();
    
    return image;
}

@end
