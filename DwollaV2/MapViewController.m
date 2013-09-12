//
//  MapViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/22/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(0, -320, 320, screenBounds.size.height-100);
        [self.view setBackgroundColor:[UIColor clearColor]];
        
        map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height-100)];
        map.delegate = self;
        [self.view addSubview:map];
        
        UIButton* mapback = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 50, 30)];
        [mapback setImage:[UIImage imageNamed:@"dw_mapback.png"] forState:UIControlStateNormal];
        [mapback addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        mapback.backgroundColor = [UIColor clearColor];
        [self.view addSubview:mapback];
        
        places = [[NSMutableArray alloc] init];
        tag = 0;
    }
    return self;
}

- (void)centerMap:(CLLocation*) user_location
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=.05;
    span.longitudeDelta=.05;
    
    CLLocationCoordinate2D center = [user_location coordinate];
    region.span=span;
    region.center=center;
    
    [map setCenterCoordinate:center];
    [map setRegion:region];
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord = center;
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"You are here.";
    [map addAnnotation:annotationPoint];    
}

- (void)addToMap:(Place*)place;
{
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = [[place latitude] doubleValue];
    annotationCoord.longitude = [[place longitude] doubleValue];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = [place name];
    annotationPoint.subtitle = [place address];
    [places addObject:place];
    [map addAnnotation:annotationPoint];
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

    
    UIImage *originalImage2 = [UIImage imageNamed:@"dw_markero.png"];
    // scaling set to 2.0 makes the image 1/2 the size.
    UIImage *scaledImage2 =
    [UIImage imageWithCGImage:[originalImage2 CGImage]
                        scale:(originalImage2.scale * 2.0)
                  orientation:(originalImage2.imageOrientation)];
    annotationView.image = scaledImage2;
    if ([annotation.title isEqualToString:@"You are here."])
    {
        UIImage *originalImage = [UIImage imageNamed:@"dw_bmarker.png"];
        // scaling set to 2.0 makes the image 1/2 the size.
        UIImage *scaledImage =
        [UIImage imageWithCGImage:[originalImage CGImage]
                            scale:(originalImage.scale * 2.0)
                      orientation:(originalImage.imageOrientation)];
        annotationView.image = scaledImage;
    }
    else
    {
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [infoButton addTarget:self action:@selector(goToDetail:) forControlEvents:UIControlEventTouchUpInside];
        infoButton.tag = tag;
        tag += 1;
        annotationView.rightCalloutAccessoryView = infoButton;
    }
    annotationView.canShowCallout= YES;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D center = mapView.centerCoordinate;
    
    NSMutableArray* locations = [command placesNear:center];
    
    for (int i = 0; i < [locations count]; i++)
    {
    
        Place* place = [locations  objectAtIndex:i];
        CLLocationCoordinate2D annotationCoord;
        
        annotationCoord.latitude = [[place latitude] doubleValue];
        annotationCoord.longitude = [[place longitude] doubleValue];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = [place name];
        annotationPoint.subtitle = [place address];
        [places addObject:place];
        [map addAnnotation:annotationPoint];
    }

}

- (void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
}


- (void)goToDetail:(UIButton*)sender
{
    Place* place = [places objectAtIndex:sender.tag];
    [[self delegate] mapDetail:place];
}

-(void)closeMap
{
    [[self delegate] hideMap];
}


- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, 40+(self.view.frame.size.height/2));
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(closeMap)];
    self.view.center = CGPointMake(160, -screenBounds.size.height);
    [UIView commitAnimations];
}

- (void)destroy
{
    delegate = nil;
    [places removeAllObjects];
    places = nil;
    
    NSArray* subviews = [map subviews];

    for (int i = 0; i < [subviews count]; i++)
    {
        UIView* view = [subviews objectAtIndex:i];
        [view removeFromSuperview];
        view = nil;
    }

    [map removeFromSuperview];
    map.delegate = nil;
    map = nil;
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
