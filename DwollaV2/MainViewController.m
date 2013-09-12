//
//  MainViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/17/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        
        self.view.frame = CGRectMake(0, 0, 320, screenBounds.size.height+60);
        
        background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height)];
        [background setBackgroundColor:[UIColor DwollaCharcoal]];
        [self.view addSubview:background];
        
        requests_header = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
        [requests_header setBackgroundColor:[UIColor DwollaOrange]];
        [requests_header setImage:[UIImage imageNamed:@"dw_requests.png"] forState:UIControlStateNormal];
        [requests_header addTarget:self action:@selector(showRequests) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:requests_header];
        
        num_requests = [[UITextView alloc] initWithFrame:CGRectMake(108, 5, 40, 20)];
        [num_requests setUserInteractionEnabled:NO];
        num_requests.textAlignment = NSTextAlignmentCenter;
        num_requests.backgroundColor = [UIColor clearColor];
        [num_requests setFont:[UIFont fontWithName:@"GillSans-Bold" size:9]];
        [num_requests setTextColor:[UIColor DwollaOrange]];
        [requests_header addSubview:num_requests];
        
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [header setBackgroundColor:[UIColor DwollaDarkGray]];
        [self.view addSubview:header];
        
        profile = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [profile setBackgroundColor:[UIColor DwollaDarkGray]];
        [profile setImage:[UIImage imageNamed:@"dw_profile.png"] forState:UIControlStateNormal];
        [profile addTarget:self action:@selector(showSettings) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:profile];
        
        UIImageView* searchbg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 240, 40)];
        [searchbg setImage:[UIImage imageNamed:@"dw_search.png"]];
        [header addSubview:searchbg];
        
        search = [[UITextView alloc] initWithFrame:CGRectMake(66, 1, 240, 40)];
        [search setDelegate:self];
        [search setBackgroundColor:[UIColor clearColor]];
        [search setFont:[UIFont fontWithName:@"GillSans-Light" size:20]];
        [search setTextColor:[UIColor whiteColor]];
        [search setKeyboardType:UIKeyboardTypeDefault];
        [header addSubview:search];
        
        map_b = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 40)];
        [map_b setBackgroundColor:[UIColor DwollaDarkGray]];
        [map_b setImage:[UIImage imageNamed:@"dw_map.png"] forState:UIControlStateNormal];
        [map_b addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:map_b];
        
        content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, screenBounds.size.height-100)];
        content.delegate = self;
        [content setBackgroundColor:[UIColor DwollaGray]];
        content.contentSize = CGSizeMake(320, 970);
        [self.view addSubview:content];
        
        footer = [[UIView alloc] initWithFrame:CGRectMake(0, screenBounds.size.height-60, 320, 40)];
        [footer setBackgroundColor:[UIColor DwollaDarkGray]];
        [self.view addSubview:footer];
        
        withdraw = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [withdraw setTitle:@"-" forState:UIControlStateNormal];
        [withdraw setImage:[UIImage imageNamed:@"dw_withdraw.png"] forState:UIControlStateNormal];
        [withdraw setBackgroundColor:[UIColor DwollaDarkGray]];
        [withdraw addTarget:self action:@selector(showWithdraw) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:withdraw];
        
        balancebg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 240, 40)];
        balancebg.image = [UIImage imageNamed:@"dw_balance.png"];
        [footer addSubview:balancebg];
        
        balance = [[UITextView alloc] initWithFrame:CGRectMake(80, 0, 160, 40)];
        balance.textAlignment = NSTextAlignmentCenter;
        [balance setFont:[UIFont fontWithName:@"GillSans-Light" size:20]];
        [balance setTextColor:[UIColor whiteColor]];
        balance.text = @"0.00";
        [balance setBackgroundColor:[UIColor clearColor]];
        [balance setUserInteractionEnabled:NO];
        [footer addSubview:balance];
        
        deposit = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 40, 40)];
        [deposit setTitle:@"+" forState:UIControlStateNormal];
        [deposit setImage:[UIImage imageNamed:@"dw_deposit.png"] forState:UIControlStateNormal];
        [deposit setBackgroundColor:[UIColor DwollaDarkGray]];
        [deposit addTarget:self action:@selector(showDeposit) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:deposit];
        
        
        searchCover = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -300, 320, screenBounds.size.height-268)];
        searchCover.backgroundColor = [UIColor DwollaGray];
        [self.view addSubview:searchCover];
        
        [self.view bringSubviewToFront:header];
        
        number_of_places = 0;
        number_of_search = 0;
        capacity = 15;
        editToggle = [NSNumber numberWithInt:1];
    }
    return self;
}

- (void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
}

- (void)showSettings
{
    settings = [[SettingsViewController alloc] init];
    [settings addCommandCenter:command];
    settings.delegate = self;
    [self.view addSubview:settings.view];

    [self slideSearchCoverOut];
    [search resignFirstResponder];
    if ([settings userInfoSet] == NO)
    {
        [settings setUserInfo:[command userInfo]];
    }
    [settings backgroundTransactions:[command userTransactions]];
    [settings slideIn];
    [self.view bringSubviewToFront:footer];
    [self performSelector:@selector(hideMap) withObject:nil afterDelay:1.0];
}

- (void)showMap
{
   
    if (map == nil)
    {
        map = [[MapViewController alloc] init];
        [map addCommandCenter:command];
        [self.view addSubview:map.view];
        NSMutableArray* places = [command userNearby];
        for(int i = 0; i < [places count]; i++)
        {
            [map addToMap:[places objectAtIndex:i]];

        }
        user_location = [command userLocation];
        [map centerMap:user_location];
        [map setDelegate:self];
        [self slideSearchCoverOut];
        [search resignFirstResponder];
        [map slideIn];
    }
}

- (void)hideMap
{
    [map removeFromParentViewController];
    [map.view removeFromSuperview];
    [map destroy];
    map = nil;
}

- (void)showDeposit
{
    transfer = [[TransferViewController alloc] init];
    [transfer addCommandCenter:command];
    [self.view addSubview:transfer.view];
    transfer.delegate = self;
    [transfer getSources];
    [transfer setAsDeposit];
    [self.view bringSubviewToFront:transfer.view];
    [transfer slideIn];
}

- (void)showWithdraw
{
    transfer = [[TransferViewController alloc] init];
    [transfer addCommandCenter:command];
    [self.view addSubview:transfer.view];
    transfer.delegate = self;
    [transfer getSources];
    [transfer setAsWithdraw];
    [self.view bringSubviewToFront:transfer.view];
    [transfer slideIn];
}

- (void)closeTransfer
{
    [transfer destroy];
    [transfer removeFromParentViewController];
    [transfer.view removeFromSuperview];
    transfer = nil;
}

- (void)showRequests
{
    requests_scroll = [[ScrollableView alloc] init];
    [requests_scroll addCommandCenter:command];
    [requests_scroll addRequests:[command userRequests] withDelegate:self];
    [self.view addSubview:requests_scroll];
    
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
    
    [requests_scroll addSubview:nav];

    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"REQUESTS"];
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(popToMain) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_sdone.png"] forState:UIControlStateNormal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [detail_header setRightBarButtonItem:back];
    [nav pushNavigationItem:detail_header animated:NO];
    [requests_scroll bringSubviewToFront:nav];
    nav.hidden = NO;
    [requests_scroll slideIn];
}

- (void)loadContacts
{
    NSMutableArray* contacts = [command getContacts];
    for (int i = 0; i < [contacts count]; i++)
    {
        ContactView* user = [contacts objectAtIndex:i];
        [user shiftView:i];
        [content addSubview:user];
    }
}

- (void)displayBalance
{
    //[self dropBalance];
}

-(void)displayRequests
{
    [self performSelectorOnMainThread:@selector(dropBalance) withObject:nil waitUntilDone:YES];
}

-(void)displayError:(NSString*)error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [self performSelectorOnMainThread:@selector(showError:) withObject:alert waitUntilDone:YES];
}

- (void)showError:(UIAlertView*)alert
{
    [alert show];
}

- (void)dropBalance
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(raiseBalance)];
    footer.center = CGPointMake(160, screenBounds.size.height);
    [UIView commitAnimations];
}

- (void)raiseBalance
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    footer.center = CGPointMake(160, screenBounds.size.height-40);
    [UIView commitAnimations];
    balance.text = [@"$" stringByAppendingString:[command userBalance]];
    [self dropRequests];
}

- (void)dropRequests
{
    NSMutableArray* requests = [command userRequests];
    if ([requests count] > 0)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:3.0];
        [UIView setAnimationDuration:.4];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        requests_header.center = CGPointMake(160, 60);
        content.frame = CGRectMake(0, 82, 320, screenBounds.size.height - 140);
        [UIView commitAnimations];
        NSString* count = [NSString stringWithFormat:@"%d", [requests count]];
        if ([requests count] > 20)
        {
            count = @"20+";
        }
        num_requests.text = count;
        [requests_header setEnabled:YES];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:3.0];
        [UIView setAnimationDuration:.4];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        requests_header.center = CGPointMake(160, 20);
        content.frame = CGRectMake(0, 40, 320, screenBounds.size.height - 100);
        [UIView commitAnimations];
        num_requests.text = [NSString stringWithFormat:@"%d", [requests count]];
    }
}

- (void)displayNearby
{
    number_of_places = 0;
    NSMutableArray* places = [command userNearby];
    NSMutableArray* people = [command userNearbyPeople];
    user_location = [command userLocation];
    content.contentSize = CGSizeMake(320, (80*[places count]+10));
    for(int i = 0; i < [places count] && i < 5; i++)
    {
        [self performSelectorOnMainThread:@selector(addToScroll:) withObject:[places objectAtIndex:i] waitUntilDone:YES];
    }
    for(int i = 0; i < [people count]; i++)
    {
        [self performSelectorOnMainThread:@selector(addPersonToScroll:) withObject:[people objectAtIndex:i] waitUntilDone:YES];
    }
    for(int i = 5; i < [places count]; i++)
    {
        [self performSelectorOnMainThread:@selector(addToScroll:) withObject:[places objectAtIndex:i] waitUntilDone:YES];
    }
}
- (void)mapDetail:(Place*)place
{
    CLLocationDegrees latitude = [[place latitude] doubleValue];
    CLLocationDegrees longitude = [[place longitude] doubleValue];
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    double distance = [location distanceFromLocation:user_location];
    
    ContactView* place_view = [[ContactView alloc] init];
    place_view.delegate = self;
    [place_view addDataPlace:place distance:distance];
    [place_view forceImage:[place image]];
    
    [self displayContact:place_view];
}

- (void)addToScroll:(Place*)place
{
    [map addToMap:place];
    
    CLLocationDegrees latitude = [[place latitude] doubleValue];
    CLLocationDegrees longitude = [[place longitude] doubleValue];
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    double distance = [location distanceFromLocation:user_location];
    
    ContactView* place_view = [[ContactView alloc] init];
    place_view.delegate = self;
    [place_view addDataPlace:place distance:distance];
    [place_view shiftView:number_of_places];
    number_of_places++;
    [content addSubview:place_view];
}

- (void)addPersonToScroll:(Person*)person
{
    ContactView* person_view = [[ContactView alloc] init];
    person_view.delegate = self;
    [person_view addDataPerson:person];
    [person_view shiftView:number_of_places];
    number_of_places++;
    [content addSubview:person_view];
}

- (void)displayContact:(ContactView*)contact
{
    detail = [[DetailViewController alloc] init];
    detail.delegate = self;
    [detail addCommandCenter:command];
    [self.view addSubview:detail.view];
    [detail addCommandCenter:command];
    [detail addContact:contact];
    [detail slideIn];
    [self dismissKeyboard];
    [self.view bringSubviewToFront:footer];
}

-(void)closeDetail
{
    [detail removeFromParentViewController];
    [detail.view removeFromSuperview];
    [detail destroy];
    detail = nil;
}

-(void)repayTransaction:(TransactionReceiptView*)transaction
{
    detail = [[DetailViewController alloc] init];
    detail.delegate = self;
    [detail addCommandCenter:command];
    [self.view addSubview:detail.view];
    [detail addCommandCenter:command];
    [detail addTransasction:transaction];
    [detail beginSend];
    [detail slideIn];
    [self.view bringSubviewToFront:footer];
    [self hideSettings];
}

-(void)requestTransaction:(TransactionReceiptView*)transaction
{
    detail = [[DetailViewController alloc] init];
    detail.delegate = self;
    [detail addCommandCenter:command];
    [self.view addSubview:detail.view];
    [detail addCommandCenter:command];
    [detail addTransasction:transaction];
    [detail beginRequest];
    [detail slideIn];
    [self.view bringSubviewToFront:footer];
    [self hideSettings];
}

-(void)displayReceipt:(UIImage*)image name:(NSString*)name amount:(NSString*)amount note:(NSString *)note type:(NSString *)_type
{
    receipt = [[ReceiptView alloc] init];
    [receipt setEverything:image name:name amount:amount note:note type:_type];
    
    [self.view addSubview:receipt];
    
    UIButton* twitter = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 280, 50)];
    twitter.layer.cornerRadius = 3.0;
    twitter.layer.masksToBounds = YES;
    twitter.clipsToBounds = YES;
    [twitter.titleLabel setFont:[UIFont fontWithName:@"GillSans-Bold" size:16]];
    twitter.titleLabel.shadowColor = [UIColor grayColor];
    twitter.titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    [twitter.layer setShadowOffset:CGSizeMake(6, 6)];
    [twitter.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [twitter.layer setShadowOpacity:0.5];
    [twitter setTitle:@"Share With Twitter!" forState:UIControlStateNormal];
    twitter.backgroundColor = [UIColor DwollaBlue];
    [twitter addTarget:self action:@selector(tweet) forControlEvents:UIControlEventTouchUpInside];
    tweetText = [NSString stringWithFormat:@"I just used Dwolla to send money to %@!", name];
    [receipt addSubview:twitter];
    
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
    [receipt addSubview:nav];
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"RECEIPT"];
    
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(popToMain) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_sdone.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [detail_header setRightBarButtonItem:back];
    [nav pushNavigationItem:detail_header animated:YES];
    nav.hidden = NO;
    [detail revert];
    [receipt slideIn];
}

- (void)tweet
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:tweetText];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't tweet right now, make sure you have an internet connection and at least one Twitter account setup."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)displayRequest:(RequestView*)request
{
    request_controller = [[RequestViewController alloc] init];
    request_controller.delegate = self;
    [request_controller addRequest:request];
    [request_controller addCommandCenter:command];
    [self.view addSubview:request_controller.view];
    [request_controller slideIn];
    [request_controller.view bringSubviewToFront:nav];
}

-(void)finished
{
    requests_scroll.hidden = YES;
    request_controller.view.hidden = YES;
    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    nav.hidden = YES;
    [command getBalance];
}

- (void)popToMain
{
    [detail slideOut];
    [receipt slideOut];
    [settings slideOut];
    [nav popNavigationItemAnimated:NO];
    [requests_scroll slideOut];
    [request_controller slideOut];
}

-(void)hideSettings
{
    [settings slideOut];
}

-(void)closeSettings
{
    [settings destory];
    [settings removeFromParentViewController];
    [settings.view removeFromSuperview];
    settings = nil;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIButton* searchButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 300, 80)];
    searchButton.titleLabel.font = [UIFont fontWithName:@"GillSans-Light" size:20];
    [searchButton setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor DwollaGray];
    [searchButton setTitle:@"Tap here to dismiss keyboard." forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [searchCover addSubview:searchButton];
    searchCover.contentSize = CGSizeMake(320, 0);
    
    [self performSelector:@selector(hideMap) withObject:nil afterDelay:1.0];
    [self slideSearchCover];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSRange contains = [textView.text rangeOfString:@"\n" options:NSCaseInsensitiveSearch];
    if (contains.location != NSNotFound)
    {
        [self dismissKeyboard];
    }
    else if (![textView.text isEqualToString:@""])
    {
        editToggle = [NSNumber numberWithInt: [editToggle intValue] + 1];
        searchString = textView.text;
        [self performSelector:@selector(search:) withObject:editToggle afterDelay:.75];
    }
}

-(void)search:(NSNumber*)toggleCheck
{
    if ([toggleCheck isEqualToNumber:editToggle])
    {
        number_of_search = 1;
        NSMutableArray* people = [[NSMutableArray alloc] initWithCapacity:10];
        if ([searchString rangeOfString:@"@"].location != NSNotFound || [searchString rangeOfString:@"-"].location != NSNotFound)
        {
            Person* person = [command getBasicInfo:searchString];
            if (![person.name isEqualToString:@"empty"])
            {
                [people addObject:person];
            }
        }
        else
        {
            people = [command searchContacts:searchString];

        }
        if ([people count] != 0)
        {
            searchText.hidden = YES;
            
            for (int i = 0; i < [people count]; i++)
            {
                [self performSelectorOnMainThread:@selector(addPersonToSearch:) withObject:[people objectAtIndex:i] waitUntilDone:YES];
                number_of_search += 1;
            }
            if (searchCover.contentSize.height < (80*number_of_search)+90)
            {
                searchCover.contentSize = CGSizeMake(320, (80*number_of_search)+90);
            }
        }
    }
}

- (void)addPersonToSearch:(Person*)person
{
    ContactView* searched = [[ContactView alloc] init];
    searched.delegate = self;
    [searched addDataPerson:person];
    [searched shiftView:number_of_search];
    [searchCover addSubview:searched];
}

- (void)slideSearchCover
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    searchCover.center = CGPointMake(160, 40+(searchCover.frame.size.height/2));
    [UIView commitAnimations];

}

- (void)slideSearchCoverOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    searchCover.center = CGPointMake(160, -300);
    [UIView commitAnimations];
    
}

- (void)logout
{
    [self popToMain];
    [command logout];
    [[self delegate] logout];

    NSArray* contacts = [content subviews];
    for (int i = 0; i < [contacts count]; i++)
    {
        [[contacts objectAtIndex:i] removeFromSuperview];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:3.0];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    requests_header.center = CGPointMake(160, 20);
    content.frame = CGRectMake(0, 40, 320, screenBounds.size.height - 100);
    [UIView commitAnimations];
    num_requests.text = [NSString stringWithFormat:@"0"];
    [requests_scroll reset];
    number_of_places = 0;
}

- (void)dismissKeyboard
{
    [self slideSearchCoverOut];
    search.text = @"";
    [search resignFirstResponder];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint point = scrollView.contentOffset;
    if (point.y <= -30)
    {
        UITextView* show = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 260, 25)];
        [show setTextColor:[UIColor DwollaDarkGray]];
        [show setBackgroundColor:[UIColor clearColor]];
        show.font = [UIFont fontWithName:@"GillSans-Bold" size:10];
        [show setText:@"Pull to refresh."];
        show.textAlignment = NSTextAlignmentCenter;
        [content addSubview:show];
        
    }
    if (point.y <= -90)
    {
        [[[content subviews] objectAtIndex:0] removeFromSuperview];
        NSArray* contacts = [content subviews];
        for (int i = 0; i < [contacts count]; i++)
        {
            [[contacts objectAtIndex:i] removeFromSuperview];
        }
        [command getNearby:capacity];
    }
    if (point.y >= content.contentSize.height - 300)
    {
        [[[content subviews] objectAtIndex:0] removeFromSuperview];
        NSArray* contacts = [content subviews];
        for (int i = 0; i < [contacts count]; i++)
        {
            [[contacts objectAtIndex:i] removeFromSuperview];
        }
        capacity += 5;
        [command getNearby:capacity];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
