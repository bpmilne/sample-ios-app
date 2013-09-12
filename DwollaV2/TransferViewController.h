//
//  TransferViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "PinView.h"
#import "TransferConfirmView.h"
#import "SlipView.h"
#import "SourceView.h"
#import "CommandCenter.h"
#import "RoundedView.h"
#import "RoundedImageView.h"
#import "BoldTextView.h"
#import "LightTextView.h"

@class TransferView;
@protocol TransferViewDelegate <NSObject>

@optional
@required
-(void)closeTransfer;

@end

@interface TransferViewController : UIViewController <TransferConfirmViewDelegate, SlipViewDelegate, SourceViewDelegate>

{
    CommandCenter* command;
    
    RoundedView* top;
    RoundedView* header;
    RoundedView* header2;
    UIImageView* bank;
    RoundedImageView* profile;
    UIImageView* arrow;
    BoldTextView* transfer;
    LightTextView* total;
    UIButton* cont;
    UIButton* close;
    UIButton* confirm_b;
    
    KeyboardViewController* keyboard;
    PinView* pin;
    TransferConfirmView* confirm;
    SlipView* slip;
    SourceView* source;
    
    UITextView* transfer_source;
    RoundedView* pin_background;
    
    id <TransferViewDelegate> delegate;
    
    BOOL isDeposit;
    CGRect screenBounds;
}

@property (retain) id <TransferViewDelegate> delegate;

- (void)addCommandCenter:(CommandCenter*) _command;

- (void)getSources;

- (void)showSource;

- (void)showPin;

- (void)showConfirm;

- (void)hideTransfer;

- (void)showMain;

- (void)setAsDeposit;

- (void)setAsWithdraw;

- (void)slideIn;

- (void)slideOut;

- (void)destroy;

@end
