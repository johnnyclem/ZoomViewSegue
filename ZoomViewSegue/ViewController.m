//
//  ViewController.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/10/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import "ViewController.h"
#import "TileCell.h"
#import "TileViewController.h"
#import "ZoomToTileSegue.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"[ViewController viewWillAppear:%@]", animated ? @"YES" : @"NO");
    
    // Make sure that the navigation bar is visible.
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"[ViewController viewDidAppear:%@]", animated ? @"YES" : @"NO");
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"[ViewController viewWillDisappear:%@]", animated ? @"YES" : @"NO");
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"[ViewController viewDidDisappear:%@]", animated ? @"YES" : @"NO");
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TileCell *cell = (TileCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Tile" forIndexPath:indexPath];
    [cell updateDisplayWithIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ZoomToTile"]) {

        // Determine which item is currently selected.
        NSArray *selectedItems = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *selectedItem = [selectedItems objectAtIndex:0];

        // Check if the expected type of view controller is the destination of the segue.
        if ([[segue destinationViewController] isKindOfClass:[TileViewController class]]) {

            // Get access to the destination view controller.
            TileViewController *vc = (TileViewController *)[segue destinationViewController];
            
            NSString *message = nil;
            
            // Set the message text if a cell is currently selected.
            if (selectedItem != nil) {
                message = [NSString stringWithFormat:@"%d", [selectedItem row]];
            } else {
                message = @"??";
            }
            
            // Pass the message into the destination view controller.
            [vc setTileName:message];
            
            // Get the selected cell so we can pull the background color.
            UICollectionViewCell *selectedCell = [self.collectionView cellForItemAtIndexPath:selectedItem];
            if ([selectedCell isKindOfClass:[TileCell class]]) {
                TileCell *tileCell = (TileCell *)selectedCell;
                [vc.view setBackgroundColor:[tileCell backgroundColor]];
            } else {
                [vc.view setBackgroundColor:[UIColor redColor]];
            }
        } else {
            NSLog(@"Unrecognized destination view controller class.");
        }
    }
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    // Make sure the unwind segue is coming from the correct type of view controller
    // and that this view controller actually has a selector for the unwind action.
    if ([fromViewController isKindOfClass:[TileViewController class]] && [self respondsToSelector:action]) {
        return YES;
    }
    
    // Hand off to the super class since we can't perform the unwind segue
    // in this view controller.
    return [super canPerformUnwindSegueAction:action fromViewController:fromViewController withSender:sender];
}

- (IBAction)unwindFromTile:(UIStoryboardSegue *)segue
{
    // This is where you have access to values that were set or updated
    // in the source view controller.
    if ([[segue sourceViewController] isKindOfClass:[TileViewController class]]) {
        TileViewController *vc = (TileViewController *)[segue sourceViewController];
        NSString *tileName = [vc tileName];
        NSLog(@"Unwind from TileViewController, tileName = '%@'", tileName);
    }
}

@end
