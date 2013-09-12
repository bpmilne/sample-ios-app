//
//  TransferConfirmView.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoldTextView.h"
#import "LightTextView.h"
#import "RoundedView.h"
#import "RoundedImageView.h"

@class TransferConfirmView;
@protocol TransferConfirmViewDelegate <NSObject>

@optional
@required
-(void)completeTransfer;
-(void)hideTransfer;

@end

@interface TransferConfirmView : UIView
{
    RoundedView* top;
    RoundedImageView* profile;
    UIImageView* bank_img;
    UIImageView* arrow;
    BoldTextView* title;
    LightTextView* amount;
    UITextView* source;
    UITextView* bank;
    UIButton* done_button;
    
    id <TransferConfirmViewDelegate> delegate;
    BOOL isDeposit;
}

@property (nonatomic, retain) id <TransferConfirmViewDelegate> delegate;

- (void)setEverything:(NSString*)_amount source:(NSString*)_source profile:(UIImage*)_profile bank:(UIImage*)_bank;

- (void)setAsDeposit;

- (void)setAsWithdrawal;

- (void)destroy;

- (void)slideIn;

- (void)slideOut;

@end
