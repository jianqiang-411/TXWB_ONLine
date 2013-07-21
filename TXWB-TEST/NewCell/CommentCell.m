//
//  CommentCell.m
//  SSSDemo
//
//  Created by kevin on 13-6-13.
//  Copyright (c) 2013年 kevin. All rights reserved.
//

#import "CommentCell.h"
#import "Comment.h"

@interface CommentCell ()
//用户姓名
@property (strong, nonatomic) UILabel *lblUserName;
//内容
@property (strong, nonatomic) UILabel *lblContentTextView;
//楼层
@property (strong, nonatomic) UILabel *lblFloor;
//背景图片
@property (strong, nonatomic) UIImageView *imgvwBackground;
//底部花边
@property (strong, nonatomic) UIImageView *imgvwFooter;
@end


@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        //背景图片
        self.imgvwBackground = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_center_background"]] autorelease];
        [self addSubview:_imgvwBackground];
        
        
        
        //作者 userName
        self.lblUserName = [[[UILabel alloc] init] autorelease];
        _lblUserName.frame = CGRectMake(10, 4, 200, 30);
        [_lblUserName setBackgroundColor:[UIColor clearColor]];
        [_lblUserName setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        [_lblUserName setTextColor:[UIColor brownColor]];
        [self addSubview:_lblUserName];
        
        //楼层
        self.lblFloor = [[[UILabel alloc] init] autorelease];
        _lblFloor.frame = CGRectMake(290, 4,50, 30);
        [_lblFloor setBackgroundColor:[UIColor clearColor]];
        _lblFloor.text = @"1";
        [_lblFloor setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        [_lblFloor setTextColor:[UIColor brownColor]];
        [self addSubview:_lblFloor];
        
        // 内容
        self.lblContentTextView = [[[UILabel alloc] init] autorelease];
        [_lblContentTextView release];
        _lblContentTextView.lineBreakMode = NSLineBreakByTruncatingTail;
        _lblContentTextView.numberOfLines = 0;
        _lblContentTextView.frame = CGRectMake(20, 32, 280, 40);
        [_lblContentTextView setBackgroundColor:[UIColor clearColor]];
        [_lblContentTextView setFont:[UIFont fontWithName:@"Arial" size:14.f]];
        [_lblContentTextView setTextColor:[UIColor brownColor]];
        [self addSubview:_lblContentTextView];
        
        
        //
        self.imgvwFooter = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block_line"]] autorelease];
        _imgvwFooter.frame = CGRectMake(0, 100, 320, 2);
        [self addSubview:_imgvwFooter];
        
    }
    return self;
}

- (void)configContentCellWithComment:(Comment *)comment
{
    if (comment.strAuthor != nil && ![comment.strAuthor isEqualToString:@""]) {
        self.lblUserName.text = comment.strAuthor;
    } else {
        self.lblUserName.text = @"匿名";
    }
    
    if (comment.strContent != nil && ![comment.strContent isEqualToString:@""]) {
        self.lblContentTextView.text = comment.strContent;
    }
    self.lblFloor.text = [NSString stringWithFormat:@"%i",comment.nFloor];
    
}

- (void)resizeContentCellHeight
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:14.f];
    CGSize size = [_lblContentTextView.text sizeWithFont:font constrainedToSize:CGSizeMake(280, 220) lineBreakMode:NSLineBreakByTruncatingTail];
    _lblContentTextView.frame = CGRectMake(20, 32, 280, size.height+15);
    _imgvwBackground.frame = CGRectMake(0, 0, 320, size.height+45);
    _imgvwFooter.frame = CGRectMake(0, _imgvwBackground.frame.size.height-2, 320, 2);
}






@end
