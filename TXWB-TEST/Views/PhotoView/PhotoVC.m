//
//  PhotoVC.m
//  QiuShi-Demo
//
//  Created by kevin on 13-6-13.
//  Copyright (c) 2013年 kevin. All rights reserved.
//

#import "PhotoVC.h"
#import "Define.h"
#import <QuartzCore/QuartzCore.h>

@interface PhotoVC () <UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imgvw;
@property (strong, nonatomic) UIImage *imgToShow;
@property (strong, nonatomic) UITapGestureRecognizer *singleTap;
@property (strong, nonatomic) NSFileManager *fm;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGAffineTransform trans;
@property (assign, nonatomic) CGPoint centerPoint;
@property (assign, nonatomic) CGFloat fScal;
@end

@implementation PhotoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.fm = [NSFileManager defaultManager];
        self.picUrl = [NSString string];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //singel手势
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelSingelTapGesture:)];
    _singleTap.numberOfTapsRequired = 1;
    _singleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:_singleTap];
    
    
    //scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.contentSize = CGSizeMake(_imgToShow.size.width, _imgToShow.size.height);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    //UIImageView
    self.imgvw = [[UIImageView alloc] initWithFrame:_originFame];
    _imgvw.userInteractionEnabled = YES;
    [_scrollView addSubview:_imgvw];
    
    //加载图片
    [self loadImage];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CABasicAnimation *animaCenter = [CABasicAnimation animationWithKeyPath:@"position"];
    _centerPoint = CGPointMake(_originFame.origin.x + _originFame.size.width/2, _originFame.origin.y + _originFame.size.height/2);
    animaCenter.fromValue = [NSValue valueWithCGPoint:_centerPoint];
    animaCenter.toValue = [NSValue valueWithCGPoint:self.view.center];
    
    
    CABasicAnimation *animaScale = [CABasicAnimation animationWithKeyPath:@"transform"];
    animaScale.fromValue = [NSValue valueWithCGAffineTransform:_originImg.transform];
    
    float fWidthScale = 0.f;
    float fHeightScale = 0.f;
    
    fWidthScale = self.view.bounds.size.width/_imgvw.bounds.size.width;
    fHeightScale = self.view.bounds.size.height/_imgvw.bounds.size.height;
    
    
    _fScal = MIN(fWidthScale, fHeightScale);
    
    [_scrollView setMinimumZoomScale:_fScal];
    [_scrollView setMaximumZoomScale:4*_fScal];
    
    animaScale.toValue = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(_fScal,_fScal)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animaCenter,animaScale];
    group.duration = .5f;
    
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_imgvw.layer addAnimation:group forKey:nil];
    
    _imgvw.center = self.view.center;
    _imgvw.transform = [animaScale.toValue CGAffineTransformValue];
    
}


- (void)loadImage
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/460",_picUrl]]];
    
    self.imgToShow = [UIImage imageWithData:data];
    _imgvw.image = _imgToShow;
    
    
}


- (void)handelSingelTapGesture:(UIGestureRecognizer *)gesture
{
    
    CABasicAnimation *animaCenter = [CABasicAnimation animationWithKeyPath:@"position"];
    animaCenter.fromValue = [NSValue valueWithCGPoint:_imgvw.center];
    animaCenter.toValue = [NSValue valueWithCGPoint:_centerPoint];
    
    CABasicAnimation *animaScale = [CABasicAnimation animationWithKeyPath:@"transform"];
    animaScale.fromValue = [NSValue valueWithCGAffineTransform:_imgvw.transform];
    animaScale.toValue = [NSValue valueWithCGAffineTransform:_originImg.transform];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[animaCenter, animaScale];
    animGroup.duration = .5f;
    
    
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_imgvw.layer addAnimation:animGroup forKey:nil];
    
    
    _imgvw.center = [animaCenter.toValue CGPointValue];
    _imgvw.transform = [animaScale.toValue CGAffineTransformValue];
    
    
    [self performSelector:@selector(dismissSelf) withObject:nil afterDelay:.2f];
    
}

- (void)dismissSelf
{

    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CABasicAnimation *animaCenter = [CABasicAnimation animationWithKeyPath:@"position"];
    _centerPoint = _imgView.center;
    animaCenter.fromValue = [NSValue valueWithCGPoint:_imgView.center];
    animaCenter.toValue = [NSValue valueWithCGPoint:self.view.center];

    
    CABasicAnimation *animaScale = [CABasicAnimation animationWithKeyPath:@"transform"];
    animaScale.fromValue = [NSValue valueWithCGAffineTransform:_imgView.transform];
    _trans = _imgView.transform;
    float fWidthScale = 0.f;
    float fHeightScale = 0.f;
    fWidthScale = self.view.bounds.size.width/_imgView.bounds.size.width;
    fHeightScale = self.view.bounds.size.height/_imgView.bounds.size.height;
    _fScal = MIN(fWidthScale, fHeightScale);
    
    [_scrollView setMinimumZoomScale:_fScal];
    [_scrollView setMaximumZoomScale:4*_fScal];
    
    animaScale.toValue = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeScale(_fScal, _fScal)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animaCenter, animaScale];
    group.duration = 3.0f;
    //时间曲线
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_imgView.layer addAnimation:group forKey:nil];
    
    
    _imgView.center = self.view.center;
    _imgView.transform = [animaScale.toValue CGAffineTransformValue];

}
*/
#pragma mark - 滚动视图代理方法
//指出滚动视图中那个视图需要进行缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgvw;
}
//当完成缩放时，scale 为缩放比例
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [scrollView setZoomScale:scale];
}
/*
- (void)handelTapGesture:(UITapGestureRecognizer *)tap
{
    CABasicAnimation *animaCenter = [CABasicAnimation animationWithKeyPath:@"position"];
    animaCenter.fromValue = [NSValue valueWithCGPoint:_imgView.center];
    animaCenter.toValue = [NSValue valueWithCGPoint:_centerPoint];
    
    CABasicAnimation *animaScale = [CABasicAnimation animationWithKeyPath:@"transform"];
    animaScale.fromValue = [NSValue valueWithCGAffineTransform:_imgView.transform];
    animaScale.toValue = [NSValue valueWithCGAffineTransform:_trans];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[animaCenter, animaScale];
    animGroup.duration = 1.f;
    
    
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_imgView.layer addAnimation:animGroup forKey:nil];
    
    
    _imgView.center = [animaCenter.toValue CGPointValue];
    _imgView.transform = [animaScale.toValue CGAffineTransformValue];
    
    [self performSelector:@selector(dismissSelf) withObject:nil afterDelay:1.0];
}
*/


@end
