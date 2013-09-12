//
//  NSString+URLEncoding.m
//  DwollaV2
//
//  Created by Nick Schulze on 4/30/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "NSString+URLEncoding.h"
@implementation NSString (URLEncoding)

-(NSString*)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
	return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)self,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end