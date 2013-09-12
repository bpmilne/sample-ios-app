//
//  Source.h
//  DwollaV2
//
//  Created by Nick Schulze on 5/23/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Source : NSObject
{
    NSString* source_id;
    NSString* name;
    NSString* type;
    NSString* verified;
    NSString* processing_type;
}

@property (retain) NSString* source_id;
@property (retain) NSString* name;

-(id)initWithDictionary:(NSDictionary*)dictionary;

@end

