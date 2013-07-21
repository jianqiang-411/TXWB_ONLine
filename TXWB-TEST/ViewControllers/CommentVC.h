//
//  CommentVC.h
//  TXWB-TEST
//
//  Created by SDJG on 13-7-19.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXWBObject;
@interface CommentVC : UIViewController <UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic ,strong) UIImage *cameraImage;//获取用户将发的照片
@property (retain, nonatomic) TXWBObject *txwb;
@property (strong, nonatomic) IBOutlet UIButton *btnPublish;
@property (strong, nonatomic) IBOutlet UIButton *btnCancle;

@property (strong, nonatomic) IBOutlet UIButton *btnCamaer;
@property (strong, nonatomic) IBOutlet UIImageView *imgHead;
@property (strong, nonatomic) IBOutlet UITextView *textContentView;


- (IBAction)doCancel:(id)sender;
- (IBAction)doPublish:(id)sender;
- (IBAction)doImagePicker:(id)sender;


@end
