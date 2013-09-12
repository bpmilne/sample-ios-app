//
//  Request.m
//  DwollaV2
//
//  Created by Nick Schulze on 6/3/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "Request.h"

@implementation Request

@synthesize amount;
@synthesize date;
@synthesize req_id;
@synthesize source_name;
@synthesize source_id;
@synthesize source_image;
@synthesize source_type;
@synthesize dest_name;
@synthesize dest_id;
@synthesize dest_image;
@synthesize dest_type;
@synthesize status;
@synthesize youRequested;

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        amount = [[dictionary valueForKey:@"Amount"] stringValue];
        date = [dictionary valueForKey:@"DateRequested"];
        req_id= [dictionary valueForKey:@"Id"];
        status = [dictionary valueForKey:@"Status"];
        
        NSDictionary* source = [dictionary valueForKey:@"Source"];
        source_type = [source valueForKey:@"Type"];
        //source_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[source valueForKey:@"Image"]]]];
        source_id = [source valueForKey:@"Id"];
        source_name = [source valueForKey:@"Name"];
        
        NSDictionary* dest = [dictionary valueForKey:@"Destination"];
        dest_type = [dest valueForKey:@"Type"];
        //dest_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dest valueForKey:@"Image"]]]];
        dest_id = [dest valueForKey:@"Id"];
        dest_name = [dest valueForKey:@"Name"];
    }
    return self;
}

@end