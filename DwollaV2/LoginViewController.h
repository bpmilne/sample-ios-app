//
//  LoginViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/16/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommandCenter.h"
#import "UIColor+DwollaColors.h"
#import <QuartzCore/QuartzCore.h>

@class LoginViewController;
@protocol LoginViewControllerDelegate <NSObject>

@optional
@required
- (void)didLogin;


@end

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>
{
    UITextView* dwolla;
    UIImageView* background;
    UIButton* dwollaV2;
    UITextField* name;
    UITextField* password;
    UIButton* remember;
    BOOL rememberme;
    UIButton* forgot;
    UIButton* loginButton;
    UIWebView* web;
    
    CommandCenter* command;
    id <LoginViewControllerDelegate> delegate;
    CGRect screenBounds;
}

@property (nonatomic, retain) id <LoginViewControllerDelegate> delegate;

- (void)addCommandCenter:(CommandCenter*)command;

- (void)dismissKeyboard;

- (void)startUp;

- (void)moveUp;

- (void)dropBack;

- (void)forgotPassword;

- (void)remember;

- (void)oAuth;

- (void)clearWebView;

- (void)getDwolla;

@end

