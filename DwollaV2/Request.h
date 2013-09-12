//
//  Request.h
//  DwollaV2
//
//  Created by Nick Schulze on 6/3/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject
{
    NSString* amount;
    NSString* date;
    NSString* req_id;
    NSString* source_name;
    NSString* source_id;
    UIImage*  source_image;
    NSString* source_type;
    NSString* dest_name;
    NSString* dest_id;
    UIImage*  dest_image;
    NSString* dest_type;
    NSString* status;
    BOOL youRequested;
}

@property (retain) NSString* amount;
@property (retain) NSString* date;
@property (retain) NSString* req_id;
@property (retain) NSString* source_name;
@property (retain) NSString* source_id;
@property (retain) UIImage*  source_image;
@property (retain) NSString* source_type;
@property (retain) NSString* dest_name;
@property (retain) NSString* dest_id;
@property (retain) UIImage*  dest_image;
@property (retain) NSString* dest_type;
@property (retain) NSString* status;
@property BOOL youRequested;

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
