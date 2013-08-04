//
//  FourVc_code.m
//  TXWB-TEST
//
//  Created by shangde.Jim on 13-7-25.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "FourVc_code.h"
#import "QRCodeGenerator.h"
#import "UserInfo.h"
#import <QuartzCore/QuartzCore.h>

@interface FourVc_code ()

@property (strong, nonatomic) UserInfo *userInfo;

@end

@implementation FourVc_code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.frame = CGRectMake(0, 0, 68, 44);
        [btnBack setBackgroundImage:[UIImage imageNamed:@"topbar_button_back.png"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
        [btnBack setTitle:@"后退" forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    }
    return self;
}

- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"二维码名片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.userInfo = [UserInfo shareUserInfo];

    
    self.photo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    self.photo.backgroundColor = [UIColor clearColor];
    _photo.userInteractionEnabled = YES;
    
    
    UIImageView *imgvw_Photo1 = [[UIImageView alloc] initWithFrame:CGRectMake(35, 30, 60, 60)];
    [imgvw_Photo1.layer setMasksToBounds:YES];
    [imgvw_Photo1.layer setCornerRadius:10];
    
    NSData *data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/100",_userInfo.head]]];
    imgvw_Photo1.image = [UIImage imageWithData:data1];
    [_photo addSubview:imgvw_Photo1];
    
    [self.view addSubview:self.photo];
    
    UILabel *swipecode = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 200, 50)];
    swipecode.text = @"扫一扫二维码收听我的微博";
    swipecode.textAlignment = NSTextAlignmentLeft;
    swipecode.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:swipecode];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
	imageView.image = [QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"%@",_userInfo.name] imageSize:imageView.bounds.size.width];
	[self.view addSubview: imageView];
    
}



@end
