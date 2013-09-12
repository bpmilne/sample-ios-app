//
//  User.h
//  DwollaV2
//
//  Created by Nick Schulze on 4/30/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "Person.h"
#import "ContactView.h"
#import "Transaction.h"
#import "Source.h"
#import "Request.h"
#import <CoreLocation/CoreLocation.h>

@interface User : NSObject
{
    NSString* dwolla_id;
    NSString* name;
    NSString* balance;
    NSMutableArray* places;
    NSMutableArray* people;
    NSMutableArray* transactions;
    NSMutableArray* sources;
    NSMutableArray* requests;
    UIImage* image;
    CLLocation* location;
}

@property (retain) NSString* balance;
@property (retain) NSString* dwolla_id;
@property (retain) NSString* name;
@property (retain) NSMutableArray* places;
@property (retain) NSMutableArray* people;
@property (retain) NSMutableArray* transactions;
@property (retain) NSMutableArray* sources;
@property (retain) NSMutableArray* requests;
@property (retain) CLLocation* location;
@property (retain) UIImage* image;

-(void)setNearby:(NSArray*)raw_contacts;

-(void)setContacts:(NSArray*)raw_contacts;

-(void)setInfo:(NSDictionary*)info;

-(void)setTransaction:(NSArray*)raw_transactions;

-(void)addTransactions:(NSArray*)raw_transactions;

-(void)setFundingSources:(NSArray *)raw_sources;

-(void)setRequest:(NSArray *)raw_requests;

- (void)reset;

@end
