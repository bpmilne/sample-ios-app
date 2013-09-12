//
//  ReceiptViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+DwollaColors.h"
#import "RoundedView.h"
#import "RoundedImageView.h"
#import "BoldTextView.h"
#import "LightTextView.h"
#import <Social/Social.h>


@interface ReceiptView : UIView
{
    RoundedView* top;
    RoundedImageView* profile;
    BoldTextView* name;
    UIImageView* timebg;
    BoldTextView* time;
    BoldTextView* total;
    LightTextView* amount;
    UIButton* note_button;
    UITextView* note;
}

-(void)setEverything:(UIImage*)_profile name:(NSString*)_name amount:(NSString*)_amount note:(NSString*)_note type:(NSString*)_type;

- (void)slideIn;

- (void)slideOut;

@end
