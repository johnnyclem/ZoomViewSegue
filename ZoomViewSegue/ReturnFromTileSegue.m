//
//  ReturnFromTileSegue.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/11/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import "ReturnFromTileSegue.h"
#import "UIImage+Screenshot.h"

@implementation ReturnFromTileSegue

- (void)perform
{
    UIViewController *sourceViewController = (UIViewController *) self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *) self.destinationViewController;
    
    UIImage *sourceViewImage = [UIImage screenshotFromView:sourceViewController.view];
    UIImageView *tempView = [[UIImageView alloc] initWithImage:sourceViewImage];
    
    [destinationViewController.navigationController popToViewController:destinationViewController animated:NO];

    [destinationViewController.view addSubview:tempView];
    
    [tempView setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
    [tempView setAlpha:1.0];
    
    [UIView animateWithDuration:0.1667f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [tempView setTransform:CGAffineTransformMakeScale(0.25f, 0.25f)];
                         [tempView setAlpha:0.0];
                     }
                     completion:^(BOOL finished){
                         [tempView removeFromSuperview];
                     }];
}
@end
