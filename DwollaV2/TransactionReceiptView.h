//
//  TransactionReceiptView.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedView.h"
#import "BoldTextView.h"
#import "LightTextView.h"

@class TransactionReceiptView;
@protocol TransactionReceiptViewDelegate <NSObject>

@optional
@required
-(void)repayTransaction:(TransactionReceiptView*)transaction;
-(void)requestTransaction:(TransactionReceiptView*)transaction;

@end

@interface TransactionReceiptView : UIView
{
    RoundedView* top;
    UIImageView* profile;
    BoldTextView* name;
    UIImageView* timebg;
    BoldTextView* time;
    BoldTextView* total;
    LightTextView* amount;
    UIButton* note_button;
    UITextView* note;
    UIButton* request;
    UIButton* send ;
    NSString* dwolla_id;
    id<TransactionReceiptViewDelegate> delegate;
    UINavigationBar* nav;
    CGRect screenBounds;
}

@property (nonatomic, retain) id<TransactionReceiptViewDelegate> delegate;

-(void)setEverything:(UIImage*)_profile name:(NSString*)_name amount:(NSString*)_amount time:(NSString*)_time dwolla_id:(NSString*)_dwolla isSend:(BOOL)isSend note:(NSString*)_note;

-(NSString*)amount;

-(NSString*)name;

-(UIImage*)profile;

-(NSString*)dwolla_id;

-(void)send;

-(void)request;

- (void)slideIn;

- (void)slideOut;

@end
