//
//  CollectionViewController.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "CollectionViewController.h"
#import "NetworkingUtils.h"
#import "Album.h"
#import "CollectionViewCell.h"
#import "UIViewController+AlertInterface.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSDictionary *paramsDict;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.paramsDict = @{
                        @"amgArtistId" : [NSString stringWithFormat:@"%@",self.artist.amgId],
                        @"entity" : @"album"
                        };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //set artist label
    self.artistLabel.text = self.artist.name;
    //get album list
    [NetworkingUtils loadJsonDataFromEndPoint:@"lookup" responseClass:[Album class]
                                       params:self.paramsDict
                            completionHandler:^(Response *response) {
         self.collectionEntries = response.albums.mutableCopy;
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.collectionView reloadData];
         });
     }
                               failureHandler:^(NSError *error) {
                                   [self showAlertWithError:error];
         
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionEntries count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id albumItem = [self.collectionEntries objectAtIndex:indexPath.row];
    if ([albumItem isKindOfClass:[Album class]])
    {
        Album *castedItem = (Album *)albumItem;
        NSURL *url = [NSURL URLWithString:castedItem.artworkUrl];
        [cell setImageFromUrl:url];
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
