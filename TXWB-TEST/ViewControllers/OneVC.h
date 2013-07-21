//
//  OneVC.h
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//


typedef enum {
    
    RequestTypeOfHome_timeline = 0,//主页
    RequestTypeOfMutual_list = 1,   //互听
    //RequestTypeOfMutual_listUser_timeline,//获取某个用户的微博信息
        
}RequestTypeOfOneViewController;


#import <UIKit/UIKit.h>

@interface OneVC : UIViewController


@property (assign, nonatomic) NSInteger pageflag;
@property (assign, nonatomic) NSInteger pagetime;
@property (assign, nonatomic) NSInteger startindex;
@property (assign, nonatomic) NSInteger reqnum;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger contenttype;



@end
