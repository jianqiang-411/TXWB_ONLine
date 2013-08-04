//
//  ThreeVC.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "ThreeVC.h"
#import "Define.h"
#import "SearchVC.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "Define.h"
#import "AppUItility.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
@interface ThreeVC () <UISearchBarDelegate>
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) NSTimer *levelTimer;
@property (assign, nonatomic) double lowPassResults;
@property (strong, nonatomic) UIButton *btnBlow;
@property (weak, nonatomic) UIButton *btnBack;

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (strong, nonatomic) UIScrollView *photo;
@property (strong, nonatomic) UIScrollView *content;

@property (nonatomic,strong) UIImageView *plaza_locate;
@property (nonatomic,strong) UIImageView *plaza_chui;
@property (nonatomic,strong) UIImageView *plaza_discover;

@property (nonatomic,strong) UIImageView *imgvw;
@property (nonatomic,strong) UIImageView *imgvwOrign;
@property (nonatomic,strong) UIImageView *imgvwFlower;
@property (strong, nonatomic) NSTimer *animationTimer;
@property (nonatomic,strong) UIImageView *imgSingelFlower;
@property (retain, nonatomic) NSMutableArray *muArrOfFlowers;

@property (retain, nonatomic) NSArray *arrPicsTitle;
@property (retain, nonatomic) NSArray *arrPicsName;


@property (strong, nonatomic) AVAudioPlayer *avAudioPlayer;   //播放器player
@end

@implementation ThreeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.image = [UIImage imageNamed:@"more_icon1.png"];
        self.tabBarItem.title = @"广场";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.arrPicsTitle = [NSArray arrayWithObjects:@"美女",@"创意",@"新闻",@"搞笑",@"美食",@"时尚",@"旅游",@"星座", @"电影",@"萌宠",nil];
    self.arrPicsName = [NSArray arrayWithObjects:@"meinv.png",@"120.png",@"xinwen.png",@"gaoxiao.png",@"meishi.png",@"shishang.png",@"lvyou.png",@"xingzuo2.png",@"dianying.png",@"mengchong", nil];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.tintColor = [UIColor colorWithRed:0.45 green:0.47 blue:0.53 alpha:0.5];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
    
    self.photo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 85)];
    _photo.showsHorizontalScrollIndicator = NO;
    _photo.backgroundColor = [UIColor colorWithRed:0.45 green:0.47 blue:0.53 alpha:0.5];
    _photo.contentSize = CGSizeMake(10.0+(80.0+10.0)*[_arrPicsTitle count], 85);
    _photo.userInteractionEnabled = YES;
    [self.view addSubview:_photo];
    
    
    self.content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 129, 320, kScreenHeight-85)];
    _content.contentSize = CGSizeMake(320, 500);
    _content.showsVerticalScrollIndicator = NO;
    _content.backgroundColor = [UIColor whiteColor];
    _content.userInteractionEnabled = YES;
    [self.view addSubview:_content];
    
    [self creatButtonsOnScrollView];
    
    self.plaza_locate = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 110)];
    self.plaza_locate.image = [UIImage imageNamed:@"plaza_locate"];
    
    
    self.plaza_chui = [[UIImageView alloc] initWithFrame:CGRectMake(0, 115, 320, 110)];
    _plaza_chui.image = [UIImage imageNamed:@"plaza_chui"];
    _plaza_chui.userInteractionEnabled = YES;
    
    self.btnBlow = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBlow.frame = CGRectMake(0, 0, 320, 55);
    [_btnBlow addTarget:self action:@selector(clickedBlowButton:) forControlEvents:UIControlEventTouchUpInside];
    [_plaza_chui addSubview:_btnBlow];
    
    self.plaza_discover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 235, 320, 110)];
    self.plaza_discover.image = [UIImage imageNamed:@"plaza_discover"];
        
    [_content addSubview:self.plaza_locate];
    [_content addSubview:self.plaza_chui];
    [_content addSubview:self.plaza_discover];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setColor];
    if (_btnBack != nil) {
        _btnBack.enabled = NO;
        _btnBack.hidden = YES;
    }
    [_searchBar resignFirstResponder];
    [self.tabBarController.tabBar setHidden:NO];
    
}

- (void)setColor
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theme"] isEqualToString:@"darkGreen"]) {
        
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_blue.png"]]];
    } else {
        
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_red.png"]]];
    }
}

- (void)back:(UIButton *)sender
{
    _btnBack.enabled = NO;
    _btnBack.hidden = YES;
    if (_muArrOfFlowers != nil) {
        for (UIImageView *img in _muArrOfFlowers) {
            [img removeFromSuperview];
        }
    }
    [self.tabBarController.tabBar setHidden:NO];
    if (_imgSingelFlower != nil) {
        [_imgSingelFlower removeFromSuperview];
    }
    if (_imgvw != nil) {
        [_imgvw removeFromSuperview];
    }

    
}

- (void)clickedBlowButton:(UIButton *)sender
{
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              
                              [NSNumber numberWithFloat: 44100.0],AVSampleRateKey,
                              
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              
                              [NSNumber numberWithInt: 1],AVNumberOfChannelsKey,
                              
                              [NSNumber numberWithInt: AVAudioQualityMax],AVEncoderAudioQualityKey,
                              
                              nil];
    
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (_recorder) {
        
        [_recorder prepareToRecord];
        
        _recorder.meteringEnabled = YES;
        
        [_recorder record];
        
        self.levelTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(levelTimerCallback:) userInfo:nil repeats:YES];
        
    } else
        [AppUItility showBoxWithMessage:[error description]];
    
    
    [self.tabBarController.tabBar setHidden:YES];
    self.view.userInteractionEnabled = NO;
    
    self.imgvw = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(1000-kScreenHeight+30), 320, 1000)];
    _imgvw.userInteractionEnabled = NO;
    _imgvw.image = [UIImage imageNamed:@"wind_blow_background_1@2x.png"];
    [self.view addSubview:_imgvw];
    
    self.imgvwOrign = [[UIImageView alloc] initWithFrame:CGRectMake(50, _imgvw.bounds.size.height-135, 120*114/150, 120)];
    
    _imgvwOrign.image = [UIImage imageNamed:@"wind_blow_shaking_001@2x.png"];
    [_imgvw addSubview:_imgvwOrign];
    
    
    self.imgvwFlower = [[UIImageView alloc] initWithFrame:CGRectMake(50, _imgvw.bounds.size.height-135, 120*114/150, 120)];
    
    
    NSArray *arrImgs = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"wind_blow_shaking_001@2x.png"],
                        [UIImage imageNamed:@"wind_blow_shaking_002@2x.png"],
                        [UIImage imageNamed:@"wind_blow_shaking_003@2x.png"],
                        [UIImage imageNamed:@"wind_blow_shaking_004@2x.png"],
                        [UIImage imageNamed:@"wind_blow_shaking_005@2x.png"],
                        [UIImage imageNamed:@"wind_blow_shaking_006@2x.png"],
                        nil];
    
    _imgvwFlower.animationImages = arrImgs;
    _imgvwFlower.animationDuration = 1.0;
    _imgvwFlower.animationRepeatCount = 1;
    
    [_imgvw addSubview:_imgvwFlower];
    
    
    
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnBack setImage:[UIImage imageNamed:@"QRCard_closed_normal_big@2x.png"] forState:UIControlStateNormal];
    _btnBack.hidden = YES;
    _btnBack.frame = CGRectMake(20, 20, 40, 40);
    [_btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBack];

    
    
}

- (void)levelTimerCallback:(NSTimer *)timer
{

    [_recorder updateMeters];
    
    const double ALPHA = 0.05;
    
    double peakPowerForChannel = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    
    _lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * _lowPassResults;
    
    
    if (_lowPassResults > 1.5)
    {
        [_levelTimer invalidate];
        [_imgvwOrign removeFromSuperview];
        
         if (_imgSingelFlower == nil) {
         self.imgSingelFlower = [[UIImageView alloc] initWithFrame:CGRectMake(130, 200, 80, 80)];
         _imgSingelFlower.alpha = 0.0;
         _imgSingelFlower.image = [UIImage imageNamed:@"wind_blow_logo@2x.png"];
         [self.view addSubview:_imgSingelFlower];
         } else {
         _imgSingelFlower.alpha = 0.0f;
         [_imgSingelFlower setFrame:CGRectMake(130, 200, 80, 80)];
         [self.view addSubview:_imgSingelFlower];
         }
         
        
        //开始动画
        [_imgvwFlower startAnimating];
        
        if (_muArrOfFlowers == nil) {
            self.muArrOfFlowers = [[NSMutableArray alloc] initWithCapacity:10];
        } else {
            [_muArrOfFlowers removeAllObjects];
        }
        for (int i = 0; i < 10; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(random()%200+50, random()%230+250, 30, 30)];
            img.image = [UIImage imageNamed:@"wind_blow_logo@2x.png"];
            img.hidden = NO;
            [_muArrOfFlowers addObject:img];
            [self.view addSubview:img];
            
        }
        
        
        //从budle路径下读取音频文件
        NSString *string = [[NSBundle mainBundle] pathForResource:@"wind_blow_pop_begin_new" ofType:@"aif"];
        //把音频文件转换成url格式
        NSURL *url = [NSURL fileURLWithPath:string];
        //初始化音频类 并且添加播放文件
        self.avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [_avAudioPlayer play];
        timerRunCount = 0;
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(showAnimation) userInfo:nil repeats:YES];
        
    }
  
}

- (void)showAnimation
{

    timerRunCount++;
    CGRect rect = _imgvw.frame;
    CGFloat fy = rect.origin.y+timerRunCount*0.05;
    
    CGRect rectFlower = _imgSingelFlower.frame;
    
    CGFloat ffx = rectFlower.origin.x;
    CGFloat ffy = rectFlower.origin.y;

    if (timerRunCount > 10 && timerRunCount < 20) {
        
        _imgSingelFlower.alpha = (timerRunCount-10)*.1;
    }
        if (timerRunCount > 40 && timerRunCount < 80) {
        [_imgSingelFlower setFrame:CGRectMake(ffx+(timerRunCount-40)*0.05, ffy-(timerRunCount-40)*0.01, 80, 80)];
    }
    if (timerRunCount > 80 && timerRunCount < 110) {
        [_imgSingelFlower setFrame:CGRectMake(ffx-(timerRunCount-60)*0.05, ffy-(timerRunCount-60)*0.01, 80, 80)];
    }
   
    if (timerRunCount > 120 && timerRunCount < 148) {
        [_imgSingelFlower setFrame:CGRectMake(ffx+(timerRunCount-70)*0.05, ffy-(timerRunCount-70)*0.02, 80, 80)];
    }
    if (fy < 0) {
        [_imgvw setFrame:CGRectMake(rect.origin.x, fy, kScreenWidth, 1000)];
    } else {
        [_animationTimer invalidate];
        _btnBack.hidden = NO;
        self.view.userInteractionEnabled = YES;
        _imgvw.userInteractionEnabled = YES;
        _avAudioPlayer.currentTime = 0;  //当前播放时间设置为0
        [_avAudioPlayer stop];
      
    }
    
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    SearchVC *searchVC = [[SearchVC alloc] init];
    [self presentViewController:searchVC animated:YES completion:nil];
}

- (void)creatButtonsOnScrollView
{
    for (int i = 0; i < [_arrPicsTitle count]; i++) {
        CGFloat fBtnOffset = 10.0f;
        CGFloat fBtnWidth = 80.0f;
        CGFloat fBtnHeight = 80.0f;
        CGRect rect = CGRectMake(fBtnOffset+(fBtnWidth+fBtnOffset)*i, 2.5, fBtnWidth, fBtnHeight);
        UIImage *image = nil;
        if ([_arrPicsName objectAtIndex:i] != nil && ![[_arrPicsName objectAtIndex:i] isEqualToString:@""]) {
            image = [UIImage imageNamed:[_arrPicsName objectAtIndex:i]];

        } else {
            image = [UIImage imageNamed:@"filter_effect_4@2x.png"];
        }
        
        [self creatButtonWithFram:rect andImage:image andTitle:[_arrPicsTitle objectAtIndex:i] andTag:1000+i];
    }
}

- (void)creatButtonWithFram:(CGRect)rect
                   andImage:(UIImage *)image
                   andTitle:(NSString *)title
                     andTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setImage:image forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height*2/3, rect.size.width, rect.size.height/3)];
    lbl.backgroundColor = [UIColor whiteColor];
    [lbl.layer setMasksToBounds:YES];
    [lbl.layer setCornerRadius:5.0];
    lbl.alpha = 0.5;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor blackColor];
    lbl.text = title;
    [btn addSubview:lbl];
    [_photo addSubview:btn];
}

- (void)clickedButton:(UIButton *)sender
{
    NSURL *url = nil;
    /*
    switch (sender.tag) {
        case 1000:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=美女&cid=181"];
            break;
        case 1001:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=创意&cid=150"];
            break;
        case 1002:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=新闻&cid=158"];
            break;
        case 1003:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=搞笑&cid=184"];
            break;
        case 1004:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=美食&cid=170"];
            break;
        case 1005:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=时尚&cid=153"];
            break;
        case 1006:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=旅游&cid=148"];
            break;
        case 1007:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=星座&cid=185"];
            break;
        case 1008:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=电影&cid=147"];
            break;
        case 1009:
            url = [NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channel/type=萌宠&cid=155"];
            break;
            
        default:
            break;
    }
     */
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://ti.3g.qq.com/touch/iphone/index.jsp?g_f=17497&sid=AS34TOKWQciD0CjRhAgdWcNH#channels"]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTaped:)];
    _tap.numberOfTapsRequired = 1;
    _tap.numberOfTouchesRequired = 2;
    [_webView addGestureRecognizer:_tap];
    
    
    
}

- (void)gestureTaped:(UIGestureRecognizer *)gesture
{
    [_webView removeFromSuperview];
}

@end
