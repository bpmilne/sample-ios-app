//
//  ScrollableView.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionView.h"
#import "RequestView.h"
#import "UIColor+DwollaColors.h"
#import "CommandCenter.h"

@class ScrollableView;
@protocol ScrollableDelegate <NSObject>

@optional
@required
-(void)loadTransactions;

@end

@interface ScrollableView : UIView <UIScrollViewDelegate>
{
    UIScrollView* scrollable;
    CommandCenter* command;
    CGRect screenBounds;
    UINavigationBar* nav;
    id <ScrollableDelegate> delegate;
}

@property id <ScrollableDelegate> delegate;

- (id)init;

-(void)addCommandCenter:(CommandCenter*)_command;

- (void)addTransactions:(NSMutableArray*) transactions withDelegate:(id) del;

- (void)addRequests:(NSMutableArray*) requests withDelegate:(id) del;

- (void)reset;

- (void)slideIn;

- (void)slideOut;

- (void)insertTransactions:(NSMutableArray*) transactions withDelegate:(id) del offset:(int)offset;

- (void)destroyTransactions;

@end