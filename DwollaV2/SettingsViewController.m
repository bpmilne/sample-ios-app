//
//  SettingsViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/22/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize nav;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(-320, 0, 320, screenBounds.size.height+60);
        self.view.backgroundColor = [UIColor DwollaGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 50, 300, 140)];
        [top setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:top];
        
        middle = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 300, 80)];
        [middle setBackgroundColor:[UIColor DwollaGray]];
        [self.view addSubview:middle];
        
        bottom = [[UIView alloc] initWithFrame:CGRectMake(10, 290, 300, 40)];
        [bottom setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:bottom];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [top addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(65, 15, 200, 40)];
        [top addSubview:name];
        
        _id = [[UITextView alloc] initWithFrame:CGRectMake(65, 35, 100, 35)];
        [_id setUserInteractionEnabled:NO];
        [_id setTextColor:[UIColor DwollaDarkGray]];
        [_id setFont:[UIFont fontWithName:@"GillSans" size:12]];
        [_id setBackgroundColor:[UIColor clearColor]];
        [_id setText:@""];
        [top addSubview:_id];
        
        transactionsb = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 280, 50)];
        [transactionsb setImage:[UIImage imageNamed:@"dw_transaction.png"] forState:UIControlStateNormal];
        [transactionsb addTarget:self action:@selector(showTransactions) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:transactionsb];
        
        support = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 39)];
        [support setBackgroundColor:[UIColor clearColor]];
        [support setBackgroundImage:[UIImage imageNamed:@"dw_sourcet.png"] forState:UIControlStateNormal];
        [support setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        support.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [support setTitle:@"Call Customer Support" forState:UIControlStateNormal];
        [support addTarget:self action:@selector(callSupport) forControlEvents:UIControlEventTouchUpInside];
        [middle addSubview:support];
        
        forgot = [[UIButton alloc] initWithFrame:CGRectMake(0, 41, 300, 39)];
        [forgot setBackgroundColor:[UIColor clearColor]];
        [forgot setBackgroundImage:[UIImage imageNamed:@"dw_sourceb.png"] forState:UIControlStateNormal];
        [forgot setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        forgot.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [forgot setTitle:@"Forgot Your PIN?" forState:UIControlStateNormal];
        [forgot addTarget:self action:@selector(forgotPin) forControlEvents:UIControlEventTouchUpInside];
        [middle addSubview:forgot];
        
        logout = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        [logout setBackgroundImage:[UIImage imageNamed:@"dw_source.png"] forState:UIControlStateNormal];
        logout.layer.cornerRadius = 1.0;
        logout.layer.masksToBounds = YES;
        logout.clipsToBounds = YES;
        [logout setBackgroundColor:[UIColor clearColor]];
        [logout setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        logout.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [logout setTitle:@"Logout" forState:UIControlStateNormal];
        [bottom addSubview:logout];
        
        transactions_view = [[ScrollableView alloc] init];
        [transactions_view setDelegate:self];
        transactions = 0;
        isSet = NO;
        
        nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
                NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [nav titleTextAttributes]];
        [titleBarAttributes setValue:[UIFont fontWithName:@"GillSans-Bold" size:16] forKey:UITextAttributeFont];
        [nav setTitleTextAttributes:titleBarAttributes];

        UIImage *originalImage = [UIImage imageNamed:@"dw_header.png"];
        // scaling set to 2.0 makes the image 1/2 the size.
        UIImage *scaledImage =
        [UIImage imageWithCGImage:[originalImage CGImage]
                            scale:(originalImage.scale * 2.0)
                      orientation:(originalImage.imageOrientation)];
        [nav setBackgroundImage:scaledImage forBarMetrics:UIBarMetricsDefault];

        UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"SETTINGS"];
        UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
        [backb addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        backb.bounds = CGRectMake( 0, 0, 50, 30 );
        [backb setBackgroundImage:[UIImage imageNamed:@"dw_sdone.png"] forState:UIControlStateNormal];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
        [detail_header setLeftBarButtonItem:back];
        [nav pushNavigationItem:detail_header animated:NO];
        nav.hidden = NO;
        [self.view addSubview:nav];
        
        loading = [[UIView alloc] initWithFrame:CGRectMake(20, 130, 280, 50)];
        [self.view addSubview:loading];
        loading.hidden = YES;
    }
    return self;
}

-(void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
    [transactions_view addCommandCenter:_command];
}

-(void)setUserInfo:(NSMutableArray*)info
{
    name.text = [info objectAtIndex:1];
    _id.text = [info objectAtIndex:0];
    profile.image = [info objectAtIndex:2];
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
    isSet = YES;
}

- (BOOL)userInfoSet
{
    return isSet;
}

-(void)showTransactions
{
    loading.hidden = NO;
    //[self loadingTransactions];
    [self addTransactions:transArray];
    [self.view addSubview:transactions_view];
    [transactions_view slideIn];
}

- (void)loadingTransactions
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loadingTransactions2)];
    loading.backgroundColor = [UIColor DwollaGray];
    [UIView commitAnimations];
}

- (void)loadingTransactions2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loadingTransactions)];
    loading.backgroundColor = [UIColor DwollaOrange];
    [UIView commitAnimations];
}

-(void)hideTransactions
{
    [nav popNavigationItemAnimated:NO];
    [receipt_view slideOut];
    [transactions_view slideOut];
}

- (void)callSupport
{
    NSString *phoneNumber = @"1-515-280-1000"; 
    NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (void)forgotPin
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.dwolla.com/forgot/pin"]];
}

- (void)logout
{
    [[self delegate] logout];
}

- (void)backgroundTransactions:(NSMutableArray*)trans
{
    transArray = trans;
}

- (void)addTransactions:(NSMutableArray*)_transactions
{
    if (![previousTransaction isEqualTo:[_transactions objectAtIndex:0]])
    {
        transactions = [_transactions count];
        [transactions_view addTransactions:_transactions withDelegate:self];
        previousTransaction = [_transactions objectAtIndex:0];
    }
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, screenBounds.size.height/2+30);
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(close)];
    self.view.center = CGPointMake(-480, screenBounds.size.height/2+30);
    [UIView commitAnimations];
}

- (void)payReceipt
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationDidStopSelector:@selector(hideTransactions)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(-480, 225);
    [UIView commitAnimations];
}

-(void)displayTransaction:(TransactionView*)transaction
{
    receipt_view = [[TransactionReceiptView alloc] init];
    [receipt_view setEverything:[transaction profile] name:[transaction name] amount:[transaction total] time:[transaction time] dwolla_id:[transaction dwolla_id] isSend:[transaction isSend] note:[transaction note]];
    receipt_view.delegate = (id<TransactionReceiptViewDelegate>)delegate;
    [self.view addSubview:receipt_view];
    [receipt_view slideIn];
}

- (void)loadTransactions
{
    NSMutableArray* toAdd = [command getTransactionsWithOffset:transactions];
    [transactions_view insertTransactions:toAdd withDelegate:self offset:transactions];
    transactions = [toAdd count];
}

- (void)close
{
    [[self delegate] closeSettings];
}

- (void)destory
{
    [top removeFromSuperview];
    top = nil;
    [middle removeFromSuperview];
    middle = nil;
    [bottom removeFromSuperview];
    bottom = nil;
    [profile removeFromSuperview];
    profile = nil;
    [name removeFromSuperview];
    name = nil;
    [_id removeFromSuperview];
    _id = nil;
    [transactionsb removeFromSuperview];
    transactionsb = nil;
    [support removeFromSuperview];
    support = nil;
    [forgot removeFromSuperview];
    forgot = nil;
    [logout removeFromSuperview];
    logout = nil;
    [nav removeFromSuperview];
    nav = nil;
    command = nil;
    [transactions_view destroyTransactions];
    [transactions_view removeFromSuperview];
    transactions_view = nil;
    [receipt_view removeFromSuperview];
    receipt_view = nil;
    delegate = nil;
    isSet = nil;
    transactions = nil;
    previousTransaction = nil;
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
