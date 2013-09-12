//
//  RequestView.h
//  DwollaV2
//
//  Created by Nick Schulze on 6/3/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "RoundedImageView.h"
#import "BoldTextView.h"

@class RequestView;
@protocol RequestViewDelegate <NSObject>

@optional
@required
-(void)displayRequest:(RequestView*)Request;

@end
@interface RequestView : UIView
{
    UIImageView* bg;
    UIImageView* arrowbg;
    RoundedImageView* profile;
    BoldTextView* name;
    UITextView* time;
    BoldTextView* total;
    UIImageView* totalbg;
    UIImageView* marker;
    
    NSString* dwolla_id;
    NSString* req_id;
    NSString* realDate;
    BOOL youRequested;
    
    id <RequestViewDelegate> delegate;
}

@property (nonatomic, retain) id <RequestViewDelegate> delegate;

@property BOOL youRequested;

- (void)addData:(Request*)request;

- (void)shiftView:(int)i;

- (UIImage*)profile;

- (void)setProfile:(UIImage*)image;

- (NSString*)name;

- (NSString*)time;

- (NSString*)total;

- (NSString*) dwolla_id;

- (NSString*) req_id;

- (void)destroy;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end
