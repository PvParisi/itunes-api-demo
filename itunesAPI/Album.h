//
//  Album.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"

@interface Album : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *artworkUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
