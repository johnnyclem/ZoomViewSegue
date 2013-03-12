//
//  TileViewController.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/10/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import "TileViewController.h"

@interface TileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tileLabel;
@end

@implementation TileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"[TileViewController viewDidLoad]");
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self updateTileLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"[TileViewController viewWillAppear:%@]", animated ? @"YES" : @"NO");
    
    // Make sure that the navigation bar is hidden.
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"[TileViewController viewDidAppear:%@]", animated ? @"YES" : @"NO");
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"[TileViewController viewWillDisappear:%@]", animated ? @"YES" : @"NO");
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"[TileViewController viewDidDisappear:%@]", animated ? @"YES" : @"NO");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTileLabel
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.tileName];
    NSRange fullRange = NSMakeRange(0, [self.tileName length]);
    
    UIColor *textColor = [UIColor whiteColor];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:fullRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:144.0f] range:fullRange];

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:fullRange];
    
    self.tileLabel.attributedText = attributedString;
}

@end
