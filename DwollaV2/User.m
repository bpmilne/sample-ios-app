//
//  User.m
//  DwollaV2
//
//  Created by Nick Schulze on 4/30/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize balance;
@synthesize dwolla_id;
@synthesize name;
@synthesize places;
@synthesize people;
@synthesize location;
@synthesize transactions;
@synthesize sources;
@synthesize image;
@synthesize requests;

-(void)setNearby:(NSArray*)raw_places
{
    places = [[NSMutableArray alloc] initWithCapacity:[raw_places count]];
    for (int i = 0; i < [raw_places count]; i++)
    {
        Place* place = [[Place alloc] initWithDictionary:[raw_places objectAtIndex:i]];
        [places addObject:place];
    }
}

-(void)setContacts:(NSArray*)raw_people
{
    people = [[NSMutableArray alloc] init];
    for (int i = 0; i < [raw_people count]; i++)
    {
        Person* person = [[Person alloc] initContactsWithDictionary:[raw_people objectAtIndex:i]];
        [people addObject:person];
    }
}

-(void)setInfo:(NSDictionary*)info
{
    dwolla_id = [info valueForKey:@"Id"];
    name = [info valueForKey:@"Name"];
}

-(void)setTransaction:(NSArray*)raw_transactions
{
    transactions = [[NSMutableArray alloc] initWithCapacity:[raw_transactions count]];
    for (int i = 0; i < [raw_transactions count]; i++)
    {
        Transaction* transaction = [[Transaction alloc] initWithDictionary:[raw_transactions objectAtIndex:i]];
        [transactions addObject:transaction];
    }
}

-(void)addTransactions:(NSArray*)raw_transactions
{
    for (int i = 0; i < [raw_transactions count]; i++)
    {
        Transaction* transaction = [[Transaction alloc] initWithDictionary:[raw_transactions objectAtIndex:i]];
        [transactions addObject:transaction];
    }
}

-(void)setFundingSources:(NSArray *)raw_sources
{
    sources = [[NSMutableArray alloc] init];
    for (int i = 0; i < [raw_sources count]; i++)
    {
        Source* source = [[Source alloc] initWithDictionary:[raw_sources objectAtIndex:i]];
        [sources addObject:source];
    }
}

-(void)setRequest:(NSArray *)raw_requests
{
    requests = [[NSMutableArray alloc] init];
    for (int i = 0; i < [raw_requests count]; i++)
    {
        NSDictionary* dict = [raw_requests objectAtIndex:i];
        Request* request = [[Request alloc] initWithDictionary:dict];
        if ([[request source_id] isEqualToString:dwolla_id])
        {
            [request setYouRequested:YES];
        }
        else
        {
            [request setYouRequested:NO];
        }
        [requests addObject:request];
    }
}

- (void)reset
{
    places = nil;
    people = nil;
    balance = nil;
    dwolla_id = nil;
    name = nil;
    balance = nil;
    transactions = nil;
    sources = nil;
    requests = nil;
    image = nil;
    location = nil;
}

@end
