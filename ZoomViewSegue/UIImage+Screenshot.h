//
//  UIImage+Screenshot.h
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/11/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Screenshot)

// Return a image of the given view.
+ (UIImage *)screenshotFromView:(UIView *)aView;

@end
