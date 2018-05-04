//
//  Response.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 10/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "Response.h"
#import "Artist.h"
#import "Album.h"

@implementation Response

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSArray *results = dictionary[@"results"];
        NSMutableArray *artist = [NSMutableArray new];
        NSMutableArray *collection = [NSMutableArray new];
        
        for (NSDictionary *result in results)
        {
            if ([result[@"wrapperType"]  isEqual: @"artist"])
            {
                Artist *item = [[Artist alloc] initWithDictionary:result];
                [artist addObject:item];
            }
            
            if ([result[@"wrapperType"]  isEqual: @"collection"])
            {
                Album *item = [[Album alloc] initWithDictionary:result];
                [collection addObject:item];
            }
        }
        
        self.artists = artist;
        self.albums = collection;
    }
    return self;
}

@end
