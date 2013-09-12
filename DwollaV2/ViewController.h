//
//  ViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/14/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommandCenter.h"
#import "TutorialViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"

@interface ViewController : UIViewController <LoginViewControllerDelegate, MainDelegate>
{
    TutorialViewController* tutorial;
    LoginViewController* login;
    MainViewController* main;

    CommandCenter* command;    
}

@end
