//
//  ViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/14/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    main = [[MainViewController alloc] init];
    login = [[LoginViewController alloc] init];
    tutorial = [[TutorialViewController alloc] init];
    login.delegate = self;
    main.delegate = self;
       
    [self.view addSubview:main.view];
    [self.view addSubview:login.view];
    [self.view addSubview:tutorial.view];
    
    command = [[CommandCenter alloc] init];
    if ([command didRemember])
    {
        tutorial.view.hidden = YES;
        login.view.hidden = YES;
    }
    command.delegate = main;
    [login addCommandCenter:command];
    [main addCommandCenter:command];
}

- (void)didLogin
{
    [login clearWebView];
}

- (void)logout
{
    tutorial.view.hidden = NO;
    [tutorial backDown];
    login.view.hidden = NO;
    [login dropBack];
    [login oAuth];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
