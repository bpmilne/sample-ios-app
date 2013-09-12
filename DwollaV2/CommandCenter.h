//
//  CommandCenter.h
//  DwollaV2
//
//  Created by Nick Schulze on 9/30/12.
//  Copyright (c) 2012 Iowa State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DwollaAPI.h"

@class CommandCenter;
@protocol CommandCenterDelegate <NSObject> 

@optional
@required
-(void)logout;
-(void)displayBalance;
-(void)displayRequests;
-(void)displayNearby;
-(void)displayReceipt:(UIImage*)image name:(NSString*)name amount:(NSString*)amount note:(NSString*)note type:(NSString*)_type;
-(void)displayError:(NSString*)error;

@end

@interface CommandCenter : NSObject <CLLocationManagerDelegate, DwollAPIDelegate>
{
    NSData* timeoutData;
    id <CommandCenterDelegate> delegate;
    CLLocationManager* locationManager;
    User* user;
    DwollaAPI* api;
}

@property (nonatomic, retain) id <CommandCenterDelegate> delegate;

-(void)sendTimeout:(NSData*)data;

-(NSString*)login:(NSString*)code remember:(BOOL)remember;

-(BOOL)didRemember;

- (void)logout;

-(void)getLocation;

-(CLLocation*)userLocation;

-(void)getBalance;

-(void)getInfo;

-(void)getRequests;

-(NSMutableArray*)userRequests;

-(NSMutableArray*)userInfo;

-(NSString*)userBalance;

-(void)getNearby:(int)number;

-(NSMutableArray*)userNearby;

-(NSMutableArray*)userNearbyPeople;

-(NSMutableArray*)placesNear:(CLLocationCoordinate2D)location;

-(NSMutableArray*)userTransactions;

-(void)getTransactions;

- (NSMutableArray*)userSources;

- (void)getSources;

- (NSString*)depositMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount;

- (NSString*)withdrawMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount;

-(BOOL)sendMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount name:(NSString*)name image:(UIImage*)image note:(NSString*)note;

-(BOOL)requestMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount name:(NSString*)name image:(UIImage*)image note:(NSString*)note;

-(void)payRequest:(NSString*)r_id pin:(NSString*)pin amount:(NSString*)amount;

-(void)cancelRequest:(NSString*)r_id;

-(NSMutableArray*)getContacts;

- (UIImage*)getAvatar:(NSString*)dw_id;

- (UIImage*)userImage;

- (Person*)getBasicInfo:(NSString*)dwolla_id;

- (NSMutableArray*)searchContacts:(NSString*)search;

-(NSMutableArray*)getTransactionsWithOffset:(int)offset;

- (BOOL)setAccessToken:(NSString*)code;

@end