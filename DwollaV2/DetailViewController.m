//
//  DetailViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/18/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(320, 0, 320, screenBounds.size.height+60);
        self.view.backgroundColor = [UIColor DwollaGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 50, 300, 140)];
        [top setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:top];
        
        exchangebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
        [exchangebg setBackgroundColor:[UIColor whiteColor]];
        [top addSubview:exchangebg];
        
        button_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 300, 70)];
        [button_bar setBackgroundColor:[UIColor whiteColor]];
        [top addSubview:button_bar];
        
        request = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 135, 50)];
        [request setImage:[UIImage imageNamed:@"dw_request.png"] forState:UIControlStateNormal];
        [request addTarget:self action:@selector(beginRequest) forControlEvents:UIControlEventTouchUpInside];
        [button_bar addSubview:request];
        
        send = [[UIButton alloc] initWithFrame:CGRectMake(155, 10, 135, 50)];
        [send setImage:[UIImage imageNamed:@"dw_send.png"] forState:UIControlStateNormal];
        [send addTarget:self action:@selector(beginSend) forControlEvents:UIControlEventTouchUpInside];
        [button_bar addSubview:send];
        
        amount_bar = [[RoundedView alloc] initWithFrame:CGRectMake(0, 22, 300, 50)];
        [amount_bar setBackgroundColor:[UIColor whiteColor]];
        [top addSubview:amount_bar];
        
        amount = [[LightTextView alloc] initWithFrame:CGRectMake(170, 5, 120, 40)];
        amount.textAlignment = NSTextAlignmentRight;
        [amount setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        amount.text = @"$0.00";
        [amount_bar addSubview:amount];
        
        note_button = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
        [note_button setImage:[UIImage imageNamed:@"dw_note.png"] forState:UIControlStateNormal];
        [note_button addTarget:self action:@selector(note) forControlEvents:UIControlEventTouchUpInside];
        [amount_bar addSubview:note_button];
        
        UIView* topHide = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
        topHide.backgroundColor = [UIColor whiteColor];
        [top addSubview:topHide];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [topHide addSubview:dash];
        
        profile = [[RoundedImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [profile setBackgroundColor:[UIColor clearColor]];
        profile.opaque = YES;
        [top addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(65, 20, 200, 25)];
        [top addSubview:name];
        
        bottom = [[RoundedView alloc] initWithFrame:CGRectMake(10, 200, 300, 210)];
        [self.view addSubview:bottom];
        
        map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 300, 105)];
        [map setDelegate:self];
        [bottom addSubview:map];
        
        detailbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 105, 300, 105)];
        [detailbg setBackgroundColor:[UIColor whiteColor]];
        [bottom addSubview:detailbg];
        
        street = [[UITextView alloc] initWithFrame:CGRectMake(10, 110, 180, 25)];
        [street setBackgroundColor:[UIColor clearColor]];
        [street setUserInteractionEnabled:NO];
        [street setTextColor:[UIColor DwollaDarkGray]];
        [street setFont:[UIFont fontWithName:@"GillSans" size:14]];
        [bottom addSubview:street];
        
        city = [[UITextView alloc] initWithFrame:CGRectMake(10, 125, 180, 25)];
        [city setBackgroundColor:[UIColor clearColor]];
        [city setUserInteractionEnabled:NO];
        [city setTextColor:[UIColor DwollaDarkGray]];
        [city setFont:[UIFont fontWithName:@"GillSans" size:14]];
        [bottom addSubview:city];
        
        distancebg = [[UIImageView alloc] initWithFrame:CGRectMake(250, 115, 50, 20)];
        distancebg.image = [UIImage imageNamed:@"dw_distbg.png"];
        [bottom addSubview:distancebg];
        
        distance = [[BoldTextView alloc] initWithFrame:CGRectMake(245, 110, 55, 20)];
        [distance setFont:[UIFont fontWithName:@"GillSans-Bold" size:12]];
        [distance setTextColor:[UIColor whiteColor]];
        [bottom addSubview:distance];
        
        UIImageView* dash2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 300, 2)];
        dash2.image = [UIImage imageNamed:@"dw_dash.png"];
        [dash2 setBackgroundColor:[UIColor grayColor]];
        [bottom addSubview:dash2];
        
        directions = [[UIButton alloc] initWithFrame:CGRectMake(84, 165, 125, 36)];
        [directions setImage:[UIImage imageNamed:@"dw_directions.png"] forState:UIControlStateNormal];
        [directions addTarget:self action:@selector(openInMaps) forControlEvents:UIControlEventTouchUpInside];
        [bottom addSubview:directions];
        
        keyboard = [[KeyboardViewController alloc] init];
        [keyboard addTextView:amount];
        [self.view addSubview:keyboard.view];
        
        pin_background = [[UIView alloc] initWithFrame:CGRectMake(0, -200, 320, 188)];
        pin_background.backgroundColor = [UIColor DwollaGray];
        [self.view addSubview:pin_background];
        
        pin_view = [[PinView alloc] init];
        [self.view addSubview:pin_view];
        
        confirm_view = [[ConfirmView alloc] init];
        [confirm_view setDelegate:self];
        [self.view addSubview:confirm_view];
        
        note = [[RoundedView alloc] initWithFrame:CGRectMake(10, 10, 300, 260)];
        note.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:note];
        note.hidden = YES;
        
        UIImageView* dash3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 300, 2)];
        dash3.image = [UIImage imageNamed:@"dw_dash.png"];
        [note addSubview:dash3];
        
        UIButton* close = [[UIButton alloc] initWithFrame:CGRectMake(265, 15, 20, 20)];
        [close setImage:[UIImage imageNamed:@"dw_x.png"] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(dismissNote) forControlEvents:UIControlEventTouchUpInside];
        close.backgroundColor = [UIColor clearColor];
        [note addSubview:close];
        
        BoldTextView* note_title = [[BoldTextView alloc] initWithFrame:CGRectMake(35, 10, 230, 25)];
        note_title.textAlignment = NSTextAlignmentCenter;
        [note_title setText:@"NOTE"];
        [note addSubview:note_title];
        
        save_note = [[UIButton alloc] initWithFrame:CGRectMake(10, 190, 280, 40)];
        [save_note setImage:[UIImage imageNamed:@"dw_savenote.png"] forState:UIControlStateNormal];
        [save_note addTarget:self action:@selector(hideNote) forControlEvents:UIControlEventTouchUpInside];
        [note addSubview:save_note];
        
        note_content = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 280, 130)];
        note_content.backgroundColor = [UIColor clearColor];
        [note addSubview:note_content];
        
        
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
        [self.view addSubview:nav];
        UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"DETAIL"];
        
        UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
        [backb addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        backb.bounds = CGRectMake( 0, 0, 50, 30 );
        [backb setBackgroundImage:[UIImage imageNamed:@"dw_home.png"] forState:UIControlStateNormal];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
        [detail_header setRightBarButtonItem:back];
        [nav pushNavigationItem:detail_header animated:NO];

    }
    return self;
}

- (void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
    [confirm_view addCommandCenter:command];
}

- (void)addNavigation:(UINavigationBar*)bar
{
    nav = bar;
}

- (void)addContact:(ContactView*)contact
{
    profile.image = [contact profile];
    name.text = [contact name];
    distance.text = [contact distance];
    dwolla_id = [contact dwolla_id];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.005;
    span.longitudeDelta=0.005;
    
    if ([contact isPlace])
    {
    [bottom_sc removeFromSuperview];
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake([[contact latitude] doubleValue], [[contact longitude] doubleValue]);    region.span=span;
    region.center=center;
    
    latitude = [contact latitude];
    longitude = [contact longitude];
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = [latitude doubleValue];
    annotationCoord.longitude = [longitude doubleValue];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    [map addAnnotation:annotationPoint];
    
    [map setCenterCoordinate:center];
    [map setRegion:region];
    street.text = [contact address];
    city.text = [NSString stringWithFormat:@"%@, %@ %@", [contact city], [contact state], [contact postal]];
    
    distance.text = [contact distance];
    }
    else
    {
        bottom_sc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 210)];
        [bottom_sc setBackgroundColor:[UIColor DwollaGray]];
        [bottom addSubview:bottom_sc];
        
        UITextView* nearby_people = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        [nearby_people setTextColor:[UIColor DwollaDarkGray]];
        [nearby_people setScrollEnabled:NO];
        [nearby_people setBackgroundColor:[UIColor clearColor]];
        [nearby_people setText:@"People Near You"];
        [nearby_people setFont:[UIFont fontWithName:@"GillSans" size:16]];
        [bottom_sc addSubview:nearby_people];
        
        UIScrollView* content = [[UIScrollView alloc] initWithFrame:CGRectMake(-5, 30, 300, 180)];
        [content setBackgroundColor:[UIColor DwollaGray]];
        [bottom_sc addSubview:content];
        
        NSMutableArray* people = [command userNearbyPeople];
                
        content.contentSize = CGSizeMake(300, ([people count]*80)+10);
        for (int i = 0; i < [people count]; i++)
        {
            ContactView* contact = [[ContactView alloc] init];
            [contact addDataPerson:[people objectAtIndex:i]];
            [contact shiftView:i];
            [content addSubview:contact];
        }
    }
    
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
    [self.view addSubview:nav];
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"DETAIL"];
    
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_home.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [detail_header setLeftBarButtonItem:back];
    [nav pushNavigationItem:detail_header animated:NO];
}

- (void)addTransasction:(TransactionReceiptView*)transaction
{
    profile.image = [transaction profile];
    name.text = [transaction name];
    amount.text = [transaction amount];
    
    dwolla_id = [transaction dwolla_id];
    
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

    [self.view addSubview:nav];
    
    
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"DETAIL"];
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(popToMain) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_home.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    
    [detail_header setLeftBarButtonItem:back];
    [nav pushNavigationItem:detail_header animated:NO];
}

- (void)beginSend
{
    [self slideButtonBarUp];
    [confirm_view setAsSend];
    amount_bar.hidden = NO;
    keyboard.view.hidden = NO;
    [nav popNavigationItemAnimated:NO];
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"SEND MONEY"];
    
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_home.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [detail_header setLeftBarButtonItem:back];
    
    UIButton *pinb = [UIButton buttonWithType:UIButtonTypeCustom];
    [pinb addTarget:self action:@selector(goToPIN) forControlEvents:UIControlEventTouchUpInside];
    pinb.bounds = CGRectMake( 0, 0, 50, 30 );
    [pinb setBackgroundImage:[UIImage imageNamed:@"dw_pin.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem* pin = [[UIBarButtonItem alloc] initWithCustomView:pinb];
    [detail_header setRightBarButtonItem:pin];
    
    [nav pushNavigationItem:detail_header animated:YES];

}

- (void)popToMain
{
    pin_background.hidden = YES;
    button_bar.hidden = NO;
    amount_bar.hidden = YES;
    [keyboard slideOut];
    [keyboard addTextView:amount];
    amount.text = @"$0.00";
    [pin_view reset];
    [self slideOut];
}

- (void)goToPIN
{
    [self slidePinDown];
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"ENTER PIN"];
    
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(popToAmount) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_edit.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [detail_header setLeftBarButtonItem:back];
    
    UIButton *confirmb = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmb addTarget:self action:@selector(goToConfirm) forControlEvents:UIControlEventTouchUpInside];
    confirmb.bounds = CGRectMake( 0, 0, 60, 30 );
    [confirmb setBackgroundImage:[UIImage imageNamed:@"dw_confirmb.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem* confirm = [[UIBarButtonItem alloc] initWithCustomView:confirmb];
    [detail_header setRightBarButtonItem:confirm];
    [nav pushNavigationItem:detail_header animated:YES];

    pin_background.hidden = NO;
    pin_view.hidden = NO;
    [keyboard addPINView:pin_view];
}

- (void)popToAmount
{
    [nav popNavigationItemAnimated:YES];
    [keyboard addTextView:amount];
    [self slidePinUp];
    [self slideConfirmOut];
}

- (void)goToConfirm
{
    [nav popNavigationItemAnimated:NO];
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"CONFIRM"];
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(popToAmount) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_edit.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithCustomView:backb];    [detail_header setLeftBarButtonItem:back];
    [nav pushNavigationItem:detail_header animated:YES];
    
    [confirm_view setEverything:profile.image name:name.text total:amount.text dwolla_id:dwolla_id pin:[pin_view getPIN] note:note_holder];
    [keyboard addPINView:pin_view];
    [self slideConfirmIn];
}

- (void)beginRequest
{
    [self slideButtonBarUp];
    [confirm_view setAsRequest];
    amount_bar.hidden = NO;
    keyboard.view.hidden = NO;
    [nav popNavigationItemAnimated:NO];
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"REQUEST MONEY"];

    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(popToMain) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_home.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [detail_header setLeftBarButtonItem:back];
    
    UIButton *pinb = [UIButton buttonWithType:UIButtonTypeCustom];
    [pinb addTarget:self action:@selector(goToPIN) forControlEvents:UIControlEventTouchUpInside];
    pinb.bounds = CGRectMake( 0, 0, 50, 30 );
    [pinb setBackgroundImage:[UIImage imageNamed:@"dw_pin.png"] forState:UIControlStateNormal];
    UIBarButtonItem* pin = [[UIBarButtonItem alloc] initWithCustomView:pinb];

    [detail_header setRightBarButtonItem:pin];
    [nav pushNavigationItem:detail_header animated:YES];
}

- (void)openInMaps
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:name.text];
        
        // Set the directions mode to "Walking"
        // Can use MKLaunchOptionsDirectionsModeDriving instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)note
{
    [self.view bringSubviewToFront:note];
    note.hidden = NO;
    keyboard.view.hidden = YES;
    [note_content becomeFirstResponder];
}

- (void)hideNote
{
    note_holder = note_content.text;
    note.hidden = YES;
    [confirm_view setNote:note_content.text];
    keyboard.view.hidden = NO;
    [note_content resignFirstResponder];
}

- (void)dismissNote
{
    note_content.text = note_holder;
    [self hideNote];
}

- (void)detailReset
{
    pin_view.textview.text = @"";
    [self popToMain];
}

- (void)backToPin
{
    [self popToAmount];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    NSString *annotationIdentifier = @"CustomViewAnnotation";
    MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if(!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:annotationIdentifier];
    }
    annotationView.image = [UIImage imageNamed:@"dw_marker.png"];
    annotationView.canShowCallout= YES;
    
    return annotationView;
}

- (void)reset
{
    button_bar.hidden = NO;
    amount_bar.hidden = YES;
    keyboard.view.hidden = YES;
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    if (screenBounds.size.height == 568)
    {
        self.view.center = CGPointMake(160, (screenBounds.size.height-30)/2 + 44);
    }
    else
    {
        self.view.center = CGPointMake(160, (screenBounds.size.height-30)/2 + 44);
    }
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideDetail)];
    if (screenBounds.size.height == 568)
    {
        self.view.center = CGPointMake(480, (screenBounds.size.height-30)/2 + 44);
    }
    else
    {
        self.view.center = CGPointMake(480, (screenBounds.size.height-30)/2 + 44);
    }
    [UIView commitAnimations];
}

- (void)slideButtonBarUp
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDidStopSelector:@selector(slideAmountDown)];
    [UIView setAnimationDelegate:self];
    button_bar.center = CGPointMake(150, 35);
    [UIView commitAnimations];
}

- (void)slideAmountDown
{
    [keyboard slideIn];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    amount_bar.center = CGPointMake(150, 97);
    [UIView commitAnimations];
}

- (void)slidePinDown
{
    [pin_view slideDown];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    pin_background.center = CGPointMake(160, 94);
    [UIView commitAnimations];
}

- (void)slidePinUp
{
    [pin_view revert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.15];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    pin_background.center = CGPointMake(160, -130);
    [UIView commitAnimations];
}

- (void)slideConfirmIn
{
    [confirm_view slideIn];
    [self performSelector:@selector(slidePinUp) withObject:nil afterDelay:1.0];
}

- (void)slideConfirmOut
{
    [confirm_view slideOut];
}

- (void)revert
{
    button_bar.center = CGPointMake(150, 105);
    amount_bar.center = CGPointMake(150, 47);
    [pin_view revert];
    [self slideConfirmOut];
    [self slidePinUp];
}

- (void)hideDetail
{
    [[self delegate] closeDetail];
}

- (void)destroy
{
    [top removeFromSuperview];
    top = nil;
    [button_bar removeFromSuperview];
    button_bar = nil;
    [request removeFromSuperview];
    request = nil;
    [send removeFromSuperview];
    send = nil;
    [exchangebg removeFromSuperview];
    exchangebg = nil;
    [profile removeFromSuperview];
    profile = nil;
    [name removeFromSuperview];
    name = nil;
    [amount_bar removeFromSuperview];
    amount_bar = nil;
    [amount removeFromSuperview];
    amount = nil;
    
    [bottom removeFromSuperview];
    bottom = nil;
    [map removeFromSuperview];
    NSArray* subviews = [map subviews];
    
    for (int i = 0; i < [subviews count]; i++)
    {
        UIView* view = [subviews objectAtIndex:i];
        [view removeFromSuperview];
        view = nil;
    }
    map.delegate = nil;
    map = nil;
    [detailbg removeFromSuperview];
    detailbg = nil;
    [street removeFromSuperview];
    street = nil;
    [city removeFromSuperview];
    city = nil;
    [distancebg removeFromSuperview];
    distancebg = nil;
    [distance removeFromSuperview];
    distance = nil;
    [directions removeFromSuperview];
    directions = nil;
    [number removeFromSuperview];
    number = nil;
    
    [keyboard removeFromParentViewController];
    [keyboard.view removeFromSuperview];
    [keyboard destroy];
    keyboard = nil;
    [pin_background removeFromSuperview];
    pin_background = nil;
    [pin_view removeFromSuperview];
    pin_view = nil;
    [bottom_sc removeFromSuperview];
    bottom_sc = nil;
    
    [confirm_view removeFromSuperview];
    [confirm_view destroy];
    confirm_view = nil;
    
    [note_button removeFromSuperview];
    note_button = nil;
    [note removeFromSuperview];
    note = nil;
    [note_content removeFromSuperview];
    note_content = nil;
    [save_note removeFromSuperview];
    save_note = nil;
    
    [nav removeFromSuperview];
    nav = nil;
    command = nil;
    dwolla_id = nil;
    note_holder = nil;
    delegate = nil;
    
    subviews = [self.view subviews];
    
    for (int i = 0; i < [subviews count]; i++)
    {
        UIView* view = [subviews objectAtIndex:i];
        [view removeFromSuperview];
        view = nil;
    }
    subviews = nil;
    latitude = nil;
    longitude = nil;
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
