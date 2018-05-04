//
//  CollectionViewController.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

@interface CollectionViewController : UIViewController <UICollectionViewDataSource>

@property (strong, nonatomic) Artist *artist;
@property (strong, nonatomic) NSMutableArray *collectionEntries;
@property (strong, nonatomic) IBInspectable NSString *cellIdentifier;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;

@end
