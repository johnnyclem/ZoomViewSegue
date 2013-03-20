//
//  ZoomSegue.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/10/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import "ZoomToTileSegue.h"
#import "UIImage+Screenshot.h"

@implementation ZoomToTileSegue

- (void)perform
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    // Get the view controllers.
    UIViewController *svc = (UIViewController *) self.sourceViewController;
    UIViewController *dvc = (UIViewController *) self.destinationViewController;
    
    // Grab a screen shot.
    UIImage *screenshot = [UIImage screenshotFromView:svc.view.window];
    
    // Create a UIImageView using the screen shot.
    UIImageView *screenshotView = [[UIImageView alloc] initWithImage:screenshot];
    
    // Convert from window coordinates to view coordinates and update frame.
    CGRect screenshotFrame = [svc.view convertRect:screenshotView.frame fromView:svc.view.window];
    screenshotView.frame = screenshotFrame;
    
    // Don't clip subviews
    [svc.view setClipsToBounds:NO];
    
    // Add the screenshot view.
    [svc.view addSubview:screenshotView];
    
    // Add the destination view.
    [svc.view addSubview:dvc.view];
    
    // Make sure the other views are in front of the navigation bar.
    [svc.navigationController.navigationBar.superview sendSubviewToBack:svc.navigationController.navigationBar];
    
    // Convert from window coordinates to view coordinates and update frame.
    CGRect destinationViewFrame = [svc.view convertRect:dvc.view.frame fromView:svc.view.window];
    dvc.view.frame = destinationViewFrame;
    
    // Start with the destination view at 1/4 scale and completely transparent.
    [dvc.view setTransform:CGAffineTransformMakeScale(0.25f, 0.25f)];
    [dvc.view setAlpha:0.0];
    
    [UIView animateWithDuration:0.1667f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [dvc.view setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
                         [dvc.view setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                         
                         // No longer need the screenshot view.
                         [screenshotView removeFromSuperview];
                         
                         // Destination view should no longer be part of the source
                         // view hierarchy so remove it.
                         [dvc.view removeFromSuperview];
                         
                         // Turn off the navigation bar.
                         [svc.navigationController setNavigationBarHidden:YES animated:NO];
                         
                         // Move the navigation bar back in front of other views.
                         [svc.navigationController.navigationBar.superview
                          bringSubviewToFront:svc.navigationController.navigationBar];
                         
                         // Push to the destination view controller.
                         [svc.navigationController pushViewController:dvc animated:NO];
                     }];
}

// *****************************************************************************
#pragma mark -                                            Private Helper Methods
// *****************************************************************************

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x - CGRectGetMidX(rect);
    newrect.origin.y = center.y - CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@end
