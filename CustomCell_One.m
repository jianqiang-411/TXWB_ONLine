//
//  CustomCell_One.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "CustomCell_One.h"
#import "TXWBObject.h"
#import "HttpRequestModel.h"
#import "PhotoVC.h"

@interface CustomCell_One ()
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@end

@implementation CustomCell_One

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.isCalCellHeight = NO;
        //背景图片
        self.imgvwBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_center_background"]];
        _imgvwBackground.frame = CGRectMake(0, 0, 320, 480);
        [self addSubview:_imgvwBackground];
        
        // 头像 headView
        self.imgvwheadLeft = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
        [self addSubview:_imgvwheadLeft];

        //作者 userName
        self.btnUserName = [[UIButton alloc] init];
        _btnUserName.frame = CGRectMake(50, 5, 200, 30);
        [_btnUserName.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        [_btnUserName setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [self addSubview:_btnUserName];
        
        // user'name 右边 √ 的图片
        self.imgvwheadRight = [[UIImageView alloc] initWithFrame:CGRectMake(250, 8, 10, 10)];
        _imgvwheadRight.image = [UIImage imageNamed:@"aaa.png"];
        //[self addSubview:_imgvwheadRight];
        
        
        //发表时间 lbl
        self.lblCreatTime = [[UILabel alloc] initWithFrame:CGRectMake(270, 5, 60, 30)];
        [_lblCreatTime setTextAlignment:NSTextAlignmentLeft];
        [_lblCreatTime setTextColor:[UIColor brownColor]];
        [_lblCreatTime setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:_lblCreatTime];

        
        // 内容
        self.lblContent = [[UILabel alloc] init];
        [_lblContent setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        _lblContent.lineBreakMode = NSLineBreakByTruncatingTail;
        _lblContent.numberOfLines = 0;
        _lblContent.frame = CGRectMake(20, 50, 280, 150);
        [_lblContent setBackgroundColor:[UIColor clearColor]];
        [_lblContent setTextColor:[UIColor brownColor]];
        [self addSubview:_lblContent];
        
        
        // SC头像 headView
        self.imgvwSCHead = [[UIImageView alloc] initWithFrame:CGRectMake(45, 230, 30, 30)];
        [self addSubview:_imgvwSCHead];
        
        //SC作者 userName
        self.btnSCUserName = [[UIButton alloc] init];
        [_btnSCUserName setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [_btnSCUserName.titleLabel setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        [_btnSCUserName.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_btnSCUserName];
        
        
        //source 内容
        self.lblSCContent = [[UILabel alloc] initWithFrame:CGRectMake(40, 220, 280, 200)];
        _lblSCContent.userInteractionEnabled = YES;
        [_lblSCContent setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        _lblSCContent.lineBreakMode = NSLineBreakByTruncatingTail;
        _lblSCContent.numberOfLines = 0;
        [_lblSCContent setBackgroundColor:[UIColor clearColor]];
        [_lblSCContent setTextColor:[UIColor redColor]];
        [self addSubview:_lblSCContent];
        
        
        
        //content 图片
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 80, 80)];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        
        //更多按钮
//        self.btnMorePic = [UIButton buttonWithType:UIButtonTypeCustom];
//        _btnMorePic.frame = CGRectMake(220, _lblContent.frame.size.height+150, 70, 30);
//        _btnMorePic.enabled = NO;
//        _btnMorePic.hidden = YES;
//        [_btnMorePic addTarget:self action:@selector(clickToMorePicture:) forControlEvents:UIControlEventTouchUpInside];
//        [_btnMorePic setBackgroundImage:[UIImage imageNamed:@"aaa.png"] forState:UIControlStateNormal];
        //[self addSubview:_btnMorePic];
        
        //lbl from
        self.lblFromWhere = [[UILabel alloc] initWithFrame:CGRectMake(20, _imgvwBackground.frame.size.height-50, 60, 40)];
        [_lblFromWhere setBackgroundColor:[UIColor clearColor]];
        [_lblFromWhere setTextAlignment:NSTextAlignmentLeft];
        [_lblFromWhere setFont:[UIFont systemFontOfSize:10]];
        [self addSubview:_lblFromWhere];
        
        //收听或关注人数
        self.btnAtCount = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAtCount.frame = CGRectMake(240, _imgvwBackground.frame.size.height-50, 70, 40);
        [_btnAtCount setBackgroundImage:[UIImage imageNamed:@"button_vote_enable"] forState:UIControlStateNormal];
        [_btnAtCount.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_btnAtCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnAtCount.titleLabel setTextAlignment:NSTextAlignmentCenter];

        [self addSubview:_btnAtCount];
        
        

        
        
    }
    return self;
}

- (void)clickToMorePicture:(UIButton *)sender
{
    //tiao zhuan laysz 
}

- (void)configContentCellWithQiuShi:(TXWBObject *)txwb_Obj
{

        UIFont *font = [UIFont fontWithName:@"Arial" size:14.0f];
    
        if (txwb_Obj.head != nil && ![txwb_Obj.head isEqualToString:@""]) {
            NSString *headStr = [NSString stringWithFormat:@"%@/50",txwb_Obj.head];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:headStr]];
            _imgvwheadLeft.image = [UIImage imageWithData:data];
            
        } else {
            _imgvwheadLeft.image = [UIImage imageNamed:@"filter_effect_4@2x.png"];
        }//--头像
        
        if (txwb_Obj.nick != nil && ![txwb_Obj.nick isEqualToString:@""]) {
            CGSize size = [txwb_Obj.nick sizeWithFont:font constrainedToSize:CGSizeMake(200, 30) lineBreakMode:NSLineBreakByTruncatingTail];
            [_btnUserName setTitle:txwb_Obj.nick forState:UIControlStateNormal];
            [_btnUserName setFrame:CGRectMake(52, 10, size.width, size.height)];
        } else {
            [_btnUserName setTitle:@"" forState:UIControlStateNormal];
            
        }//-- 用户名
        
        NSTimeInterval time = (NSTimeInterval)[txwb_Obj.timestamp unsignedLongValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *fo = [[NSDateFormatter alloc] init];
        [fo setDateFormat:@"MM-dd HH:mm"];
        NSString *str = [fo stringFromDate:date];
        
        NSTimeInterval time1 = [date timeIntervalSinceNow];
        double time3 = fabs(time1);
        ino64_t time2 = (ino64_t)time3;
        
        if (time2 > 24*60*60) {
            _lblCreatTime.text = str;
        } else if (time2 > 60*60) {
            int hour = (int)(time2/3600);
            _lblCreatTime.text = [NSString stringWithFormat:@"%d小时前",hour];
        } else if (time2 > 60) {
            int minute = (int)(time2/60);
            _lblCreatTime.text = [NSString stringWithFormat:@"%d分钟前",minute];
        } else {
            _lblCreatTime.text = [NSString stringWithFormat:@"%d秒前",(int)time2];
        }//--时间
        
        float fContentHeight = 0.0f;
        
        if (txwb_Obj.text != nil && ![txwb_Obj.text isEqualToString:@""]) {
            _lblContent.text = txwb_Obj.text;
            CGSize size = [_lblContent.text sizeWithFont:font constrainedToSize:CGSizeMake(280, 150) lineBreakMode:NSLineBreakByTruncatingTail];
            [_lblContent setFrame:CGRectMake(20, 45, size.width, size.height)];//
            fContentHeight = size.height;
        } else {
            _lblContent.text = @"";
            [_lblContent setFrame:CGRectMake(20, 45, 0, 0)];
        }//--内容
    
        float fSCHeadHeight = 0.0f;
        if (txwb_Obj.scHead != nil && ![txwb_Obj.scHead isEqualToString:@""]) {
            NSString *headStr = [NSString stringWithFormat:@"%@/50",txwb_Obj.scHead];
            fSCHeadHeight = 30.0f;
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:headStr]];
            _imgvwSCHead.image = [UIImage imageWithData:data];
            [_imgvwSCHead setFrame:CGRectMake(40, 55+fContentHeight, 30, 30)];
        } else {
            _imgvwSCHead.image = [UIImage imageNamed:@"filter_effect_4@2x.png"];;
            [_imgvwSCHead setFrame:CGRectMake(40, 55+fContentHeight, 0, 0)];
        }//--SC头像
        
        
        if (txwb_Obj.scNick != nil && ![txwb_Obj.scNick isEqualToString:@""]) {
            
            //CGSize size = [txwb_Obj.scNick sizeWithFont:font constrainedToSize:CGSizeMake(200, 30) lineBreakMode:NSLineBreakByTruncatingTail];
            [_btnSCUserName setTitle:txwb_Obj.nick forState:UIControlStateNormal];
            [_btnSCUserName setFrame:CGRectMake(0, 60+fContentHeight, 250, 30)];
            
            fSCHeadHeight = 30.0f;
            
        } else {
            [_btnSCUserName setTitle:@"" forState:UIControlStateNormal];
            [_btnSCUserName setFrame:CGRectMake(0, 60+fContentHeight, 0, 0)];
        }//-- SC用户名
        
        float fSCContentHeight = 0.0f;
        if (txwb_Obj.scText != nil && ![txwb_Obj.scText isEqualToString:@""]) {
            _lblSCContent.text = txwb_Obj.scText;
            CGSize scSize = [_lblSCContent.text sizeWithFont:font constrainedToSize:CGSizeMake(260, 220) lineBreakMode:NSLineBreakByTruncatingTail];
            [_lblSCContent setFrame:CGRectMake(40, 60+fContentHeight+fSCHeadHeight, scSize.width, scSize.height)];
            fSCContentHeight = scSize.height;
        } else {
            _lblSCContent.text = @"";
            [_lblSCContent setFrame:CGRectMake(40, 60+fContentHeight+fSCHeadHeight, 0, 0)];
        }//--SC内容
        
        
        float fImageHeight = 0.0f;
        if (txwb_Obj.arrSCImgUrl != nil && (NSNull *)txwb_Obj.arrSCImgUrl != [NSNull null]) {
            
            if ([txwb_Obj.arrSCImgUrl count] > 0) {
                if ([txwb_Obj.arrSCImgUrl count] > 1) {
                    _btnMorePic.enabled = YES;
                    _btnMorePic.hidden = NO;
                    [_btnMorePic setFrame:CGRectMake(150, 115+fContentHeight+fSCContentHeight+fSCHeadHeight, 30, 30)];
                } else [_btnMorePic setFrame:CGRectMake(150, 115+fContentHeight+fSCContentHeight+fSCHeadHeight, 0, 0)];
            }
            self.imageURL = [txwb_Obj.arrSCImgUrl objectAtIndex:0];
            NSString *imageStr = [NSString stringWithFormat:@"%@/160",[txwb_Obj.arrSCImgUrl objectAtIndex:0]];
            NSURL *urlImg = [NSURL URLWithString:imageStr];
            _imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlImg]];
            
            //添加手势
            self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheImage:)];
            _tap.numberOfTapsRequired = 1;
            _tap.numberOfTouchesRequired = 1;
            [_imgView addGestureRecognizer:_tap];//--添加手势
            
            [_imgView setFrame:CGRectMake(60, 70+fContentHeight+fSCContentHeight+fSCHeadHeight, 80, 80)];
            fImageHeight = 80.0f;
            
        } else {
            [_imgView setFrame:CGRectMake(60, 70+fContentHeight+fSCContentHeight+fSCHeadHeight, 0, 0)];
        }//--图片   --more 按钮
        
        if (txwb_Obj.from != nil && ![txwb_Obj.from isEqualToString:@""]) {
            _lblFromWhere.text = [NSString stringWithFormat:@"来自:%@",txwb_Obj.from];
            [_lblFromWhere setFrame:CGRectMake(20, 80+fContentHeight+fSCContentHeight+fImageHeight+fSCHeadHeight, 100, 30)];
        } else {
            [_lblFromWhere setFrame:CGRectMake(20, 80+fContentHeight+fSCContentHeight+fImageHeight+fSCHeadHeight, 0, 0)];
        }//--from
    
        NSInteger count = 0;
        if (txwb_Obj.atCount != 0) {
            count = txwb_Obj.atCount;
        } else {
            count = txwb_Obj.idolnum;
        }
        [_btnAtCount setTitle:[NSString stringWithFormat:@"%d人收听",count] forState:UIControlStateNormal];//--收听的人数
        [_btnAtCount setFrame:CGRectMake(200, 80+fContentHeight+fSCContentHeight+fSCHeadHeight+fImageHeight, 100, 30)];
        
        [_imgvwBackground setFrame:CGRectMake(0, 0, 320, 120+fContentHeight+fSCContentHeight+fImageHeight+fSCHeadHeight)];
  

}

- (void)tapTheImage:(UIGestureRecognizer *)gesture
{
    
    PhotoVC *photoVC = [[PhotoVC alloc] init];
    photoVC.originFame = _imgView.frame;
    
    
    photoVC.picUrl = _imageURL;
    photoVC.originImg = _imgView;
    
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window.rootViewController presentViewController:photoVC animated:YES completion:nil];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
