//
//  CommentVC.m
//  TXWB-TEST
//
//  Created by SDJG on 13-7-19.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "CommentVC.h"
#import "Define.h"
#import "HttpRequestModel.h"
#import "TXWBObject.h"
#import "Define.h"
#import "AppUItility.h"
#import "UserInfo.h"
#import <QuartzCore/QuartzCore.h>

#import "FacialView.h"
@interface CommentVC () <UIScrollViewDelegate,facialViewDelegate>

@end

@implementation CommentVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //给键盘注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(inputKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(inputKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    keyboardIsShow = YES;
    
    
    self.imgHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _imgHeadView.image = [UIImage imageNamed:@"bg_2.png"];
    _imgHeadView.userInteractionEnabled = YES;
    [self.view addSubview:_imgHeadView];
    
    if (_btnCancle == nil) {
        self.btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
       
        _btnCancle.frame = CGRectMake(5, 7, 50, 30);
        [_btnCancle setBackgroundImage:[UIImage imageNamed:@"9-blank-button-a@2x.png"] forState:UIControlStateNormal];
        [_btnCancle setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancle addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
     NSLog(@"%p,",_btnCancle);
    [_imgHeadView addSubview:_btnCancle];
    
    
    self.btnPublish = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnPublish.frame = CGRectMake(265, 7, 50, 30);
    [_btnPublish setBackgroundImage:[UIImage imageNamed:@"9-blank-button-a@2x.png"] forState:UIControlStateNormal];
    [_btnPublish setTitle:@"发表" forState:UIControlStateNormal];
    [_btnPublish addTarget:self action:@selector(doPublish:) forControlEvents:UIControlEventTouchUpInside];
    [_imgHeadView addSubview:_btnPublish];
    
    
    NSString *strHead = [UserInfo shareUserInfo].head;
    if (strHead != nil && ![strHead isEqualToString:@""]) {
        _imgHead.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/50",strHead]]]];
    } else {
        _imgHead.image = [UIImage imageNamed:@"filter_effect_4@2x.png"];
    }
    [_imgHead.layer setMasksToBounds:YES];
    [_imgHead.layer setCornerRadius:5.0f];
    
     [_btnCancle setBackgroundImage:[UIImage imageNamed:@"9-blank-button-a@2x.png"] forState:UIControlStateNormal];
    [_btnPublish setBackgroundImage:[UIImage imageNamed:@"9-blank-button-a@2x.png"] forState:UIControlStateNormal];
    _textContentView.keyboardType = UIKeyboardTypeDefault;
    _textContentView.keyboardAppearance = UIKeyboardAppearanceDefault;
    
    _textContentView.returnKeyType = UIReturnKeyDefault;
    
    [_textContentView becomeFirstResponder];
    
    _btnCamaer.frame = CGRectMake(5, kScreenHeight-keyBoardHeight-115, 50, 50);
    [_btnCamaer setImage:[UIImage imageNamed:@"post_photo_area_camera_icon@2x.png"] forState:UIControlStateNormal];
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,self.view.bounds.size.height-keyBoardHeight-44,320,44.0)];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [_toolBar setTintColor:[UIColor grayColor]];
    [_toolBar setBarStyle:UIBarStyleBlack];
    [self.view addSubview:_toolBar];
    
    
    //表情按钮
    self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _faceButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"face@2x.png"] forState:UIControlStateNormal];
    [_faceButton addTarget:self action:@selector(disFaceKeyboard) forControlEvents:UIControlEventTouchUpInside];
    _faceButton.frame = CGRectMake(260,5,34,34);
    [_toolBar addSubview:_faceButton];
   
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = _scrollView.contentOffset.x / 320;//通过滚动的偏移量来判断目前页面所对应的小白点
    _pageControl.currentPage = page;//pagecontroll响应值的变化
}

- (void)changePage:(id)sender {
    int page = _pageControl.currentPage;//获取当前pagecontroll的值
    [_scrollView setContentOffset:CGPointMake(320 * page, 0)];//根据pagecontroll的值来改变scrollview的滚动位置，以此切换到指定的页面
}

#pragma mark-获取键盘的大小
-(void)KeyboardWillShow:(NSNotification*)notification
{
    CGRect keyBoardRect =
    [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
   // NSLog(@"%f",kScreenHeight);
    //NSLog(@"sdf%f",keyBoardRect.size.height);
   
    _imgHead.frame = CGRectMake(5, 50, 50, 50);
    _textContentView.frame = CGRectMake(60, 50, 255, kScreenHeight-keyBoardHeight-115);

    
}

- (void)disFaceKeyboard
{
    
    //如果键盘没有显示，点击表情了，隐藏表情，显示键盘
    if (!keyboardIsShow) {
        keyboardIsShow = YES;
    [_textContentView becomeFirstResponder];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"face@2x.png"] forState:UIControlStateNormal];
    } else {
        
        keyboardIsShow = NO;
        [_textContentView resignFirstResponder];
        
        //创建表情键盘
        if (_scrollView==nil) {
            self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, kScreenHeight-keyBoardHeight-20, kScreenWidth, keyBoardHeight)];
            [_scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"face_background.png"]]];
            
            NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:105];
            
            NSString *str = @"h";
            for (int i = 0; i < 105; i++) {
                if (i < 10) {
                    str = [str stringByAppendingFormat:@"00%d",i];
                }
                if (i < 100 && i >= 10) {
                    str = [str stringByAppendingFormat:@"0%d",i];
                }
                if (i>=100) {
                    str = [str stringByAppendingFormat:@"%d",i];
                }
                
                [muArr addObject:str];
                str = @"h";
                
            }
            
            
            for (int i=0; i<3; i++) {
                FacialView *fview=[[FacialView alloc] initWithFrame:CGRectMake(12+320*i, 15, kScreenWidth, keyBoardHeight)];
                fview.faces = [NSArray arrayWithArray:muArr];
                [fview setBackgroundColor:[UIColor clearColor]];
                [fview loadFacialView:i size:CGSizeMake(33, 43)];
                fview.delegate=self;
                [_scrollView addSubview:fview];
                
            }
           
        }
        
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        _scrollView.contentSize=CGSizeMake(320*105/35, keyBoardHeight);
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        [self.view addSubview:_scrollView];
        
        
        self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(98, kScreenHeight-50, 150, 30)];
        [_pageControl setCurrentPage:0];
        _pageControl.pageIndicatorTintColor= [UIColor colorWithRed:195/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:132/255.0 green:104/255.0 blue:77/255.0 alpha:1];
        _pageControl.numberOfPages = 105/35;//指定页面个数
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        _pageControl.hidden=NO;
        [_pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_pageControl];

        [_faceButton setBackgroundImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];

    }    
}




#pragma mark 监听键盘的显示与隐藏
-(void)inputKeyboardWillShow:(NSNotification *)notification{
    //键盘显示，设置toolbar的frame跟随键盘的frame
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
    [_pageControl setHidden:YES];
}
-(void)inputKeyboardWillHide:(NSNotification *)notification{
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    
}

- (void)doCancel:(UIButton *)sender {

    [self dismissSelf];

}

- (void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doPublish:(UIButton *)sender
{
    
    if (_cameraImage != nil && (NSNull *)_cameraImage != [NSNull null]) {
        [self sendImageMessage];
    } else {
        [self sendMessage];
    }
    
}

//发表一条微博信息
-(void)sendMessage
{
    HttpRequestModel *httpRM = [HttpRequestModel shareHttpRequestModel];
    NSString *urlStr = @"https://open.t.qq.com/api/t/comment";
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:@"json" forKey:@"format"];
    [request setPostValue:_textContentView.text forKey:@"content"];
    [request setPostValue:_txwb.wbID forKey:@"reid"];
    [request setPostValue:@"0" forKey:@"syncflag"];
    [request setPostValue:TX_APP_KEY forKey:@"oauth_consumer_key"];
    [request setPostValue:httpRM.accessToken forKey:@"access_token"];
    [request setPostValue:httpRM.openid forKey:@"openid"];
    [request setPostValue:httpRM.client_id forKey:@"clientip"];
    
    [request setPostValue:@"2.a" forKey:@"oauth_version"];
    [request setPostValue:@"all" forKey:@"scope"];
    

    [request setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
        [dic self];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"发表成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
    [request startSynchronous];
}

//发表一条带图片的微博
-(void)sendImageMessage
{
    HttpRequestModel *httpRM = [HttpRequestModel shareHttpRequestModel];
    NSString *urlStr = @"https://open.t.qq.com/api/t/add_pic";
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    
    
    [request setPostValue:@"json" forKey:@"format"];
    [request setPostValue:_textContentView.text forKey:@"content"];
    [request setPostValue:TX_APP_KEY forKey:@"oauth_consumer_key"];
    [request setPostValue:httpRM.accessToken forKey:@"access_token"];
    [request setPostValue:httpRM.openid forKey:@"openid"];
    [request setPostValue:httpRM.client_id forKey:@"clientip"];
    
    [request setPostValue:@"2.a" forKey:@"oauth_version"];
    [request setPostValue:@"all" forKey:@"scope"];

    [request addData:UIImagePNGRepresentation(_cameraImage) forKey:@"pic"];
    [request setCompletionBlock:^{
        NSError *error = nil;
       // NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"发表成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

        
    }];
    [request startAsynchronous];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSelector:@selector(dismissSelf) withObject:nil afterDelay:.1];
}

- (IBAction)doImagePicker:(id)sender {
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancle" destructiveButtonTitle:@"相机" otherButtonTitles:@"手机相册中选取", nil];
    [actSheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
    switch (buttonIndex) {
        case 0://相机
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1://手机相册中选取
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            return;
            break;
        default:
            break;
    }
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.mediaTypes = temp_MediaTypes;
        picker.delegate=self;
        picker.allowsEditing = YES;
    }
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_btnCamaer setImage:_cameraImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
