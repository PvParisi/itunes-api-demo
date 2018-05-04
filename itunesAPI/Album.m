//
//  Album.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "Album.h"

@implementation Album

- (instancetype)init
{
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"collectionName"];
        self.artworkUrl = dictionary[@"artworkUrl100"];
    }
    return self;
}

@end
