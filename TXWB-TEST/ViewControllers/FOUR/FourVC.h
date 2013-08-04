//
//  FourVC.h
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourVC : UIViewController<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *allviews;

@property (nonatomic,strong) UIScrollView *photo;


@property (nonatomic,strong) UIImageView *support;
@property (nonatomic,strong) UIImageView *support_hand;
@property (nonatomic,strong) UIImageView *edit;

@property (nonatomic,strong) UIImageView *profile_headbg;
@property (nonatomic,strong) UIImageView *profile_avatarbg;
@property (nonatomic,strong) UIImageView *profile_function;
@property (nonatomic,strong) UIImageView *profile_themebg;
@property (nonatomic,strong) UIImageView *profile_assis;

@end
