//
//  ConfirmViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/20/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommandCenter.h"
#import "UIColor+DwollaColors.h"
#import "RoundedView.h"
#import "RoundedImageView.h"
#import "BoldTextView.h"
#import "LightTextView.h"

@class ConfirmView;
@protocol ConfirmViewDelegate <NSObject>

@optional
@required
-(void)detailReset;
-(void)backToPin;
-(void)note;
@end

@interface ConfirmView : UIView
{
    RoundedView* top;
    UIImageView* topbg;
    RoundedImageView* profile;
    BoldTextView* name;
    BoldTextView* total;
    LightTextView* amount;
    UIButton* note_button;
    UITextView* note;
    UIButton* complete;
    
    NSString* dwolla_id;
    NSString* pin;
    
    CommandCenter* command;
    id <ConfirmViewDelegate> delegate;
    BOOL isSend;
}

@property (nonatomic, retain) id<ConfirmViewDelegate> delegate;

- (void)addCommandCenter:(CommandCenter*)_command;

- (void)setEverything:(UIImage*)image name:(NSString*)name total:(NSString*)amount dwolla_id:(NSString*)d_id pin:_pin note:(NSString*)_note;

- (void)receipt;

- (void)setAsRequest;

- (void)setAsSend;

- (void)slideIn;

- (void)slideOut;

- (void)reset;

- (void)note;

- (void)setNote:(NSString*)string;

-(void)destroy;
@end
