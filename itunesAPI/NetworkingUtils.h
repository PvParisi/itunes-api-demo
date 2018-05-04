//
//  NetworkingUtils.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

@interface NetworkingUtils : NSObject

+ (void)loadJsonDataFromEndPoint:(NSString *)endPoint //lookup o search
                   responseClass:(Class)aClass
                          params:(NSDictionary *)params
               completionHandler:(void (^)(Response *response))complHandler
                  failureHandler:(void (^)(NSError *error))failureHandler;

@end
