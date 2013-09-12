//
//  LightTextView.m
//  DwollaV2
//
//  Created by Nick Schulze on 6/21/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "LightTextView.h"

@implementation LightTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
{
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor DwollaDarkGray]];
        [self setFont:[UIFont fontWithName:@"GillSans-Light" size:12]];
        [self setText:@""];
        [self setUserInteractionEnabled:NO];
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

@end
