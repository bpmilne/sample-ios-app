//
//  UserViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/17/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "ContactView.h"


@interface ContactView ()

@end

@implementation ContactView

@synthesize delegate;
@synthesize isPlace;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(10, 10, 300, 70);
        [self setBackgroundColor:[UIColor clearColor]];

        
        arrowbg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 90, 50)];
        arrowbg.backgroundColor = [UIColor orangeColor];
        [self addSubview:arrowbg];
        
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
        bg.image = [UIImage imageNamed:@"dw_contactbg.png"];
        [self addSubview:bg];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        profile.backgroundColor = [UIColor clearColor];
        profile.opaque = YES;
        [bg addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(65, 10, 180, 25)];
        [bg addSubview:name];
        
        marker = [[UIImageView alloc] initWithFrame:CGRectMake(65, 38, 10, 15)];
        marker.image = [UIImage imageNamed:@"dw_marker.png"];
        [bg addSubview:marker];
        
        address = [[LightTextView alloc] initWithFrame:CGRectMake(70, 30, 170, 23)];
        [bg addSubview:address];
        
        distbg = [[UIImageView alloc] initWithFrame:CGRectMake(250, 35, 50, 20)];
        distbg.image = [UIImage imageNamed:@"dw_distbg.png"];
        [distbg setBackgroundColor:[UIColor DwollaGray]];
        [bg addSubview:distbg];
        
        distance = [[BoldTextView alloc] initWithFrame:CGRectMake(250, 30, 55, 20)];
        [distance setFont:[UIFont fontWithName:@"GillSans-Bold" size:12]];
        [distance setTextColor:[UIColor whiteColor]];
        [bg addSubview:distance];
        
        isPlace = YES;
    }
    return self;
}

- (void)addDataPerson:(Person*)person
{
    [self performSelectorInBackground:@selector(addImageInBackground:) withObject:[person image]];
    [name setText:[person name]];
    distance.hidden = YES;
    distbg.hidden = YES;
    marker.hidden = YES;
    dwolla_id = [person dwolla_id];
    isPlace = NO;
}

- (void)addDataPlace:(Place*)place distance:(double) _distance
{
    [self performSelectorInBackground:@selector(addImageInBackground:) withObject:[place image]];
    [name setText:[place name]];
    [address setText:[place address]];
    latitude = [place latitude];
    longitude = [place longitude];
    if (_distance < 245)
    {
        distance.text = [NSString stringWithFormat:@"%.f ft", (_distance / 3.28084)];
    }
    else
    {
        distance.text = [NSString stringWithFormat:@"%.01f mi", (_distance * .000621371)];
    }
    city = [place city];
    state = [place state];
    postal = [place postal];
    dwolla_id = [place dwolla_id];
    isPlace = YES;
}

- (void)shiftView:(int)i
{
    self.center = CGPointMake(160, 45+(80*i));
}

- (UIImage*)profile
{
    return profile.image;
}

- (void)setProfile:(UIImage*)image
{
    profile.image = image;
}

- (NSString*)name
{
    return name.text;
}

- (NSString*)address
{
    return address.text;
}

- (NSString*)distance
{
    return distance.text;
}

- (NSString*)latitude
{
    return latitude;
}

- (NSString*)longitude
{
    return longitude;
}

- (NSString*)city
{
    return city;
}

- (NSString*)state
{
    return  state;
}

- (NSString*)postal
{
    return postal;
}

- (NSString*) dwolla_id
{
    return dwolla_id;
}

-(void)forceImage:(NSString*)url
{
    [profile setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
}

-(void)addImageInBackground:(NSString*)url
{
    [profile setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self delegate] displayContact:self];
    [super touchesEnded: touches withEvent: event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
