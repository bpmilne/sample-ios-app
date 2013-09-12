//
//  Source.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/23/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "Source.h"

@implementation Source

@synthesize source_id;
@synthesize name;

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        source_id = [dictionary valueForKey:@"Id"];
        name = [dictionary valueForKey:@"Name"];
        type = [dictionary valueForKey:@"Type"];
        verified = [dictionary valueForKey:@"Verified"];
        processing_type = [dictionary valueForKey:@"ProcessingType"];
    }
    return self;
}

@end
