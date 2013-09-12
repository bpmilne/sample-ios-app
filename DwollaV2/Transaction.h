//
//  Transaction.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Transaction : NSObject
{
    NSString* amount;
    NSString* date;
    NSString* dwolla_id;
    NSString* name;
    NSString* trans_id;
    UIImage* image;
    NSString* type;
    NSString* user_type;
    NSString* status;
    NSString* clearingDate;
    NSString* note;
    BOOL isSend;
}

@property (retain) NSString* amount;
@property (retain) NSString* date;
@property (retain) NSString* dwolla_id;
@property (retain) NSString* name;
@property (retain) NSString* trans_id;
@property (retain) UIImage* image;
@property (retain) NSString* type;
@property (retain) NSString* user_type;
@property (retain) NSString* status;
@property (retain) NSString* clearingDate;
@property (retain) NSString* note;
@property BOOL isSend;

-(id)initWithDictionary:(NSDictionary*)dictionary;

-(BOOL)isEqualTo:(Transaction*)transaction;

@end