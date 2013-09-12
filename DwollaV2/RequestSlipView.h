//
//  RequestSlipView.h
//  DwollaV2
//
//  Created by Nick Schulze on 6/4/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoldTextView.h"
#import "LightTextView.h"
#import "RoundedView.h"

@class RequestSlipView;
@protocol RequestSlipViewDelegate <NSObject>

@optional
@required
-(void)payRequest:(RequestSlipView*)request;
-(void)cancelRequest:(RequestSlipView*)request;

@end

@interface RequestSlipView : UIView
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
    UIButton* cancel;
    UIButton* send ;
    NSString* dwolla_id;
    CGRect screenBounds;
    id<RequestSlipViewDelegate> delegate;
}

@property (nonatomic, retain) id<RequestSlipViewDelegate> delegate;

-(void)setEverything:(UIImage*)_profile name:(NSString*)_name amount:(NSString*)_amount time:(NSString*)_time dwolla_id:(NSString*)_dwolla youRequested:(BOOL) youRequested;

-(NSString*)amount;

-(NSString*)name;

-(UIImage*)profile;

-(NSString*)dwolla_id;

-(NSString*)time;

-(void)complete;

- (void)cancel;

- (void)slideIn;

- (void)slideOut;

@end
