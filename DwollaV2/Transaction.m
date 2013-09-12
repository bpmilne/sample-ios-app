//
//  Transaction.m
//  DwollaV2
//
//  Created by Nick Schulze on 5/15/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

@synthesize amount;
@synthesize date;
@synthesize dwolla_id;
@synthesize name;
@synthesize trans_id;
@synthesize image;
@synthesize type;
@synthesize user_type;
@synthesize status;
@synthesize clearingDate;
@synthesize note;
@synthesize isSend;

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        amount = [[dictionary valueForKey:@"Amount"] stringValue];
        date = [dictionary valueForKey:@"Date"];
        trans_id= [[dictionary valueForKey:@"Id"] stringValue];
        type = [dictionary valueForKey:@"Type"];
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dictionary valueForKey:@"Image"]]]];
        user_type = [dictionary valueForKey:@"UserType"];
        status = [dictionary valueForKey:@"Status"];
        clearingDate = [dictionary valueForKey:@"ClearingDate"];
        note = [dictionary valueForKey:@"Notes"];
        
        if ([type isEqualToString:@"money_sent"])
        {
            isSend = YES;
            dwolla_id = [dictionary valueForKey:@"DestinationId"];
            name = [dictionary valueForKey:@"DestinationName"];
        }
        else
        {
            isSend = NO;
            dwolla_id = [dictionary valueForKey:@"SourceId"];
            name = [dictionary valueForKey:@"SourceName"];

        }
    }
    return self;
}

-(BOOL)isEqualTo:(Transaction*)transaction
{
    if ([amount isEqualToString:[transaction amount]] && [trans_id isEqualToString:[transaction trans_id]])
        
    {
        return YES;
    }
    return NO;
}
@end