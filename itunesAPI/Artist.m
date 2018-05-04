//
//  Artist.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "Artist.h"

@implementation Artist

- (instancetype)init
{
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"artistName"];
        self.identifier = dictionary[@"artistId"];
        self.amgId = dictionary[@"amgArtistId"];
    }
    return self;
}

@end
