//
//  CommentVC.h
//  TXWB-TEST
//
//  Created by SDJG on 13-7-19.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <UIKit/UIKit.h>

#define keyBoardHeight 216.0

@class TXWBObject;

@interface CommentVC : UIViewController <UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
        
    BOOL keyboardIsShow;//键盘是否显示
}

@property (strong, nonatomic)  UIImageView *imgHeadView;
@property (nonatomic ,strong) UIImage *cameraImage;//获取用户将发的照片
@property (retain, nonatomic) TXWBObject *txwb;
@property (strong, nonatomic)  UIButton *btnPublish;
@property (strong, nonatomic)  UIButton *btnCancle;

@property (strong, nonatomic) IBOutlet UIButton *btnCamaer;
@property (strong, nonatomic) IBOutlet UIImageView *imgHead;
@property (strong, nonatomic) IBOutlet UITextView *textContentView;

@property (strong, nonatomic) UIToolbar *toolBar;

@property (strong, nonatomic) UIButton *faceButton;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;


- (IBAction)doImagePicker:(id)sender;


@end
