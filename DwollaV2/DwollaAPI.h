//
//  DwollaAPI.h
//  DwollaV2
//
//  Created by Nick Schulze on 4/30/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "User.h"
#import "NSString+URLEncoding.h"
#import "SSKeychain.h"
#import <Security/Security.h>

@class DwollaAPI;
@protocol DwollAPIDelegate <NSObject>

@optional
@required
-(void)displayError:(NSString*)error;

@end

@interface DwollaAPI : NSObject 
{
    NSString* access_token;
    id<DwollAPIDelegate> delegate;
}

@property id<DwollAPIDelegate> delegate;

-(void)remember;

-(BOOL)didRemember;

-(void)logout;

-(void)setUserBalance:(User*)user;

-(void)setUserInfo:(User*)user;

-(void)setUserImage:(User*)user;

-(void)setUserContacts:(User*)user;

-(void)setNearbyPlaces:(User*)user number:(int)number;

-(void)setNearbyPeople:(User*)user;

-(NSMutableArray*)placesNear:(CLLocationCoordinate2D)location;

-(void)setUserTransactions:(User*)user offset:(int)offset;

-(void)setUserSources:(User*)user;

-(NSString*)sendMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount note:(NSString*)note;

-(NSString*)requestMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount note:(NSString*)note;

-(void)payRequest:(NSString*)r_id pin:(NSString*)pin amount:(NSString*)amount;

-(void)cancelRequest:(NSString*)r_id;

- (NSString*)depositMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount;

- (NSString*)withdrawMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount;

-(NSDictionary*)generateDictionaryWithData:(NSData*)data;

- (UIImage*)getAvatar:(NSString*)dw_id;

- (NSString*)getAvatarURL:(NSString*)dw_id;

- (NSDictionary*)getBasicInfo:(NSString*)dwolla_id;

- (NSArray*)searchContacts:(NSString*)_search;

- (void)setUserRequests:(User*)user;

- (NSString*)setAccessToken:(NSString*)code;

- (NSArray*)makeGetRequest:(NSString*)url;

- (NSArray*)makePostRequest:(NSString*)url string:(NSString*)post;

@end
