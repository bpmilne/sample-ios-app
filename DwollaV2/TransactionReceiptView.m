//
//  TransactionReceiptView.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "TransactionReceiptView.h"

@implementation TransactionReceiptView

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];

        self.frame = CGRectMake(0, -460, 320, screenBounds.size.height);
        self.backgroundColor = [UIColor DwollaGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 50, 300, 330)];
        top.backgroundColor = [UIColor whiteColor];
        [self addSubview:top];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(125, 10, 50, 50)];
        [top addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(70, 65, 160, 25)];
        name.textAlignment = NSTextAlignmentCenter;
        [top addSubview:name];
        
        timebg = [[UIImageView alloc] initWithFrame:CGRectMake(55, 90, 190, 25)];
        timebg.image = [UIImage imageNamed:@"dw_timebanner.png"];
        [top addSubview:timebg];
        
        time = [[BoldTextView alloc] initWithFrame:CGRectMake(70, 86, 180, 25)];
        [time setTextColor:[UIColor whiteColor]];
        [top addSubview:time];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash];
        
        total = [[BoldTextView alloc] initWithFrame:CGRectMake(10, 140, 100, 25)];
        [total setText:@"TOTAL"];
        [top addSubview:total];
        
        amount = [[LightTextView alloc] initWithFrame:CGRectMake(200, 134, 100, 40)];
        amount.textAlignment = NSTextAlignmentRight;
        [amount setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [top addSubview:amount];
        
        UIImageView* dash2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 180, 300, 2)];
        dash2.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash2];
        
        note_button = [[UIButton alloc] initWithFrame:CGRectMake(10, 195, 20, 20)];
        [note_button setImage:[UIImage imageNamed:@"dw_note.png"] forState:UIControlStateNormal];
        [top addSubview:note_button];
        
        note = [[UITextView alloc] initWithFrame:CGRectMake(30, 195, 235, 60)];
        [note setBackgroundColor:[UIColor clearColor]];
        [note setUserInteractionEnabled:NO];
        [note setTextColor:[UIColor DwollaDarkGray]];
        [top addSubview:note];
        
        request = [[UIButton alloc] initWithFrame:CGRectMake(10, 270, 135, 50)];
        [request setImage:[UIImage imageNamed:@"dw_request.png"] forState:UIControlStateNormal];
        [request addTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:request];
        
        send = [[UIButton alloc] initWithFrame:CGRectMake(155, 270, 135, 50)];
        [send setImage:[UIImage imageNamed:@"dw_send.png"] forState:UIControlStateNormal];
        [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:send];
        
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
        
        UINavigationItem* transactions_header = [[UINavigationItem alloc] initWithTitle:@"RECEIPT"];
        UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
        [backb addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        backb.bounds = CGRectMake( 0, 0, 50, 30 );
        [backb setBackgroundImage:[UIImage imageNamed:@"dw_sdone.png"] forState:UIControlStateNormal];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
        [transactions_header setLeftBarButtonItem:back];
        [nav pushNavigationItem:transactions_header animated:NO];
        [self addSubview:nav];

    }
    return self;
}

-(void)setEverything:(UIImage*)_profile name:(NSString*)_name amount:(NSString*)_amount time:(NSString*)_time dwolla_id:(NSString*)_dwolla isSend:(BOOL)isSend note:(NSString*)_note
{
    profile.image = _profile;
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
    name.text = _name;
    amount.text = _amount;
    time.text = _time;
    dwolla_id = _dwolla;
    note.text = _note;
    
    UIImageView* indicator = [[UIImageView alloc] initWithFrame:CGRectMake(205, 148, 15, 15)];
    [top addSubview:indicator];
    if (isSend)
    {
        [indicator setImage:[UIImage imageNamed:@"dw_minus.png"]];
    }
    else
    {
        [indicator setImage:[UIImage imageNamed:@"dw_plus.png"]];
    }
}

- (void)send
{
    [[self delegate] repayTransaction:self];
}

- (void)request
{
    [[self delegate] requestTransaction:self];
}

-(NSString*)amount
{
    return amount.text;
}

-(NSString*)name
{
    return name.text;
}

-(UIImage*)profile
{
    return profile.image;
}

-(NSString*)dwolla_id
{
    return dwolla_id;
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, screenBounds.size.height/2);
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, -screenBounds.size.height/2);
    [UIView commitAnimations];
}
@end
