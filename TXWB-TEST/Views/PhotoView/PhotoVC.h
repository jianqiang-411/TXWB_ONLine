//
//  PhotoVC.h
//  QiuShi-Demo
//
//  Created by kevin on 13-6-13.
//  Copyright (c) 2013年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoVC : UIViewController 

@property (copy, nonatomic) NSString *picUrl;
@property (nonatomic, weak) UIImageView* originImg;
@property (assign, nonatomic) CGRect originFame;

@end
