//
//  LoginViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/16/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.view.backgroundColor = [UIColor DwollaOrange];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        self.view.frame = CGRectMake(0, 0, 320, screenBounds.size.height+100);
        
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 320, screenBounds.size.height)];
        [background setBackgroundColor:[UIColor DwollaOrange]];
        if (screenBounds.size.height == 568)
        {
            [background setImage:[UIImage imageNamed:@"dw_bglarge.png"]];
        }
        else
        {
            [background setImage:[UIImage imageNamed:@"dw_background.png"]];
        }
        [self.view addSubview:background];
        
        UIColor* shadowOrange =[UIColor colorWithRed:210.0/255.9 green:62.0/255.0 blue:7.0/255.0 alpha:1.0];
        dwolla = [[UITextView alloc] initWithFrame:CGRectMake(50, 0, 220, 60)];
        [dwolla setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:48]];
        [dwolla setTextAlignment:NSTextAlignmentCenter];
        [dwolla setTextColor:[UIColor whiteColor]];
        [dwolla setBackgroundColor:[UIColor clearColor]];
        dwolla.layer.shadowColor = [shadowOrange CGColor];
        dwolla.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        dwolla.layer.shadowOpacity = 1.0f;
        dwolla.layer.shadowRadius = 1.0f;
        [dwolla setText:@"DWOLLA"];
        [self.view addSubview:dwolla];
        
        name = [[UITextField alloc] initWithFrame:CGRectMake(35, 100, 250, 50)];
        [name setBackgroundColor:[UIColor whiteColor]];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 50)];
        name.layer.shadowColor = [[UIColor colorWithRed:210.0/255.9 green:62.0/255.0 blue:7.0/255.0 alpha:1.0] CGColor];
        name.borderStyle = UITextBorderStyleNone;
        name.layer.borderWidth = 1.0f;
        name.layer.borderColor = [shadowOrange CGColor];
        name.leftView = paddingView;
        name.leftViewMode = UITextFieldViewModeAlways;
        name.clipsToBounds = YES;
        name.layer.cornerRadius = 3.0f;
        name.delegate = self;
        name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [name setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [name setTextColor:[UIColor DwollaDarkGray]];
        [name setPlaceholder:@"email or phone number"];
        [self.view addSubview:name];
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(35, 160, 250, 50)];
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
        password.leftView = paddingView2;
        password.leftViewMode = UITextFieldViewModeAlways;
        [password setBackgroundColor:[UIColor whiteColor]];
        [password setSecureTextEntry:YES];
        password.clipsToBounds = YES;
        [password setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [password setTextColor:[UIColor DwollaDarkGray]];
        password.delegate = self;
        password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        password.layer.borderWidth = 1.0f;
        password.layer.borderColor = [shadowOrange CGColor];
        password.layer.cornerRadius = 3.0f;
        [password setPlaceholder:@"password"];
        [self.view addSubview:password];
        
        loginButton = [[UIButton alloc] initWithFrame:CGRectMake(35, screenBounds.size.height - 250, 250, 50)];
        [loginButton setImage:[UIImage imageNamed:@"dw_loginsm.png"] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginButton];
        
        remember = [[UIButton alloc] initWithFrame:CGRectMake(40, screenBounds.size.height - 180, 120, 20)];
        [remember setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [remember setBackgroundColor:[UIColor clearColor]];
        remember.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [remember setTitle:@"Remember Me" forState:UIControlStateNormal];
        remember.titleLabel.font = [UIFont fontWithName:@"GillSans" size:12];
        [remember addTarget:self action:@selector(remember) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:remember];
        
        forgot= [[UIButton alloc] initWithFrame:CGRectMake(190, screenBounds.size.height - 180, 90, 20)];
        forgot.titleLabel.textColor = [UIColor whiteColor];
        [forgot setBackgroundColor:[UIColor clearColor]];
        forgot.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        forgot.titleLabel.font = [UIFont fontWithName:@"GillSans" size:12];
        [forgot setTitle:@"Forgot password?" forState:UIControlStateNormal];
        [forgot addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forgot];
        
        dwollaV2 = [[UIButton alloc] initWithFrame:CGRectMake(0, screenBounds.size.height - 95, 320, 75)];
        [dwollaV2 setImage:[UIImage imageNamed:@"dw_noaccount.png"] forState:UIControlStateNormal];
        [dwollaV2 addTarget:self action:@selector(getDwolla) forControlEvents:UIControlEventTouchUpInside];
        [dwollaV2 setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:dwollaV2];
        
        rememberme = NO;
    }
    return self;
}

- (void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
    [self oAuth];
}

-(void)dismissKeyboard
{
    [name resignFirstResponder];
    [password resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, screenBounds.size.height/2+10);
    [UIView commitAnimations];
}

- (void)startUp
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(moveUp)];
    self.view.center = CGPointMake(160, screenBounds.size.height - 230);
    [UIView commitAnimations];
}

- (void)moveUp
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, -360);
    [UIView commitAnimations];
}

- (void)dropBack
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, self.view.frame.size.height/2);
    [UIView commitAnimations];
    self.view.hidden = NO;
}


 - (void)forgotPassword
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.dwolla.com/forgot/password"]];
}

- (void)remember
{
    if (rememberme)
    {
        rememberme = NO;
        [remember setTitle:@"Remember Me" forState:UIControlStateNormal];
    }
    else
    {
        rememberme = YES;
        [remember setTitle:@"Don't Remember Me" forState:UIControlStateNormal];
    }
}

- (void)oAuth
{
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height)];
    web.delegate = self;
    NSString* token = [@"mEXfsx4F+Mk7fAlnWdoGmutm6CT5FnEqyXarA4D3oItOxsZ0HL" urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSString* scopes = [@"accountinfofull|send|transactions|contacts|balance|request|funding|manageaccount" urlEncodeUsingEncoding:NSUTF8StringEncoding];

    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/v2/authenticate?client_id=%@&response_type=code&redirect_uri=www.oauthredirect.com&scope=%@", token, scopes];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:web];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* requestString = [[request URL] absoluteString];
    if ([requestString rangeOfString:@"www.oauthredirect.com?code=" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        NSString* code = [[requestString componentsSeparatedByString:@"code="] objectAtIndex:1];
        NSString* response = [command login:code remember:YES];
        if ([response isEqualToString:@"success"])
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:.4];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationWillStartSelector:@selector(moveUp)];
            self.view.center = CGPointMake(160, screenBounds.size.height - 235);
            [UIView commitAnimations];
            [[self delegate] didLogin];
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Login" message:@"There was an error with your e-mail/password combination. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    return YES;
}

- (void)clearWebView
{
    [web removeFromSuperview];
    [web loadHTMLString:nil baseURL:nil];
    web = nil;
}

- (void)getDwolla
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.dwolla.com/register"]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, screenBounds.size.height - 320);
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
