//
//  SlipViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/22/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+DwollaColors.h"
#import "RoundedView.h"
#import "RoundedImageView.h"
#import "BoldTextView.h"
#import "LightTextView.h"

@class SlipView;
@protocol SlipViewDelegate <NSObject>

@optional
@required
-(void)doneWithTransfer;

@end

@interface SlipView : UIView
{
    RoundedView* top;
    RoundedImageView* profile;
    RoundedImageView* bank_img;
    UIImageView* arrow;
    BoldTextView* name;
    UIImageView* timebg;
    BoldTextView* time;
    BoldTextView* total;
    LightTextView* amount;
    UITextView* source;
    UITextView* bank;
    UIButton* done_button;
    
    id <SlipViewDelegate> delegate;
}

@property (nonatomic, retain) id <SlipViewDelegate> delegate;

- (void)completeTransfer;

- (void)setType:(NSString*)type;

- (void)setEverything:(NSString*)_amount source:(NSString*)_source profile:(UIImage*)_profile bank:(UIImage*)_bank;

- (void)slideIn;

- (void)slideOut;

- (void)destroy;

@end
