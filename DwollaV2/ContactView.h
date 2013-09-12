//
//  UserViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/17/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Person.h"
#import "Place.h"
#import "BoldTextView.h"
#import "LightTextView.h"

@class ContactView;
@protocol ContactViewDelegate <NSObject>

@optional
@required
-(void)displayContact:(ContactView*)contact;

@end

@interface ContactView : UIView
{
    UIImageView* bg;
    UIImageView* arrowbg;
    UIImageView* profile;
    BoldTextView* name;
    LightTextView* address;
    BoldTextView* distance;
    UIImageView* distbg;
    UIImageView* marker;
    
    NSString* latitude;
    NSString* longitude;
    NSString* city;
    NSString* state;
    NSString* postal;
    NSString* dwolla_id;
        
    id <ContactViewDelegate> delegate;
    BOOL isPlace;
}

@property (nonatomic, retain) id <ContactViewDelegate> delegate;
@property BOOL isPlace;

- (void)addDataPerson:(Person*)contact;

- (void)addDataPlace:(Place*)place distance:(double) _distance;

- (void)shiftView:(int)i;

- (UIImage*)profile;

- (void)setProfile:(UIImage*)image;

- (NSString*)name;

- (NSString*)address;

- (NSString*)distance;

- (NSString*)latitude;

- (NSString*)longitude;

- (NSString*)city;

- (NSString*)state;

- (NSString*)postal;

- (NSString*) dwolla_id;

-(void)addImageInBackground:(NSString*)url;

-(void)forceImage:(NSString*)url;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
