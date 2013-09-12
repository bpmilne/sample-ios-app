//
//  DwollaAPI.m
//  DwollaV2
//
//  Created by Nick Schulze on 4/30/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "DwollaAPI.h"

@implementation DwollaAPI

@synthesize delegate;

-(void)remember
{
    [SSKeychain setPassword:access_token forService:@"token" account:@"dwolla2"];
}

-(BOOL)didRemember
{    
    access_token = [SSKeychain passwordForService:@"token" account:@"dwolla2"];
    
    if (access_token == NULL)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)logout
{
    access_token = NULL;
    [SSKeychain setPassword:NULL forService:@"token" account:@"dwolla2"];
}

-(void)setUserBalance:(User*)user
{    
    NSString *token = [access_token urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/balance/?oauth_token=%@", token];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
     
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Success"])
        {
            NSDecimalNumber* balance = [answer valueForKey:@"Response"];
        
            [user setBalance:[NSString stringWithFormat:@"%.02f", [balance floatValue]]];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Response"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        NSString* message;
        if ([[requestError domain] isEqualToString:@"NSURLErrorDomain"])
        {
            if ([requestError code] == -1009)
            {
                
               message = @"Currently, your iPhone is not connected to the Internet. Please establish an Internet connection if you wish to use the Dwolla App.";
            }
        }
        [[self delegate] displayError:[requestError localizedDescription]];
        [user setBalance:@"0.00"];
    }
}

-(void)setNearbyPlaces:(User*)user number:(int)number
{
    NSString* cid = @"7wh3QWvv5mQaqxb04bpwOITkaj5ekPJGIS7kGyigpwi+hE1mJy";
    
    NSString* csecret = @"vxztmqgf24ZMH2cS2M2unjI8lnqiYg7f+saULeebKfDxtwtlvo";
    
    CLLocationCoordinate2D location = [[user location] coordinate];
    
    double lat = location.latitude;
    
    double lon = location.longitude;
    
    cid = [cid urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    csecret = [csecret urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/contacts/nearby?client_id=%@&client_secret=%@&latitude=%f&longitude=%f&range=5&limit=%d", cid, csecret, lat, lon, number];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        if ([answer valueForKey:@"Success"])
        {
            NSArray* results = [answer valueForKey:@"Response"];
        
            [user setNearby:results];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
}

-(NSMutableArray*)placesNear:(CLLocationCoordinate2D)location
{
    NSString* cid = @"7wh3QWvv5mQaqxb04bpwOITkaj5ekPJGIS7kGyigpwi+hE1mJy";
    
    NSString* csecret = @"vxztmqgf24ZMH2cS2M2unjI8lnqiYg7f+saULeebKfDxtwtlvo";
        
    double lat = location.latitude;
    
    double lon = location.longitude;
    
    cid = [cid urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    csecret = [csecret urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/contacts/nearby?client_id=%@&client_secret=%@&latitude=%f&longitude=%f&range=5&limit=%d", cid, csecret, lat, lon, 15];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        if ([answer valueForKey:@"Success"])
        {
            NSArray* raw_places = [answer valueForKey:@"Response"];
            
           NSMutableArray* places = [[NSMutableArray alloc] initWithCapacity:[raw_places count]];
            for (int i = 0; i < [raw_places count]; i++)
            {
                Place* place = [[Place alloc] initWithDictionary:[raw_places objectAtIndex:i]];
                [places addObject:place];
            }
            
            return places;
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
    
    return NULL;
}

-(void)setNearbyPeople:(User*)user
{
    NSString* cid = @"7wh3QWvv5mQaqxb04bpwOITkaj5ekPJGIS7kGyigpwi+hE1mJy";
    
    NSString* csecret = @"vxztmqgf24ZMH2cS2M2unjI8lnqiYg7f+saULeebKfDxtwtlvo";
    
    CLLocationCoordinate2D location = [[user location] coordinate];
    
    double lat = location.latitude;
    
    double lon = location.longitude;
    
    cid = [cid urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    csecret = [csecret urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/users/nearby?client_id=%@&client_secret=%@&latitude=%f&longitude=%f&range=5&limit=15", cid, csecret, lat, lon];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        
        if ([answer valueForKey:@"Success"])
        {
            NSArray* results = [answer valueForKey:@"Response"];
        
            [user setContacts:results];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
}

-(void)setUserInfo:(User*)user
{    
    NSString *token = [access_token urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/users/?oauth_token=%@", token];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        if ([answer valueForKey:@"Success"])
        {
            NSDictionary* results = [answer valueForKey:@"Response"];
        
            [user setInfo:results];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
}

-(void)setUserImage:(User*)user
{        
    [user setImage:[self getAvatar:[user dwolla_id]]];
}

- (UIImage*)getAvatar:(NSString*)dw_id
{
    dw_id = [dw_id urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/avatar.aspx?u=%@", dw_id];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        UIImage* image = [[UIImage alloc] initWithData:result];
        
        return image;
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
        return NULL;
    }
}

- (NSString*)getAvatarURL:(NSString*)dw_id
{
    dw_id = [dw_id urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/avatar.aspx?u=%@", dw_id];
    
    NSArray* response = [self makeGetRequest:url];
        
    if ([response count] == 1)
    {        
        return url;
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
        return NULL;
    }
}

-(void)setUserContacts:(User*)user
{    
    NSString *token = [access_token urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/contacts/?oauth_token=%@", token];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        
        if ([answer valueForKey:@"Success"])
        {
            NSArray* results = [answer valueForKey:@"Response"];
            
            [user setContacts:results];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }

}

-(void)setUserTransactions:(User*)user offset:(int)offset
{        
    NSString* cid = @"7wh3QWvv5mQaqxb04bpwOITkaj5ekPJGIS7kGyigpwi+hE1mJy";
    
    NSString* csecret = @"vxztmqgf24ZMH2cS2M2unjI8lnqiYg7f+saULeebKfDxtwtlvo";
    
    NSString *token = [access_token urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    cid = [cid urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    csecret = [csecret urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/transactions/?oauth_token=%@&client_id=%@&client_secret=%@&skip=%d&limit=15", token, cid, csecret, offset];
        
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
      
        
        if ([answer valueForKey:@"Success"])
        {
            NSArray* results = [answer valueForKey:@"Response"];
            
            if (offset != 0)
            {
                [user addTransactions:results];
            }
            else
            {
                [user setTransaction:results];
            }
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }

}

-(void)setUserSources:(User*)user
{    
    NSString *token = [access_token urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/fundingsources/?oauth_token=%@", token];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
      
        
        if ([answer valueForKey:@"Success"])
        {
            NSArray* results = [answer valueForKey:@"Response"];
            
            [user setFundingSources:results];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
}

- (NSString*)depositMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount
{    
    NSString *_source = [source urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/fundingsources/%@/deposit", _source];
        
    NSString* postString = [NSString stringWithFormat:@"{\"oauth_token\": \"%@\", \"pin\":\"%@\", \"amount\": \"%@\"}", access_token, pin, amount];
    
    NSArray* response = [self makePostRequest:url string:postString];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        
        NSDictionary* answer = [self generateDictionaryWithData:result];
      
        
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Success"])
        {
            return [answer valueForKey:@"Message"];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
            return @"invalid";
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
        return NULL;
    }
}

- (NSString*)withdrawMoney:(NSString*)pin source_id:(NSString*)source amount:(NSString*)amount
{    
    NSString *_source = [source urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/fundingsources/%@/withdraw", _source];
    
    NSString* postString = [NSString stringWithFormat:@"{\"oauth_token\": \"%@\", \"pin\":\"%@\", \"amount\": \"%@\"}", access_token, pin, amount];
    
    NSArray* response = [self makePostRequest:url string:postString];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
      
        
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Success"])
        {
            return [answer valueForKey:@"Message"];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
            return @"invalid";
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
        return NULL;
    }
}

-(NSString*)sendMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount note:(NSString*)note
{
    NSString* url = @"https://www.dwolla.com/oauth/rest/transactions/send";
    
    NSString* type = @"Dwolla";
    
    if ([dwolla_id rangeOfString:@"@"].location != NSNotFound)
    {
        type = @"Email";
    }
    else if([dwolla_id rangeOfString:@"-"].location != NSNotFound)
    {
        if ([dwolla_id rangeOfString:@"812-"].location == NSNotFound)
        {
            type = @"Phone";
        }
    }
    
    NSString* postString = [NSString stringWithFormat:@"{\"oauth_token\": \"%@\", \"pin\":\"%@\", \"destinationId\": \"%@\", \"amount\": \"%@\", \"notes\": \"%@\", \"destinationType\": \"%@\"}", access_token, pin, dwolla_id, amount, note, type];
    
    NSArray* response = [self makePostRequest:url string:postString];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Success"])
        {
            return [answer valueForKey:@"Message"];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
            return @"invalid";
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
        return NULL;
    }
}

-(NSString*)requestMoney:(NSString*)pin dwolla_id:(NSString*)dwolla_id amount:(NSString*)amount note:(NSString*)note
{
    NSString* url = @"https://www.dwolla.com/oauth/rest/requests/";
    
    NSString* postString = [NSString stringWithFormat:@"{\"oauth_token\": \"%@\", \"sourceId\": \"%@\", \"amount\": \"%@\", \"notes\": \"%@\"}",access_token, dwolla_id, amount, note];
    
    NSArray* response = [self makePostRequest:url string:postString];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
       
        
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Success"])
        {
            return [answer valueForKey:@"Message"];
        }
        else
        {
            return @"invalid";
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
        return NULL;
    }
}

- (NSDictionary*)getBasicInfo:(NSString*)dwolla_id
{
    
    NSString* cid = @"7wh3QWvv5mQaqxb04bpwOITkaj5ekPJGIS7kGyigpwi+hE1mJy";
    
    NSString* csecret = @"vxztmqgf24ZMH2cS2M2unjI8lnqiYg7f+saULeebKfDxtwtlvo";
        
    cid = [cid urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    csecret = [csecret urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/users/%@?client_id=%@&client_secret=%@", dwolla_id, cid, csecret];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        NSDictionary* results;
        
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Invalid account identifier."])
        {
            results = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:@"Empty"] forKeys:[NSArray arrayWithObject:@"Name"]];
        }
        else
        {
            results = [answer valueForKey:@"Response"];
        }
        
        return results;
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
        return NULL;
    }
}

- (NSArray*)searchContacts:(NSString*)_search
{
    NSString* token = [access_token urlEncodeUsingEncoding:NSUTF8StringEncoding];;
    
    NSString* search = [_search urlEncodeUsingEncoding:NSUTF8StringEncoding];;
            
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/contacts/?oauth_token=%@&search=%@&limit=5", token, search];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    
    NSArray* results;
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        
        if ([answer valueForKey:@"Success"])
        {
            results = [answer valueForKey:@"Response"];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
    return results;
}

- (void)setUserRequests:(User*)user
{    
    NSString *token = [access_token urlEncodeUsingEncoding:NSUTF8StringEncoding];
    
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/requests/?oauth_token=%@&limit=21", token];
    
    NSArray* response = [self makeGetRequest:url];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
      
        if ([answer valueForKey:@"Success"])
        {
            NSArray* results = [answer valueForKey:@"Response"];
            
            [user setRequest:results];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
}

- (NSString*)setAccessToken:(NSString*)code
{
    NSString* clientID = [@"mEXfsx4F+Mk7fAlnWdoGmutm6CT5FnEqyXarA4D3oItOxsZ0HL" urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSString* clientSecret = [@"S4RZRdCyP5bNo0vSF9fNv4PGs2ZiqB7rOwgcK3JJJSzGw5mePt"urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/v2/token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=www.oauthredirect.com&code=%@", clientID, clientSecret, code];
    NSArray* response = [self makeGetRequest:url];
    NSData *result = [response objectAtIndex:0];
    NSDictionary* answer = [self generateDictionaryWithData:result];
    if ([[answer allKeys] count] == 1)
    {
        access_token = [answer valueForKey:@"access_token"];
        return @"success";
    }
    else
    {
        return [answer valueForKey:@"error_description"];
    }
}

-(void)payRequest:(NSString*)r_id pin:(NSString*)pin amount:(NSString*)amount
{
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/requests/%@/fulfill", r_id];
    
    NSString* postString = [NSString stringWithFormat:@"{\"oauth_token\": \"%@\", \"pin\": \"%@\", \"amount\": \"%@\"}", access_token, pin, [amount stringByReplacingOccurrencesOfString:@"$" withString:@""]];
    
    NSArray* response = [self makePostRequest:url string:postString];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
       
        
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Success"])
        {
            [answer valueForKey:@"Message"];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }

}

-(void)cancelRequest:(NSString*)r_id
{
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/rest/requests/%@/cancel", r_id];
    
    NSString* postString = [NSString stringWithFormat:@"{\"oauth_token\": \"%@\"}", access_token];
    
    NSArray* response = [self makePostRequest:url string:postString];
    
    NSData *result = [response objectAtIndex:0];
    
    if ([response count] == 1)
    {
        NSDictionary* answer = [self generateDictionaryWithData:result];
        
        
        if ([[answer valueForKey:@"Message"] isEqualToString:@"Success"])
        {
            [answer valueForKey:@"Message"];
        }
        else
        {
            [[self delegate] displayError:[answer valueForKey:@"Message"]];
        }
    }
    else
    {
        NSError *requestError = [response objectAtIndex:1];
        [[self delegate] displayError:[requestError localizedDescription]];
    }
    
}

- (NSArray*)makeGetRequest:(NSString*)url
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod: @"GET"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSArray* response = [[NSArray alloc] initWithObjects:result, requestError, nil];
    
    return response;
}

- (NSArray*)makePostRequest:(NSString*)url string:(NSString*)post
{
    NSData* data = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod: @"POST"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:data];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSArray* response = [[NSArray alloc] initWithObjects:result, requestError, nil];
    
    return response;
}

-(NSDictionary*)generateDictionaryWithData:(NSData*)data
{
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary* results = [parser objectWithString:dataString];
    
    return results;
}

@end
