//
//  Person.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/1/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString* dwolla_id;
    NSString* image;
    NSString* latitude;
    NSString* longitude;
    NSString* name;
    NSString* delta;
    NSString* type;
}

@property (retain) NSString* dwolla_id;
@property (retain) NSString* image;
@property (retain) NSString* latitude;
@property (retain) NSString* longitude;
@property (retain) NSString* name;
@property (retain) NSString* delta;
@property (retain) NSString* type;

-(id)initContactsWithDictionary:(NSDictionary*)dictionary;

@end