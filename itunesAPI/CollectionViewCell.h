//
//  CollectionViewCell.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (void)setImageFromUrl:(NSURL *)url;

@end
