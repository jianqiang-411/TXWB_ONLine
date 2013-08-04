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
#import "ViewController.h"
#import "Four_edit.h"
#import "FourVc_broadcast.h"
#import "FourVc_code.h"
#import "FourVc_idol.h"
#import "FourVc_album.h"
#import "FourVc_fans.h"

#define AA 3

@interface FourVC ()
@property (strong, nonatomic) UserInfo *userInfo;
@end

@implementation FourVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setColor) name:@"changeTheme" object:nil];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.userInfo = [UserInfo shareUserInfo];
    
    self.allviews = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    _allviews.showsVerticalScrollIndicator = NO;
    _allviews.contentSize = CGSizeMake(320,750);
    //self.allviews.delegate = self;
    
    self.photo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 85)];
    self.photo.backgroundColor = [UIColor colorWithRed:0.45 green:0.47 blue:0.53 alpha:0.5];
    _photo.showsHorizontalScrollIndicator = NO;
    UIImageView *imgvw_Photo1 = [[UIImageView alloc] initWithFrame:CGRectMake(AA, 2.5, 80, 80)];
    [imgvw_Photo1.layer setMasksToBounds:YES];
    [imgvw_Photo1.layer setCornerRadius:10];
    NSData *data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/100",_userInfo.head]]];
    imgvw_Photo1.image = [UIImage imageWithData:data1];
    
    UIImageView *add_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(AA+88, 2.5,80, 80)];
    add_avatar.image = [UIImage imageNamed:@"headImages_add@2x"];
    //[add_avatar addGestureRecognizer:<#(UIGestureRecognizer *)#>];
    
    [_photo addSubview:imgvw_Photo1];
    [_photo addSubview:add_avatar];
    
    
    self.support = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 33)];
    self.support.image = [UIImage imageNamed:@"profilePraiseBgred@2xd.png"];
    
    self.support_hand = [[UIImageView alloc] initWithFrame:CGRectMake(5, 90, 32, 36)];
    self.support_hand.image = [UIImage imageNamed:@"personal_praiseIcon@2x.png"];
    
    self.edit = [[UIImageView alloc] initWithFrame:CGRectMake(210, 98, 95, 33)];
    self.edit.image = [UIImage imageNamed:@"profile_btn_edit"];
    UIButton *edit_btn = [[UIButton alloc] initWithFrame:CGRectMake(210, 98, 95, 33)];
    [edit_btn addTarget:self action:@selector(SingleTap) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *mutual_fans_num = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 20, 20)];
    mutual_fans_num.text = [NSString stringWithFormat:@"%d",_userInfo.mutual_fans_num];
    mutual_fans_num.backgroundColor = [UIColor clearColor];
    mutual_fans_num.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.3];
    [self.support addSubview:mutual_fans_num];
    
    //个人信息
    self.profile_headbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140, 320, 142)];
    self.profile_headbg.userInteractionEnabled = YES;
    self.profile_headbg.image = [UIImage imageNamed:@"profile_headbg.png"];
    
    
    self.profile_avatarbg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, 58, 58)];
    self.profile_avatarbg.image = [UIImage imageNamed:@"profileInfoFaceBgd@2x"];
    
    
    UIImageView *imgvw_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 40, 40)];
    [imgvw_avatar.layer setMasksToBounds:YES];
    [imgvw_avatar.layer setCornerRadius:8];
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/50",_userInfo.head]]];
    imgvw_avatar.image = [UIImage imageWithData:data];
    [_profile_avatarbg addSubview:imgvw_avatar];
    
    
    
    
    UILabel *nick = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 100, 30)];
    nick.text = [NSString stringWithFormat:@"%@",_userInfo.nick];
    nick.backgroundColor = [UIColor clearColor];
    nick.textColor = [UIColor grayColor];
    nick.font = [UIFont systemFontOfSize:18];
    [self.profile_headbg addSubview:nick];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 38, 150, 30)];
    name.text = [NSString stringWithFormat:@"@%@",_userInfo.name];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor grayColor];
    name.font = [UIFont systemFontOfSize:14];
    [self.profile_headbg addSubview:name];
    
    
    UIButton *code = [[UIButton alloc] initWithFrame:CGRectMake(10, 145, 300, 70)];
    code.backgroundColor = [UIColor clearColor];
    [code addTarget:self action:@selector(ShowCode) forControlEvents:UIControlEventTouchUpInside];
    
    //<----------------广播、听众、收听、微相册--------------------->
    UILabel *broadcast = [[UILabel alloc] initWithFrame:CGRectMake(35, 85, 20, 20)];
    broadcast.text = [NSString stringWithFormat:@"%d",_userInfo.tweetnum];
    broadcast.backgroundColor = [UIColor clearColor];
    broadcast.textAlignment = NSTextAlignmentCenter;
    broadcast.textColor = [UIColor grayColor];
    [self.profile_headbg addSubview:broadcast];
    
    UIButton *cast = [[UIButton alloc] initWithFrame:CGRectMake(10, 215, 75, 60)];
    cast.backgroundColor = [UIColor clearColor];
    [cast addTarget:self action:@selector(Broadcast) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *idol = [[UIButton alloc] initWithFrame:CGRectMake(85, 215, 75, 60)];
    idol.backgroundColor = [UIColor clearColor];
    [idol addTarget:self action:@selector(Idol) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *fans = [[UIButton alloc] initWithFrame:CGRectMake(160, 215, 75, 60)];
    fans.backgroundColor = [UIColor clearColor];
    [fans addTarget:self action:@selector(Fans) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *fansnum = [[UILabel alloc] initWithFrame:CGRectMake(115, 85, 20, 20)];
    fansnum.text = [NSString stringWithFormat:@"%d",_userInfo.fansnum];
    fansnum.textAlignment = NSTextAlignmentCenter;
    fansnum.backgroundColor = [UIColor clearColor];
    fansnum.textColor = [UIColor grayColor];
    [self.profile_headbg addSubview:fansnum];
    
    UIButton *album = [[UIButton alloc] initWithFrame:CGRectMake(235, 215, 75, 60)];
    album.backgroundColor = [UIColor clearColor];
    [album addTarget:self action:@selector(Album) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *idolnum = [[UILabel alloc] initWithFrame:CGRectMake(175, 85, 40, 20)];
    idolnum.text = [NSString stringWithFormat:@"%d",_userInfo.idolnum];
    idolnum.backgroundColor = [UIColor clearColor];
    idolnum.textAlignment = NSTextAlignmentCenter;
    idolnum.textColor = [UIColor grayColor];
    [self.profile_headbg addSubview:idolnum];
   
    
    
    //<-----------------新手指南按钮-------------------->
    UIButton *btnXSZN = [UIButton buttonWithType:UIButtonTypeCustom];
    btnXSZN.frame = CGRectMake(5, 380, 310, 50);
    [btnXSZN addTarget:self action:@selector(clickedXSZNButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.profile_function = [[UIImageView alloc] initWithFrame:CGRectMake(0, 285, 320, 150)];
    self.profile_function.image = [UIImage imageNamed:@"profile_functiona.png"];
    
    self.profile_themebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 435, 320, 75)];
    _profile_themebg.userInteractionEnabled = YES;
    self.profile_themebg.image = [UIImage imageNamed:@"profile_themebg.png"];
    
    UIButton *btnThemelightGreen = [UIButton buttonWithType:UIButtonTypeCustom];
    btnThemelightGreen.frame = CGRectMake(70, 8, 60, 60);
    [btnThemelightGreen setImage:[UIImage imageNamed:@"icon_ink@2x.png"] forState:UIControlStateNormal];
    [btnThemelightGreen addTarget:self action:@selector(clickedlightGreenButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnThemedardGreen = [UIButton buttonWithType:UIButtonTypeCustom];
    btnThemedardGreen.frame = CGRectMake(190, 8, 60, 60);
    [btnThemedardGreen setImage:[UIImage imageNamed:@"icon_default@2x.png"] forState:UIControlStateNormal];
    [btnThemedardGreen addTarget:self action:@selector(clickedDardGreenButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.profile_assis = [[UIImageView alloc] initWithFrame:CGRectMake(0, 510, 320, 150)];
    self.profile_assis.image = [UIImage imageNamed:@"profile_assis"];
    
    [self.view addSubview:self.allviews];
    
    [self.allviews addSubview:self.photo];
    [self.allviews addSubview:self.support];
    [self.allviews addSubview:self.support_hand];
    [self.support addSubview:mutual_fans_num];
    [self.allviews addSubview:self.edit];
    [self.allviews addSubview:edit_btn];
    
    [self.allviews addSubview:self.profile_headbg];
    [self.allviews addSubview:self.profile_avatarbg];
    [self.allviews addSubview:code];
    [self.allviews addSubview:cast];
    [self.allviews addSubview:idol];
    [self.allviews addSubview:fans];
    [self.allviews addSubview:album];
    [self.allviews addSubview:self.profile_function];
    [self.allviews addSubview:self.profile_themebg];
    
    
    [self.allviews addSubview:btnXSZN];
    [self.profile_themebg addSubview:btnThemelightGreen];
    [self.profile_themebg addSubview:btnThemedardGreen];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setColor];
    
}

-(void)SingleTap
{
    
    Four_edit *editView = [[Four_edit alloc] init];
    [self.navigationController pushViewController:editView animated:YES];

    
}

-(void)ShowCode
{
    FourVc_code *showcode = [[FourVc_code alloc] init];
    [self.navigationController pushViewController:showcode animated:YES];
    
}

-(void)Broadcast
{
    FourVc_broadcast *myBroadcast = [[FourVc_broadcast alloc] init];
    [self.navigationController pushViewController:myBroadcast animated:YES];
    
}

-(void)Idol
{
    FourVc_idol *myIdol = [[FourVc_idol alloc] init];
    [self.navigationController pushViewController:myIdol animated:YES];
    
}

-(void)Fans
{
    FourVc_fans *myFans = [[FourVc_fans alloc] init];
    [self.navigationController pushViewController:myFans animated:YES];
}

-(void)Album
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    FourVc_album *myAlbum = [[FourVc_album alloc] initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:myAlbum animated:YES];
    
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

- (void)clickedlightGreenButton:(UIButton *)sender
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"lightGreen" forKey:@"theme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTheme" object:nil userInfo:nil];
}

- (void)clickedDardGreenButton:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"darkGreen" forKey:@"theme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTheme" object:nil userInfo:nil];
}


- (void)clickedXSZNButton:(UIButton *)sender
{

    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}




@end
