//
//  Four_edit.h
//  TXWB-TEST
//
//  Created by shangde.Jim on 13-7-24.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Four_edit : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) UIScrollView *photo;

@property (nonatomic,strong) UIImageView *edit_nick;

@property (nonatomic,strong) UIImageView *edit_intro;

@property (nonatomic,strong) UITextView *selfintro;

@end
