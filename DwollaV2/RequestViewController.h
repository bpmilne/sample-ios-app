//
//  RequestViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 6/4/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "KeyboardViewController.h"
#import "PinView.h"
#import "RequestSlipView.h"
#import "RequestReceiptView.h"
#import "RequestView.h"
#import "CommandCenter.h"
#import "UIColor+DwollaColors.h"

@class RequestViewController;
@protocol RequestViewControllerDelegate <NSObject>

@optional
@required
-(void)finished;

@end

@interface RequestViewController : UIViewController <RequestSlipViewDelegate, RequestReceiptViewDelegate>
{
    KeyboardViewController* keyboard;
    PinView* pin;
    RequestSlipView* slip;
    RequestReceiptView* receipt;
    UIView* pin_background;
    UIButton* confirm_b;
    id<RequestViewControllerDelegate> delegate;
    CommandCenter* command;
    CGRect screenBounds;
}

@property (nonatomic, retain) id<RequestViewControllerDelegate> delegate;

- (void)addCommandCenter:(CommandCenter*)_command;

- (void)addRequest:(RequestView*)request;

- (void)showReceipt;

- (void)slideIn;

- (void)slideOut;

- (void)cancel;

@end
