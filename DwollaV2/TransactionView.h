//
//  TransactionView.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "CommandCenter.h"
#import "BoldTextView.h"

@class TransactionView;
@protocol TransactionViewDelegate <NSObject>

@optional
@required
-(void)displayTransaction:(TransactionView*)transaction;

@end

@interface TransactionView : UIView
{
    UIImageView* bg;
    UIImageView* marker;
    UIImageView* arrowbg;
    UIImageView* profile;
    BoldTextView* name;
    UITextView* time;
    BoldTextView* total;
    UIImageView* totalbg;
    NSString* realDate;
    NSString* note;
    
    NSString* dwolla_id;
    CommandCenter* command;
    BOOL isSend;
    
    id <TransactionViewDelegate> delegate;
}

@property (nonatomic, retain) id <TransactionViewDelegate> delegate;

@property BOOL isSend;
@property (retain) NSString* note;

- (void)addCommandCenter:(CommandCenter*)_command;

- (void)addData:(Transaction*)transaction;

- (void)shiftView:(int)i;

- (UIImage*)profile;

- (void)setProfile:(UIImage*)image;

- (NSString*)name;

- (NSString*)time;

- (NSString*)total;

- (NSString*) dwolla_id;

- (void)AddImageInBackground;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)destroy;

@end