//
//  AppUItility.m
//  QiuShi-Demo
//
//  Created by kevin on 13-6-14.
//  Copyright (c) 2013年 kevin. All rights reserved.
//

#import "AppUItility.h"

@implementation AppUItility
+ (void)showBoxWithMessage:(NSString *)strMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [alert release];
}
@end
