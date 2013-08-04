//
//  Four_edit.m
//  TXWB-TEST
//
//  Created by shangde.Jim on 13-7-24.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "Four_edit.h"
#import "UserInfo.h"
#import <QuartzCore/QuartzCore.h>

@interface Four_edit ()

@property (strong, nonatomic) UserInfo *userInfo;

@end

@implementation Four_edit

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"编辑";
    
    self.userInfo = [UserInfo shareUserInfo];
    
    
    self.photo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
    self.photo.backgroundColor = [UIColor clearColor];
    _photo.userInteractionEnabled = YES;
    UIImageView *imgvw_Photo1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [imgvw_Photo1.layer setMasksToBounds:YES];
    [imgvw_Photo1.layer setCornerRadius:10];
    
    NSData *data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/100",_userInfo.head]]];
    imgvw_Photo1.image = [UIImage imageWithData:data1];
    [_photo addSubview:imgvw_Photo1];
    
    [self.view addSubview:self.photo];
    
    
    UILabel *nick = [[UILabel alloc] initWithFrame:CGRectMake(25,100, 50, 48)];
    nick.text = @"昵称：";
    nick.font = [UIFont systemFontOfSize:14.0];
    nick.backgroundColor = [UIColor clearColor];
    
    self.edit_nick = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 48)];
    self.edit_nick.image =[UIImage imageNamed:@"edit_profile_nick"];
    UITextField *nicki = [[UITextField alloc] initWithFrame:CGRectMake(70, 100, 240, 48)];
    //[nick setBorderStyle: UITextBorderStyleRoundedRect];
    //nick.layer.borderColor = [UIColor clearColor].CGColor;
    //nick.backgroundColor = [UIColor clearColor];
    nicki.delegate = self;
    nicki.text = [NSString stringWithFormat:@"%@",_userInfo.nick];
    nicki.font = [UIFont systemFontOfSize:14.0];
    nicki.textAlignment = NSTextAlignmentLeft;
    nicki.contentVerticalAlignment = 0;
    
    
    UILabel *intro = [[UILabel alloc] initWithFrame:CGRectMake(25,160, 50, 48)];
    intro.text = @"简称：";
    intro.font = [UIFont systemFontOfSize:14.0];
    intro.backgroundColor = [UIColor clearColor];
    
    self.edit_intro = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160, 320, 118)];
    self.edit_intro.image =[UIImage imageNamed:@"edit_profile_intro"];
    
    self.selfintro = [[UITextView alloc] initWithFrame:CGRectMake(70, 165, 240, 100)];
    _selfintro.font = [UIFont systemFontOfSize:14.0];
    _selfintro.delegate = self;
    _selfintro.textAlignment = NSTextAlignmentLeft;
    _selfintro.backgroundColor = [UIColor clearColor];

    
    [self.view addSubview:self.edit_nick];
    [self.view addSubview:nick];
    [self.view addSubview:nicki];
    
    [self.view addSubview:self.edit_intro];
    [self.view addSubview:intro];
    [self.view addSubview:_selfintro];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setColor];
    
    
}

- (void)setColor
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theme"] isEqualToString:@"darkGreen"]) {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_blue.png"]]];
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_blue.png"]]];
    } else {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_red.png"]]];
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_red.png"]]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self performSelector:@selector(framUp) withObject:nil afterDelay:0.15];
    
}

- (void)framUp
{
    [self.view setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y-80, self.view.bounds.size.width, self.view.bounds.size.height)];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //隐藏键盘
    [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [_selfintro resignFirstResponder];
    
}



@end
