//
//  Place.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/1/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize address;
@synthesize city;
@synthesize delta;
@synthesize group;
@synthesize dwolla_id;
@synthesize image;
@synthesize latitude;
@synthesize longitude;
@synthesize name;
@synthesize postal;
@synthesize state;

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        address = [dictionary valueForKey:@"Address"];
        city = [dictionary valueForKey:@"City"];
        delta = [dictionary valueForKey:@"Delta"];
        group = [dictionary valueForKey:@"Group"];
        dwolla_id = [dictionary valueForKey:@"Id"];
        image = [dictionary valueForKey:@"Image"];
        latitude = [dictionary valueForKey:@"Latitude"];
        longitude = [dictionary valueForKey:@"Longitude"];
        name = [dictionary valueForKey:@"Name"];
        postal = [dictionary valueForKey:@"PostalCode"];
        state = [dictionary valueForKey:@"State"];

    }
    return self;
}
@end
