//
//  CustomCell_One.h
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXWBObject;
@interface CustomCell_One : UITableViewCell

//作者头像
@property (strong, nonatomic) UIImageView *imgvwheadLeft;
//用户姓名
@property (strong, nonatomic) UIButton *btnUserName;
//人名右边的“打勾”
@property (strong, nonatomic) UIImageView *imgvwheadRight;
//发表时间
@property (strong, nonatomic) UILabel *lblCreatTime;

//内容
@property (strong, nonatomic) UILabel *lblContent;

@property (strong, nonatomic) UILabel *lblSCContent;
//
@property (strong, nonatomic) UIImageView *imgvwSCHead;

@property (strong, nonatomic) UIButton *btnSCUserName;
//糗事图片----------动态创建，可多张------若有图片，则加一张扩展图片--------
//@property (strong, nonatomic) EGOImageButton *imgBtnPhoto;

//内容图片
@property (strong, nonatomic) UIImageView *imgView;
//更多图片按钮
@property (strong, nonatomic) UIButton *btnMorePic;

@property (retain, nonatomic) NSArray *arrImage;

@property (strong, nonatomic) UILabel *lblFromWhere;//来自微博 来自iphone
@property (strong, nonatomic) UIButton *btnAtCount;//关注人数


//背景图片
@property (strong, nonatomic) UIImageView *imgvwBackground;


@property (copy, nonatomic) NSString *imageURL;
@property (assign, nonatomic) BOOL isCalCellHeight;
- (void)configContentCellWithQiuShi:(TXWBObject *)txwb_Obj;
- (float)resizeCellHeightWithTXWBObj:(TXWBObject *)txwb_Obj;
@end
