//
//  People.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/1/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize dwolla_id;
@synthesize image;
@synthesize latitude;
@synthesize longitude;
@synthesize name;
@synthesize delta;
@synthesize type;

-(id)initContactsWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        if ([dictionary count] == 1)
        {
            name = @"empty";
        }
        else
        {
        dwolla_id = [dictionary valueForKey:@"Id"];
        image = [dictionary valueForKey:@"Image"];
        latitude = @"";
        longitude = @"";
        name = [dictionary valueForKey:@"Name"];
        delta = @"";
        type = [dictionary valueForKey:@"Type"];
        }
        
    }
    return self;
}
@end
