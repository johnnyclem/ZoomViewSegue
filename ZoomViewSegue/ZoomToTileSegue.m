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

- (void)perform
{
    UIViewController *sourceViewController = (UIViewController *) self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *) self.destinationViewController;
    
    UIImage *sourceViewImage = [UIImage screenshotFromView:sourceViewController.view];
    UIImageView *tempView = [[UIImageView alloc] initWithImage:sourceViewImage];
    
    [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];

    UIView *actualDestinationView = destinationViewController.view;
    destinationViewController.view = tempView;

    CGRect frame = actualDestinationView.frame;
    frame.origin.x = 0.0f;
    frame.origin.y = 0.0f;
    actualDestinationView.frame = frame;
    
    [actualDestinationView setTransform:CGAffineTransformMakeScale(0.25f, 0.25f)];
    [actualDestinationView setAlpha:0.0];
    
    [destinationViewController.view addSubview:actualDestinationView];
    
    [UIView animateWithDuration:0.1667f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [actualDestinationView setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
                         [actualDestinationView setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                         destinationViewController.view = actualDestinationView;
                     }];
}

@end
