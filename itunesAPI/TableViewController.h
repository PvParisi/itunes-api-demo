//
//  TableViewController.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource>

@property (weak,nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableEntries;
@property (strong, nonatomic) IBInspectable NSString *cellIdentifier;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
