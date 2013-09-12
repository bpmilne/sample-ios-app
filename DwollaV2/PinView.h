//
//  PinViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+DwollaColors.h"

@interface PinView : UIView
{
    UIView* top;
    
    NSMutableArray* pinviews;
    
    UITextView* pin;
}

- (UITextView*)textview;

- (void)setPINHidden:(int)i;

- (void)setPINActive:(int)i;

- (void)setPINWaiting:(int)i;

- (NSString*)getPIN;

- (void)reset;

- (void)revert;

- (void)destroy;

- (void)slideDown;

- (void)slideDeposit;



@end

