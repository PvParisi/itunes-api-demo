//
//  Artist.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

@interface Artist : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSNumber *amgId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
