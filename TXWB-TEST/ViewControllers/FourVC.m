//
//  FourVC.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "FourVC.h"
#import "UserInfo.h"
#import <QuartzCore/QuartzCore.h>
@interface FourVC ()
@property (strong, nonatomic) UserInfo *userInfo;
@end

@implementation FourVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"more_icon4"];
        self.tabBarItem.title = @"资料";
        self.navigationItem.title = @"个人资料";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.userInfo = [UserInfo shareUserInfo];
    
    self.allviews = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    self.allviews.contentSize = CGSizeMake(320,750);
    //self.allviews.delegate = self;
    
    self.photo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 85)];
    self.photo.backgroundColor = [UIColor colorWithRed:0.45 green:0.47 blue:0.53 alpha:0.5];
    UIImageView *imgvw_Photo1 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 2.5, 80, 80)];
    [imgvw_Photo1.layer setMasksToBounds:YES];
    [imgvw_Photo1.layer setCornerRadius:10];
    NSData *data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/100",_userInfo.head]]];
    imgvw_Photo1.image = [UIImage imageWithData:data1];
    
    [_photo addSubview:imgvw_Photo1];
    
    
    
    self.support = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 33)];
    self.support.image = [UIImage imageNamed:@"profilePraiseBg@2x"];
    
    self.support_hand = [[UIImageView alloc] initWithFrame:CGRectMake(5, 90, 32, 36)];
    self.support_hand.image = [UIImage imageNamed:@"personal_praiseIcon@2x"];
    
    self.edit = [[UIImageView alloc] initWithFrame:CGRectMake(210, 98, 95, 33)];
    self.edit.image = [UIImage imageNamed:@"profile_btn_edit"];
    
    //个人信息
    self.profile_headbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140, 320, 142)];
    self.profile_headbg.image = [UIImage imageNamed:@"profile_headbg"];
    
    
    self.profile_avatarbg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, 58, 58)];
    self.profile_avatarbg.image = [UIImage imageNamed:@"profileInfoFaceBgd@2x"];
    
    
    UIImageView *imgvw_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 40, 40)];
    [imgvw_avatar.layer setMasksToBounds:YES];
    [imgvw_avatar.layer setCornerRadius:8];
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/50",_userInfo.head]]];
    imgvw_avatar.image = [UIImage imageWithData:data];
    [_profile_avatarbg addSubview:imgvw_avatar];
    
    
    self.profile_function = [[UIImageView alloc] initWithFrame:CGRectMake(0, 285, 320, 146)];
    self.profile_function.image = [UIImage imageNamed:@"profile_function"];
    
    self.profile_themebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 435, 320, 75)];
    self.profile_themebg.image = [UIImage imageNamed:@"profile_themebg"];
    
    self.profile_assis = [[UIImageView alloc] initWithFrame:CGRectMake(0, 510, 320, 150)];
    self.profile_assis.image = [UIImage imageNamed:@"profile_assis"];
    
    [self.view addSubview:self.allviews];
    
    [self.allviews addSubview:self.photo];
    [self.allviews addSubview:self.support];
    [self.allviews addSubview:self.support_hand];
    [self.allviews addSubview:self.edit];
    [self.allviews addSubview:self.profile_headbg];
    [self.allviews addSubview:self.profile_avatarbg];
    [self.allviews addSubview:self.profile_function];
    [self.allviews addSubview:self.profile_themebg];
    [self.allviews addSubview:self.profile_assis];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
