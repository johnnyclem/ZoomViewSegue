//
//  TileCell.m
//  ZoomViewSegue
//
//  Created by Bennett Smith on 3/10/13.
//  Copyright (c) 2013 iOS Weekend. All rights reserved.
//

#import "TileCell.h"
#include <stdlib.h>

@interface TileCell()
@property (weak, nonatomic) IBOutlet UILabel *tileLabel;
@end

@implementation TileCell

- (NSArray *)initializeBackgroundColors
{
    
    NSMutableArray *backgroundColors = [[NSMutableArray alloc] init];
    for (CGFloat whiteValue = 0.125; whiteValue < 1.0; whiteValue += 0.125) {
        [backgroundColors addObject:[UIColor colorWithWhite:whiteValue alpha:1.0]];
    }
    return backgroundColors;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)updateDisplayWithIndexPath:(NSIndexPath *)indexPath
{
    static NSArray *backgroundColors = nil;
    
    if (backgroundColors == nil) {
        backgroundColors = [self initializeBackgroundColors];
    }
    
    NSString *message = [NSString stringWithFormat:@"%d", [indexPath row]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
    NSRange fullRange = NSMakeRange(0, [message length]);
    
    UIColor *textColor = [UIColor whiteColor];

    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:fullRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:76.0f] range:fullRange];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:fullRange];

    self.tileLabel.attributedText = attributedString;
    
    // Pick a random background color
    CGFloat findex = (arc4random() % [backgroundColors count]);
    NSUInteger index = (NSUInteger)findex;
    
    UIColor *backgroundColor = (UIColor *)[backgroundColors objectAtIndex:index];
    [self setBackgroundColor:backgroundColor];
    
}

@end
