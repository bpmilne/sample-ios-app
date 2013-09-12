//
//  CommandCenter.m
//  DwollaV2
//
//  Created by Nick Schulze on 9/30/12.
//  Copyright (c) 2012 Iowa State University. All rights reserved.
//

#import "CommandCenter.h"
#import <Security/Security.h>

@implementation CommandCenter

@synthesize delegate;

-(id)init
{
    self = [super init];
    if (self)
    {
        api = [[DwollaAPI alloc] init];
        api.delegate = self;
        user = [[User alloc] init];
    }
    return self;
}

-(void) sendTimeout:(NSData *)data
{
    timeoutData = data;
    //[[self delegate] handleTimeout:self];
}

-(void)displayError:(NSString*)error
{
    [[self delegate] displayError:error];
}

-(void)logout
{
    [SSKeychain deletePasswordForService:@"token" account:@"dwolla2"];
    [api logout];
    [user reset];
}

-(BOOL)didRemember
{
    if ([api didRemember])
    {
        [self getLocation];
        [self performSelectorInBackground:@selector(getBalance) withObject:nil];
        return YES;
    }
    else
    {
        return NO;
    }
}

-(NSString*)login:(NSString*)code remember:(BOOL)remember
{
    NSString* response =  [api setAccessToken:code];
    if (remember && [response isEqualToString:@"success"])
    {
        [api remember];
    }
    
    if ([response isEqualToString:@"success"])
    {
        [self getLocation];
        [self performSelectorInBackground:@selector(getBalance) withObject:nil];
    }
    else
    {
        
    }
    return response;
}

-(void)getLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

-(CLLocation*)userLocation
{
    return [user location];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* location;
    if(![CLLocationManager locationServicesEnabled])
    {
        [[self delegate] displayError:@"Location Services are currently disabled. To re-enable, please go to Settings and turn on Location Services for this app. A default location will be used unti then."];
        location = [[CLLocation alloc] initWithLatitude:41.585549 longitude:-93.625449];
    }
    else
    {
        location = [locations lastObject];
    }
    [user setLocation:location];
    [manager stopUpdatingLocation];
}

-(void)getBalance
{
    [api setUserBalance:user];
    [self getInfo];
    [self performSelectorInBackground:@selector(getTransactions) withObject:nil];
    [[self delegate] displayBalance];
}

-(void)getRequests
{
    [api setUserRequests:user];
    [[self delegate] displayRequests];
}

-(NSMutableArray*)userRequests
{
    return [user requests];
}

-(void)getInfo
{
    [api setUserInfo:user];
    [api setUserImage:user];
    [self performSelectorInBackground:@selector(getRequests) withObject:nil];
    [self getNearby:15];
}

-(NSMutableArray*)userInfo
{
    //[self getInfo];
    return [[NSMutableArray alloc] initWithObjects:[user dwolla_id], [user name], [user image], nil];
}

-(UIImage*)userImage
{
    return [user image];
}

-(NSString*)userBalance
{
    return [user balance];
}

-(NSMutableArray*)userTransactions
{
    if ([user transactions] == nil)
    {
        [self getTransactions];
    }
    return [user transactions];
}

-(void)getTransactions
{
    [api setUserTransactions:user offset:0];
}

-(NSMutableArray*)getTransactionsWithOffset:(int)offset
{
    [api setUserTransactions:user offset:offset];
    return [user transactions];
}

-(void)getNearby:(int)number
{
    if(![CLLocationManager locationServicesEnabled])
    {
        [[self delegate] displayError:@"Location Services are currently disabled. To re-enable, please go to Settings and turn on Location Services for this app. A default location will be used unti then."];
    }
    [api setNearbyPlaces:user number:number];
    [api setNearbyPeople:user];
    [[self delegate] displayNearby];
}

-(NSMutableArray*)userNearby
{
    return [user places];
}

-(NSMutableArray*)userNearbyPeople
{
    return [user people];
}

-(NSMutableArray*)placesNear:(CLLocationCoordinate2D)location
{
    return [api placesNear:location];
}

- (void)getSources
{
    [api setUserSources:user];
}

- (NSMutableArray*)userSources
{
    [self getSources];
    return [user sources];
}

- (NSString*)depositMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount
{
    NSString* response = [api depositMoney:pin source_id:source amount:amount];
    return response;
}

- (NSString*)withdrawMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount
{
    NSString* response = [api withdrawMoney:pin source_id:source amount:amount];
    return response;
}

-(BOOL)sendMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount name:(NSString*)name image:(UIImage*)image note:(NSString*)note
{
    NSString* response = [api sendMoney:pin dwolla_id:dwolla_id amount:amount note:note];
    if ([response isEqualToString:@"Success"])
    {
        [[self delegate] displayReceipt:image name:name amount:amount note:note type:@"SENT"];
        [self getBalance];
        return YES;
    }
    else
    {
        //[[self delegate] displayError:@"error"];
        return NO;
    }
}

-(BOOL)requestMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount name:(NSString*)name image:(UIImage*)image note:(NSString*)note
{
    NSString* response = [api requestMoney:pin dwolla_id:dwolla_id amount:amount note:note];
    if ([response isEqualToString:@"Success"])
    {
        [[self delegate] displayReceipt:image name:name amount:amount note:note type:@"REQUESTED"];
        [self getBalance];
        return NO;
    }
    else
    {
        //[[self delegate] displayError:@"error"];
        return YES;
    }
}

-(void)payRequest:(NSString*)r_id pin:(NSString*)pin amount:(NSString*)amount
{
    [api payRequest:r_id pin:pin amount:amount];
    [self getBalance];
}

-(void)cancelRequest:(NSString*)r_id
{
    [api cancelRequest:r_id];
    [self getBalance];
}

-(NSMutableArray*)getContacts
{
    [api setUserContacts:user];
    return [user people];
}

- (UIImage*)getAvatar:(NSString*)dw_id
{
    return [api getAvatar:dw_id];
}

- (Person*)getBasicInfo:(NSString*)dwolla_id
{
    NSDictionary* holder = [api getBasicInfo:dwolla_id];    
    Person* person = [[Person alloc] initContactsWithDictionary:holder];
    if ([person.name isEqualToString:@"empty"]) 
    {
        person.name = dwolla_id;
        person.dwolla_id = dwolla_id;
    }
    [person setImage:[api getAvatarURL:person.dwolla_id]];
    return person;
}

- (NSMutableArray*)searchContacts:(NSString*)search
{
    NSArray* holder = [api searchContacts:search];
    NSMutableArray* people = [[NSMutableArray alloc] init];
    for (int i = 0; i<[holder count]; i++)
    {
        Person* person = [[Person alloc] initContactsWithDictionary:[holder objectAtIndex:i]];
        [people addObject:person];
    }
    return people;
}

- (BOOL)setAccessToken:(NSString*)code
{
    return [api setAccessToken:code];
}

@end
