//
//  UIViewController+AlertInterface.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "UIViewController+AlertInterface.h"

@implementation UIViewController (AlertInterface)

- (void)showAlertWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ERROR" message:error.description preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Got it..." style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {}];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
