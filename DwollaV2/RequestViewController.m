//
//  RequestViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 6/4/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "RequestViewController.h"

@interface RequestViewController ()

@end

@implementation RequestViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(0, -screenBounds.size.height, 320, screenBounds.size.height);
        
        slip = [[RequestSlipView alloc] init];
        slip.delegate = self;
        [self.view addSubview:slip];
        
        pin_background = [[UIView alloc] initWithFrame:CGRectMake(0, -200, 320, screenBounds.size.height - 232)];
        pin_background.backgroundColor = [UIColor DwollaGray];
        pin_background.hidden = YES;
        [self.view addSubview:pin_background];
        
        confirm_b = [[UIButton alloc] initWithFrame:CGRectMake(20, 130, 280, 40)];
        [confirm_b setImage:[UIImage imageNamed:@"dw_confirm.png"] forState:UIControlStateNormal];
        [confirm_b addTarget:self action:@selector(showReceipt) forControlEvents:UIControlEventTouchUpInside];
        [confirm_b setBackgroundColor:[UIColor clearColor]];
        [pin_background addSubview:confirm_b];
        
        keyboard = [[KeyboardViewController alloc] init];
        [self.view addSubview:keyboard.view];
        
        pin = [[PinView alloc] init];
        pin.center = CGPointMake(160, 40);
        [pin_background addSubview:pin];
        [keyboard addPINView:pin];
        
        receipt = [[RequestReceiptView alloc] init];
        receipt.delegate = self;
        [self.view addSubview:receipt];
    }
    return self;
}

- (void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
}

- (void)addRequest:(RequestView*)request
{
    [slip setEverything:[request profile] name:[request name] amount:[request total] time:[request time] dwolla_id:[request req_id] youRequested:[request youRequested]];
    if ([request youRequested])
    {
        [confirm_b removeTarget:self action:@selector(showReceipt) forControlEvents:UIControlEventTouchUpInside];
        [confirm_b addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [confirm_b removeTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [confirm_b addTarget:self action:@selector(showReceipt) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)payRequest:(RequestSlipView*)request
{
    pin_background.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    pin_background.center = CGPointMake(160, pin_background.frame.size.height/2);
    [UIView commitAnimations];
    [keyboard slideInDeposit];
}

-(void)cancelRequest:(RequestSlipView*)request
{
    pin_background.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    pin_background.center = CGPointMake(160, pin_background.frame.size.height/2);
    [UIView commitAnimations];
    [keyboard slideInRequest];
}

- (void)showReceipt
{
    [command payRequest:[slip dwolla_id] pin:[pin getPIN] amount:[slip amount]];
    [receipt setEverything:[slip profile] name:[slip name] amount:[slip amount] time:[slip time] dwolla_id:[slip dwolla_id]];
    [receipt slideIn];
}

- (void)cancel
{
    [command cancelRequest:[slip dwolla_id]];
    [slip slideOut];
    [self slideOut];
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, 42+(self.view.frame.size.height/2));
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, screenBounds.size.height*2);
    [UIView commitAnimations];
}

-(void)done
{
    [[self delegate] finished] ;
    [self slideOut];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
