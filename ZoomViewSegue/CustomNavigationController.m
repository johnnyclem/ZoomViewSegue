//
//  CustomNavigationController.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/10/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import "CustomNavigationController.h"
#import "ZoomToTileSegue.h"
#import "ReturnFromTileSegue.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// *****************************************************************************
#pragma mark -                                         View Controller Lifecycle
// *****************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// *****************************************************************************
#pragma mark -                                          Storyboard Segue Methods
// *****************************************************************************

// Choose the unwind segue based on the identifier provided.
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController
                                      fromViewController:(UIViewController *)fromViewController
                                              identifier:(NSString *)identifier
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));

    UIStoryboardSegue *segue = nil;
    
    if ([@"ReturnFromTile" isEqualToString:identifier]) {
        // Allocate our custom unwind segue.
        segue = [[ReturnFromTileSegue alloc] initWithIdentifier:identifier
                                                         source:fromViewController
                                                    destination:toViewController];;
    } else {
        // Punt - let the system supply an unwind segue.
        segue = [super segueForUnwindingToViewController:toViewController
                                      fromViewController:fromViewController
                                              identifier:identifier];
    }
    
    return segue;
}

@end
