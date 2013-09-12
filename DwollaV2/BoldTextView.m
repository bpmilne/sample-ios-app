//
//  BoldTextView.m
//  DwollaV2
//
//  Created by Nick Schulze on 6/21/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "BoldTextView.h"

@implementation BoldTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUserInteractionEnabled:NO];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor DwollaDarkGray]];
        [self setFont:[UIFont fontWithName:@"GillSans-Bold" size:14]];
        [self setText:@""];
    }
    return self;
}

@end
