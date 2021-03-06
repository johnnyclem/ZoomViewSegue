//
//  main.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/10/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "QTouchposeApplication.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv,
                                 NSStringFromClass([QTouchposeApplication class]),
                                 NSStringFromClass([AppDelegate class]));
    }
}
