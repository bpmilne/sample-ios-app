//
//  DetailViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/18/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "CommandCenter.h"
#import "ContactView.h"
#import "ConfirmView.h"
#import "TransactionReceiptView.h"
#import <MapKit/MapKit.h>
#import "RoundedView.h"
#import "RoundedImageView.h"

@class DetailView;
@protocol DetailViewDelegate <NSObject>

@optional
@required
-(void)closeDetail;

@end


@interface DetailViewController : UIViewController <ConfirmViewDelegate, MKMapViewDelegate>
{
    RoundedView* top;
    UIView* button_bar;
    UIButton* request;
    UIButton* send;
    UIImageView* exchangebg;
    RoundedImageView* profile;
    BoldTextView* name;
    RoundedView* amount_bar;
    LightTextView* amount;
    
    RoundedView* bottom;
    MKMapView* map;
    UIImageView* detailbg;
    UITextView* street;
    UITextView* city;
    UIImageView* distancebg;
    BoldTextView* distance;
    UIButton* directions;
    UIImageView* number;
    NSString* latitude;
    NSString* longitude;
    
    KeyboardViewController* keyboard;
    UIView* pin_background;
    PinView* pin_view;
    UIView* bottom_sc;
    
    ConfirmView* confirm_view;
    
    UIButton* note_button;
    RoundedView* note;
    UITextView* note_content;
    UIButton* save_note;
    
    UINavigationBar* nav;
    CommandCenter* command;
    NSString* dwolla_id;
    NSString* note_holder;
    CGRect screenBounds;
    id <DetailViewDelegate> delegate;
}

@property (retain)     id <DetailViewDelegate> delegate;

- (void)addCommandCenter:(CommandCenter*)_command;

- (void)addNavigation:(UINavigationBar*)bar;

- (void)addContact:(ContactView*)contact;

- (void)beginSend;

- (void)popToMain;

- (void)goToPIN;

- (void)popToAmount;

- (void)goToConfirm;

- (void)beginRequest;

- (void)reset;

- (void)openInMaps;

- (void)note;

- (void)hideNote;

- (void)dismissNote;

- (void)addTransasction:(TransactionReceiptView*)transaction;

- (void)slideIn;

- (void)slideOut;

- (void)hideDetail;

- (void)slideAmountDown;

- (void)slideButtonBarUp;

- (void)slidePinDown;

- (void)revert;

- (void)destroy;

- (void)slideConfirmIn;

@end
