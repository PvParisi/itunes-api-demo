//
//  UIViewController+AlertInterface.h
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertInterface)

- (void)showAlertWithError:(NSError *)error;

@end
