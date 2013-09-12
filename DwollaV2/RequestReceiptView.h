//
//  RequestReceiptView.h
//  DwollaV2
//
//  Created by Nick Schulze on 6/4/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoldTextView.h"
#import "LightTextView.h"
#import "RoundedView.h"
#import "RoundedImageView.h"

@class RequestReceiptView;
@protocol RequestReceiptViewDelegate <NSObject>

@optional
@required
-(void)done;

@end

@interface RequestReceiptView : UIView
{
    RoundedView* top;
    RoundedImageView* profile;
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
    CGRect screenBounds;
    id<RequestReceiptViewDelegate> delegate;
}

@property (nonatomic, retain) id<RequestReceiptViewDelegate> delegate;

-(void)setEverything:(UIImage*)_profile name:(NSString*)_name amount:(NSString*)_amount time:(NSString*)_time dwolla_id:(NSString*)_dwolla;

-(NSString*)amount;

-(NSString*)name;

-(UIImage*)profile;

-(NSString*)dwolla_id;

-(void)done;

- (void)slideIn;

- (void)slideOut;
@end
