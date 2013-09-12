//
//  Place.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/1/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject
{
    NSString* address;
    NSString* city;
    NSString* delta;
    NSString* group;
    NSString* dwolla_id;
    NSString* image;
    NSString* latitude;
    NSString* longitude;
    NSString* name;
    NSString* postal;
    NSString* state;
}

@property (retain) NSString* address;
@property (retain) NSString* city;
@property (retain) NSString* delta;
@property (retain) NSString* group;
@property (retain) NSString* dwolla_id;
@property (retain) NSString* image;
@property (retain) NSString* latitude;
@property (retain) NSString* longitude;
@property (retain) NSString* name;
@property (retain) NSString* postal;
@property (retain) NSString* state;

-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
