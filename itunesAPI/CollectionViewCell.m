//
//  CollectionViewCell.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)setImageFromUrl:(NSURL *)url
{
//    static dispatch_queue_t imageQueue = 0;
//    if (imageQueue == NULL)
//        imageQueue = dispatch_queue_create("Image Queue", NULL);
//    
//    dispatch_async(imageQueue, ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:url];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImage *image = [[UIImage alloc] initWithData:imageData];
//            [self.imageView setImage:image];
//        });
//    });
    
//    [[CollectionViewCell imageQueue] addOperationWithBlock:^{
//        NSData *imageData = [NSData dataWithContentsOfURL:url];
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            UIImage *image = [[UIImage alloc] initWithData:imageData];
//            [self.imageView setImage:image];
//        }];
//    }];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
                                                    NSData *imageData = data;
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        UIImage *image = [[UIImage alloc] initWithData:imageData];
                                                        [self.imageView setImage:image];
                                                    });
                                                }];
    [dataTask resume];
}

//+ (NSOperationQueue *)imageQueue
//{
//    static dispatch_once_t onceToken = 0;
//    static NSOperationQueue *imageQueue = nil;
//    dispatch_once(&onceToken, ^{
//        imageQueue = [NSOperationQueue new];
//        imageQueue.maxConcurrentOperationCount = 1;
//    });
//    return imageQueue;
//}


@end
