//
//  RoundedView.m
//  DwollaV2
//
//  Created by Nick Schulze on 6/21/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 3.0;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
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
