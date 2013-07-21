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
@interface CommentVC ()

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
   
}

#pragma mark-获取键盘的大小
-(void)KeyboardWillShow:(NSNotification*)notification
{
    CGRect keyBoardRect =
    [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyBoardHeight = 0.0f;
    keyBoardHeight = keyBoardRect.size.height;
    
    NSLog(@"%f",keyBoardHeight);
    
    _btnCamaer.frame = CGRectMake(5, kScreenHeight-keyBoardHeight-40, 50, 40);
    _imgHead.frame = CGRectMake(5, 50, 50, 50);
    _textContentView.frame = CGRectMake(100, 50, 220, kScreenHeight-keyBoardHeight);
        
}

- (IBAction)doCancel:(id)sender {

    [self dismissSelf];

}

- (void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doPublish:(id)sender {
    
    [self sendMessage];
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
        NSLog(@"============JSON=================");
        NSLog(@"%@====",dic);
        
        [AppUItility showBoxWithMessage:@"发表成功"];
        
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
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
        NSLog(@"============JSON=================");
        NSLog(@"%@====",dic);
        
        [AppUItility showBoxWithMessage:@"发表成功"];
        
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
        case 0:
            
            break;
        case 1://相机
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 2://手机相册中选取
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
