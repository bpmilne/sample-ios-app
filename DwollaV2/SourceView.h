//
//  SourceView.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/23/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Source.h"
#import "UIColor+DwollaColors.h"
#import "RoundedView.h"
#import "BoldTextView.h"

@class SourceView;
@protocol SourceViewDelegate <NSObject>

@optional
@required
-(void)showPin;
-(void)hideTransfer;
-(void)showMain;

@end

@interface SourceView : UIView
{
    RoundedView* content;
    UITextView* transfer_text;
    UIButton* close_source;
    UIButton* back;
    UIButton* source_select;
    
    NSMutableArray* sources;

    NSString* source_id;
    NSString* source_name;
    BoldTextView* header;
    CGRect screenBounds;
    
    id <SourceViewDelegate> delegate;
}

@property (nonatomic, retain) id <SourceViewDelegate> delegate;
@property (retain) NSString* source_id;
@property (retain) NSString* source_name;

- (void)populateWithSources:(NSMutableArray*)_sources;

- (void)selectSource:(UIButton*)sender;

- (void)setAsDeposit;

- (void)setAsWithdraw;

- (void)destroy;

- (void)slideIn;

- (void)slideOut;

@end
