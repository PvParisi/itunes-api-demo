//
//  NetworkingUtils.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "NetworkingUtils.h"

static NSString *const kBaseUrl = @"itunes.apple.com";
static NSString *const kScheme = @"http";

@implementation NetworkingUtils

+ (NSURL *)composeUrlForEndPoint:(NSString *)endPoint withParameters:(NSDictionary *)params
{
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = kScheme;
    components.host = kBaseUrl;
    components.path = [@"/" stringByAppendingString:endPoint];
    
    // create query items
    NSMutableArray *tempQueryArray = [NSMutableArray new];
    for (id param in params)
    {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:param value:params[param]];
        [tempQueryArray addObject:queryItem];
    }
    components.queryItems = tempQueryArray;
    
    NSLog(@"%@", components.URL);
    return components.URL;
}

+ (void)loadJsonDataFromEndPoint:(NSString *)endPoint //lookup o search
                   responseClass:(Class)aClass
                          params:(NSDictionary *)params
               completionHandler:(void (^)(Response *response))complHandler
                  failureHandler:(void (^)(NSError *error))failureHandler;
{
    NSURL *url = [self composeUrlForEndPoint:endPoint withParameters:params];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
                                                    
                                                    NSLog(@"URL response: %@", urlResponse);
                                                    NSLog(@"Error: %@", error);
                                                    
                                                    if (error)
                                                    {
                                                        failureHandler(error);
                                                        return;
                                                    }
                                                    
                                                    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                                    
                                                    if (error)
                                                    {
                                                        failureHandler(error);
                                                        return;
                                                    }
                                                    
                                                    if ([object isKindOfClass:[NSArray class]])
                                                    {
                                                        //init response from array.
                                                    }
                                                    else if ([object isKindOfClass:[NSDictionary class]])
                                                    {
                                                        Response *res = [[Response alloc] initWithDictionary:object];
                                                        complHandler(res);
                                                    }
                                                }];
    [dataTask resume];
    
}

@end
