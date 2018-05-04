//
//  Response.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property (strong, nonatomic) NSArray *artists;
@property (strong, nonatomic) NSArray *albums;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
