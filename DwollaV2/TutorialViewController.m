//
//  TutorialViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, screenBounds.size.height)];
        self.view.backgroundColor = [UIColor DwollaOrange];
        
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height)];
        if (screenBounds.size.height == 568)
        {
            [background setImage:[UIImage imageNamed:@"dw_titlelarge.png"]];
        }
        else
        {
            [background setImage:[UIImage imageNamed:@"dw_title.png"]];
        }
        [self.view addSubview:background];
        
        tutorial = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
        tutorial.contentSize = CGSizeMake(1920, 380);
        [tutorial setShowsHorizontalScrollIndicator:NO];
        [tutorial setShowsVerticalScrollIndicator:NO];
        [tutorial setPagingEnabled:YES];
        [tutorial setBackgroundColor:[UIColor clearColor]];
        [tutorial setDelegate:self];
        [self.view addSubview:tutorial];
        
        tutorialControl = [[UIPageControl alloc] initWithFrame:CGRectMake(160, screenBounds.size.height - 110, 0, 0)];
        [tutorialControl setNumberOfPages:6];
        [tutorialControl setCurrentPage:0];
        [tutorialControl setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:tutorialControl];
        
        UIView* tut1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 330)];
        [tut1 setBackgroundColor:[UIColor clearColor]];
        [tutorial addSubview:tut1];
        
        UIView* tut2 = [[UIView alloc] initWithFrame:CGRectMake(330, 10, 300, 330)];
        [tut2 setBackgroundColor:[UIColor whiteColor]];
        [tutorial addSubview:tut2];
        
        UIView* tut3 = [[UIView alloc] initWithFrame:CGRectMake(650, 10, 300, 330)];
        [tut3 setBackgroundColor:[UIColor whiteColor]];
        [tutorial addSubview:tut3];
        
        UIView* tut4 = [[UIView alloc] initWithFrame:CGRectMake(970, 10, 300, 330)];
        [tut4 setBackgroundColor:[UIColor whiteColor]];
        [tutorial addSubview:tut4];
        
        UIView* tut5 = [[UIView alloc] initWithFrame:CGRectMake(1290, 10, 300, 330)];
        [tut5 setBackgroundColor:[UIColor whiteColor]];
        [tutorial addSubview:tut5];
        
        UIView* tut6 = [[UIView alloc] initWithFrame:CGRectMake(1610, 10, 300, 330)];
        [tut6 setBackgroundColor:[UIColor whiteColor]];
        [tutorial addSubview:tut6];
        
        loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, screenBounds.size.height - 80, 300, 50)];
        [loginButton setImage:[UIImage imageNamed:@"dw_login.png"] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(moveUp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

	// Do any additional setup after loading the view, typically from a nib.
}

-(void)dropDown
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startUp)];
    self.view.center = CGPointMake(160, 245);
    [UIView commitAnimations];
}

- (void)startUp
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(moveUp)];
    self.view.center = CGPointMake(160, 250);
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

- (void)backDown
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, self.view.frame.size.height/2);
    [UIView commitAnimations];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int newOffset = scrollView.contentOffset.x;
    int newPage = (int)(newOffset/(scrollView.frame.size.width));
    [tutorialControl setCurrentPage:newPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
