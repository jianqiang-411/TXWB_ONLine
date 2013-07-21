//
//  CustumCell.m
//  PullingRegresh
//
//  Created by kevin on 13-6-6.
//  Copyright (c) 2013年 kevin. All rights reserved.
//

#import "CustumCell.h"
#import "EGOImageButton.h"
#import "EGOImageView.h"
#import "QiuShi.h"
#import "PhotoVC.h"
@interface CustumCell () <EGOImageButtonDelegate,EGOImageViewDelegate>
//作者头像
@property (strong, nonatomic) UIImageView *headView;
//用户姓名
@property (strong, nonatomic) UILabel *userName;
//内容
@property (strong, nonatomic) UILabel *contentTextView;
//赞
@property (strong, nonatomic) UIButton *smileCount;
//踩
@property (strong, nonatomic) UIButton *unHappyCount;
//收藏按钮
@property (strong, nonatomic) UIButton *share;
//糗事图片
@property (strong, nonatomic) EGOImageButton *imgBtnPhoto;
//糗事小图 url
@property (copy, nonatomic) NSString *strSmallImageURL;
//糗事大图 url
@property (copy, nonatomic) NSString *strMediumImageURL;
//背景图片
@property (strong, nonatomic) UIImageView *imgvwBackground;
//底部花边
@property (strong, nonatomic) UIImageView *imgvwFooter;
@end

@implementation CustumCell

- (void)dealloc {
    self.headView = nil;
    self.imgvwBackground = nil;
    self.userName = nil;
    self.contentTextView = nil;
    self.smileCount = nil;
    self.unHappyCount = nil;
    self.share = nil;
    self.imgBtnPhoto = nil;
    self.imgvwFooter = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //背景图片
        self.imgvwBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_center_background"]];
        _imgvwBackground.frame = CGRectMake(0, 0, 320, 280);
        
        // 头像 headView
        self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 24, 24)];
        _headView.image = [UIImage imageNamed:@"thumb_avatar.png"];
        [_headView release];
        
        //作者 userName
        self.userName = [[[UILabel alloc] init] autorelease];
        self.userName.frame = CGRectMake(45, 5, 200, 30);
        [_userName setBackgroundColor:[UIColor clearColor]];
        [_userName setFont:[UIFont fontWithName:@"Arial" size:14.f]];  
        [_userName setTextColor:[UIColor brownColor]];
                  
        // 内容
        self.contentTextView = [[[UILabel alloc] init] autorelease];
        [_contentTextView setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        _contentTextView.lineBreakMode = NSLineBreakByTruncatingTail;
         _contentTextView.numberOfLines = 0;
        _contentTextView.frame = CGRectMake(20, 50, 280, 200);
        [_contentTextView setBackgroundColor:[UIColor clearColor]];
        [_contentTextView setTextColor:[UIColor brownColor]];
       
        
        //  Button smileCount
        self.smileCount = [UIButton buttonWithType:UIButtonTypeCustom];
        _smileCount.frame = CGRectMake(15, _contentTextView.frame.size.height+30, 70, 44);
        [_smileCount setBackgroundImage:[UIImage imageNamed:@"button_vote_enable"] forState:UIControlStateNormal];
        [_smileCount setBackgroundImage:[UIImage imageNamed:@"button_vote_active"] forState:UIControlStateHighlighted];
        [_smileCount setImage:[UIImage imageNamed:@"icon_for_enable"] forState:UIControlStateNormal];
        [_smileCount setImage:[UIImage imageNamed:@"icon_for_active"] forState:UIControlStateHighlighted];
        [_smileCount setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        [_smileCount setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
        [_smileCount setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [_smileCount release];
        
        //  Button unHappyCount
        self.unHappyCount = [UIButton buttonWithType:UIButtonTypeCustom];
        _unHappyCount.frame = CGRectMake(100, _contentTextView.frame.size.height+30, 70, 44);
        [_unHappyCount setBackgroundImage:[UIImage imageNamed:@"button_vote_enable"] forState:UIControlStateNormal];
        [_unHappyCount setBackgroundImage:[UIImage imageNamed:@"button_vote_active"] forState:UIControlStateHighlighted];
        [_unHappyCount setImage:[UIImage imageNamed:@"icon_against_enable"] forState:UIControlStateNormal];
        [_unHappyCount setImage:[UIImage imageNamed:@"icon_against_active"] forState:UIControlStateHighlighted];
        [_unHappyCount setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        [_unHappyCount setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
        [_unHappyCount setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [_unHappyCount release];
        
    
        //button 分享
        self.share = [UIButton buttonWithType:UIButtonTypeCustom];
        _share.frame = CGRectMake(270, _contentTextView.frame.size.height+30, 35, 44);
        [_share setBackgroundImage:[UIImage imageNamed:@"button_vote_enable"] forState:UIControlStateNormal];
        [_share setBackgroundImage:[UIImage imageNamed:@"button_vote_active"] forState:UIControlStateHighlighted];
        [_share setImage:[UIImage imageNamed:@"icon_fav_enable"] forState:UIControlStateNormal];
        [_share setImage:[UIImage imageNamed:@"icon_fav_active"] forState:UIControlStateHighlighted];
        
        //content 图片
        self.imgBtnPhoto = [[EGOImageButton alloc] initWithPlaceholderImage:[UIImage imageNamed:@"thumb_pic"] delegate:self];
        [_imgBtnPhoto release];
        [_imgBtnPhoto addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.imgvwFooter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_foot_background"]];
        _imgvwFooter.frame = CGRectMake(0, _imgvwBackground.frame.size.height, 320, 10);
        [_imgvwFooter release];
 
        [self addSubview:_imgvwBackground];
        [self addSubview:_contentTextView];
        [self addSubview:_headView];
        [self addSubview:_userName];        
        [self addSubview:_imgBtnPhoto];
        [self addSubview:_smileCount];
        [self addSubview:_unHappyCount];
        [self addSubview:_share];
        [self addSubview:_imgvwFooter];
                
    }
    
    return self;
    
}


- (void)configContentCellWithQiuShi:(QiuShi *)qs
{
    if (qs.userName != nil && ![qs.userName isEqualToString:@""]) {
        self.userName.text = qs.userName;
    }
    else {
        self.userName.text = @"匿名";
    }//-- 用户名
    
    //内容
    self.contentTextView.text = qs.strContent;
    //赞
    [self.smileCount setTitle:[NSString stringWithFormat:@"%i",qs.nSimleCount] forState:UIControlStateNormal];
    //踩
    [self.unHappyCount setTitle:[NSString stringWithFormat:@"%i",qs.nUnHappyCount] forState:UIControlStateNormal];
    
    //图片
    //开始加载小图
    if ((qs.strSmallImage !=nil) && ![qs.strSmallImage isEqualToString:@""]) {
        self.strSmallImageURL = qs.strSmallImage;
        self.strMediumImageURL = qs.strMidiumImage;
    }
    else{
        self.strSmallImageURL = @"";
        self.strMediumImageURL = @"";
    }
    
}

- (void)resizeContentCellHeight {
    UIFont *font = [UIFont fontWithName:@"Arial" size:14.f];
    CGSize size = [_contentTextView.text sizeWithFont:font constrainedToSize:CGSizeMake(280, 220) lineBreakMode:NSLineBreakByTruncatingTail];
    //调整lbl 大小
    [_contentTextView setFrame:CGRectMake(20, 38, 280, size.height)];
    
    if ((_strSmallImageURL != nil) && ![_strSmallImageURL isEqualToString:@""]){        
        self.imgBtnPhoto.imageURL = [NSURL URLWithString:_strSmallImageURL];
        [_imgBtnPhoto setFrame:CGRectMake(30, size.height+50,72, 72)];
        [_imgvwBackground setFrame:CGRectMake(0, 0, 320, size.height+230)];
        //调整图片大小 限制（280*125）
        //[self adjustImageSize:_imgBtnPhoto];
    }//--图片
    else {
        [_imgBtnPhoto cancelImageLoad];
        [_imgBtnPhoto setFrame:CGRectMake(30, size.height, 0, 0)];
        [_imgvwBackground setFrame:CGRectMake(0, 0, 320, size.height+100)];
    }
    CGFloat fBgEdge = _imgvwBackground.frame.size.height;
    [_imgvwFooter setFrame:CGRectMake(0, fBgEdge, 320, 15)];
    [_smileCount setFrame:CGRectMake(15, fBgEdge - 38, 70, 44)];
    [_unHappyCount setFrame:CGRectMake(105, fBgEdge - 38, 70, 44)];
    [_share setFrame:CGRectMake(270, fBgEdge - 38, 35, 44)];
}

#pragma mark - Custum Method
- (void)imageButtonClick:(id)sender {
    
    PhotoVC *photoVC = [[PhotoVC alloc] init];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    photoVC.imgView = [[EGOImageView alloc] initWithPlaceholderImage:_imgBtnPhoto.imageView.image  delegate:photoVC];
    photoVC.originFame = [_imgBtnPhoto convertRect:_imgBtnPhoto.bounds toView:window];
    [photoVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [window.rootViewController presentViewController:photoVC animated:YES completion:nil];
    
}


#pragma mark - EGOImageButtonDelegate Method
- (void)imageButtonLoadedImage:(EGOImageButton *)imageButton
{
    [self adjustImageSize:imageButton];
}

- (void)adjustImageSize:(EGOImageButton *)imageButton
{
    //限制图片高宽 最大280*125
    UIImage *image = imageButton.imageView.image;
    CGFloat fWidthScale = 1.0f;
    CGFloat fHeightScale = 1.0f;
    if (image.size.width > 280) {
        fWidthScale = image.size.width/280;
    }
    if (image.size.height > 125) {
        fHeightScale = image.size.height/125;
    }
    CGFloat scale = MAX(fWidthScale, fHeightScale);
    CGRect rect = imageButton.frame;
    
    rect.size.width = image.size.width/scale;
    rect.size.height = image.size.height/scale;
    imageButton.frame = rect;
}

- (void)imageButtonFailedToLoadImage:(EGOImageButton *)imageButton error:(NSError *)error
{
    [imageButton cancelImageLoad];
}


@end
