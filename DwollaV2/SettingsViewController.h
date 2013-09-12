//
//  SettingsViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/22/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollableView.h"
#import "TransactionReceiptView.h"
#import "CommandCenter.h"
#import "RoundedView.h"
#import "BoldTextView.h"

@class SettingsView;
@protocol SettingsViewDelegate <NSObject>

@optional
@required
-(void)logout;
-(void)closeSettings;

@end

@interface SettingsViewController : UIViewController <TransactionViewDelegate, ScrollableDelegate>
{
    RoundedView* top;
    UIView* middle;
    UIView* bottom;
    UIImageView* profile;
    BoldTextView* name;
    UITextView* _id;
    UIButton* transactionsb;
    UIButton* support;
    UIButton* forgot;
    UIButton* logout;
    UINavigationBar* nav;
    CommandCenter* command;
    ScrollableView* transactions_view;
    TransactionReceiptView* receipt_view;
    id<SettingsViewDelegate> delegate;
    BOOL isSet;
    CGRect screenBounds;
    int transactions;
    Transaction* previousTransaction;
    NSMutableArray* transArray;
    
    UIView* loading;
}

@property (retain) UINavigationBar* nav;
@property (nonatomic, retain) id<SettingsViewDelegate> delegate;

- (id)init;

-(void)addCommandCenter:(CommandCenter*)_command;

-(void)setUserInfo:(NSMutableArray*)info;

- (BOOL)userInfoSet;

-(void)showTransactions;

-(void)hideTransactions;

- (void)callSupport;

- (void)forgotPin;

- (void)logout;

- (void)backgroundTransactions:(NSMutableArray*)trans;

- (void)addTransactions:(NSMutableArray*)transactions;

- (void)slideIn;

- (void)slideOut;

- (void)payReceipt;

- (void)destory;

@end

