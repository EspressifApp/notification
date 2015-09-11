//
//  ESPHttpClient.m
//  IOT_Espressif_IOS
//
//  Created by 白 桦 on 11/11/14.
//  Copyright (c) 2014 白 桦. All rights reserved.
//

#import "ESPHttpClient.h"

@implementation ESPHttpClient

// perform NSMutableURLRequest
+ (NSDictionary *)performOperationWithRequest:(NSMutableURLRequest *)request
{
    NSError *error = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil
                                                         error:&error];
    if(error != nil || received == nil){
        if(error!=nil){
            NSLog(@"ERROR::error=%@",error);
            
        }
        else{
            NSLog(@"ERROR::received == nil");
        }
        return nil;
    }
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
    
    if(error != nil){
        NSLog(@"ERROR::error=%@",error);
        return nil;
    }
    NSLog(@"performOperationWithRequest::response=%@",dict);
    return dict;
}

// generate the NSMutableURLRequest
+ (NSMutableURLRequest *)genURLRequest:(NSString *)path
                               headers:(NSDictionary *)headers
                            parameters:(NSDictionary *)parameters
                        timeoutSeconds:(NSUInteger)timeoutSeconds
                            httpMethod:(NSString *)httpMethod
{
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeoutSeconds];
    NSLog(@"genURLRequest::path=%@,headers=%@,parameters=%@,timeoutSeconds=%u,httpMethod=%@",path,headers,parameters,timeoutSeconds,httpMethod);
    // don't use cookie
    [request setHTTPShouldHandleCookies:NO];
    // set timeout
    [request setTimeoutInterval:timeoutSeconds];
    // set HTTP Method
    [request setHTTPMethod:httpMethod];
    // set HTTP Headers
    if(headers!=nil)
    {
        [request setAllHTTPHeaderFields:headers];
    }
    
    // set HTTP Body(JSONObject)
    if(parameters!=nil)
    {
        NSData* parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:parametersData];
    }
    return request;
}

#pragma mark - GET Operation
+ (NSDictionary *)getSynPath:(NSString *)path
                     headers:(NSDictionary *)headers
                  parameters:(NSDictionary *)parameters
              timeoutSeconds:(NSUInteger)timeoutSeconds
{
    NSMutableURLRequest *request = [ESPHttpClient genURLRequest:path headers:headers parameters:parameters timeoutSeconds:timeoutSeconds httpMethod:@"GET"];
    return [ESPHttpClient performOperationWithRequest:request];
}

#pragma mark - POST Operation
+ (NSDictionary *)postSynPath:(NSString *)path
                      headers:(NSDictionary *)headers
                   parameters:(NSDictionary *)parameters
               timeoutSeconds:(NSUInteger)timeoutSeconds

{
    NSMutableURLRequest *request = [ESPHttpClient genURLRequest:path headers:headers parameters:parameters timeoutSeconds:timeoutSeconds httpMethod:@"POST"];
    return [ESPHttpClient performOperationWithRequest:request];
}

#pragma mark - PUT Operation
+ (NSDictionary *)putSynPath:(NSString *)path
                     headers:(NSDictionary *)headers
                  parameters:(NSDictionary *)parameters
              timeoutSeconds:(NSUInteger)timeoutSeconds

{
    NSMutableURLRequest *request = [ESPHttpClient genURLRequest:path headers:headers parameters:parameters timeoutSeconds:timeoutSeconds httpMethod:@"PUT"];
    return [ESPHttpClient performOperationWithRequest:request];
}

#pragma mark - DELETE Operation
+ (NSDictionary *)deleteSynPath:(NSString *)path
                        headers:(NSDictionary *)headers
                     parameters:(NSDictionary *)parameters
                 timeoutSeconds:(NSUInteger)timeoutSeconds

{
    NSMutableURLRequest *request = [ESPHttpClient genURLRequest:path headers:headers parameters:parameters timeoutSeconds:timeoutSeconds httpMethod:@"DELETE"];
    return [ESPHttpClient performOperationWithRequest:request];
}


@end
