//
//  MainViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/17/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommandCenter.h"
#import "DetailViewController.h"
#import "SettingsViewController.h"
#import "MapViewController.h"
#import "ReceiptView.h"
#import "TransferViewController.h"
#import "UIColor+DwollaColors.h"
#import <CoreLocation/CoreLocation.h>
#import "RequestView.h"
#import "RequestViewController.h"

@class MainViewController;
@protocol MainDelegate <NSObject>

@optional
@required
-(void)logout;
@end

@interface MainViewController : UIViewController <CommandCenterDelegate, ContactViewDelegate, UITextViewDelegate, RequestViewDelegate, TransactionReceiptViewDelegate, SettingsViewDelegate, RequestViewControllerDelegate, UIScrollViewDelegate, MapDelegate, TransferViewDelegate, DetailViewDelegate>
{
    UIView* background;
    UIView* header;
    UIButton* profile;
    UITextView* search;
    UIButton* map_b;
    UIButton* requests_header;
    UITextView* num_requests;
    UIScrollView* content;
    UIView* footer;
    UIButton* withdraw;
    UIImageView* balancebg;
    UITextView* balance;
    UIButton* deposit;
    UIButton* mapback;
    UIScrollView* searchCover;
    UITextView* searchText;
        
    CommandCenter* command;
    int number_of_places;
    int number_of_search;
    int capacity;
    NSNumber* editToggle;
    NSString* searchString;
    NSString* tweetText;
    
    DetailViewController* detail;
    ReceiptView* receipt;
    SettingsViewController* settings;
    TransferViewController* transfer;
    MapViewController* map;
    ScrollableView* requests_scroll;
    RequestViewController* request_controller;
    UINavigationBar* nav;
    CLLocation* user_location;
    id<MainDelegate> delegate;
    CGRect screenBounds;
}

@property (nonatomic, retain) id<MainDelegate> delegate;

- (void)addCommandCenter:(CommandCenter*)_command;

- (void)showSettings;

- (void)showMap;

- (void)hideMap;

- (void)showDeposit;

- (void)showWithdraw;

- (void)tweet;

- (void)loadContacts;

- (void)dropBalance;

- (void)raiseBalance;

- (void)dropRequests;

- (void)addToScroll:(Place*)place;

- (void)addPersonToScroll:(Person*)person;

- (void)popToMain;

- (void)dismissKeyboard;

- (void)showError:(UIAlertView*)alert;

- (void)showRequests;

@end
