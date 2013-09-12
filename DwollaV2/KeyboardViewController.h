//
//  KeyboardViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/25/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinView.h"

@interface KeyboardViewController : UIViewController
{
    UIButton* one;
    UIButton* two;
    UIButton* three;
    UIButton* four;
    UIButton* five;
    UIButton* six;
    UIButton* seven;
    UIButton* eight;
    UIButton* nine;
    UIButton* zerozero;
    UIButton* zero;
    UIButton* del;
    
    UITextView* textview;
    PinView* pin;
    
    int mode;
    CGRect screenBounds;
}

- (void)addTextView:(UITextView*)_textview;

- (void)addPINView:(PinView*)_pinview;

- (void)appendOne;

- (void)appendTwo;

- (void)appendThree;

- (void)appendFour;

- (void)appendFive;

- (void)appendSix;

- (void)appendSeven;

- (void)appendEight;

- (void)appendNine;

- (void)appendZeroZero;

- (void)appendZero;

- (void)appendDelete;

- (void)cleanup;

- (void)cleanupDel;

- (void)pin:(int)length;

- (void)destroy;

- (void)slideIn;

- (void)slideInDeposit;

- (void)slideInRequest;

- (void)slideOut;

@end
