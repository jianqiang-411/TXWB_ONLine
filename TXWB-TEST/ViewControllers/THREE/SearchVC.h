//
//  SearchVC.h
//  TXWB-TEST
//
//  Created by SDJG on 13-7-22.
//  Copyright (c) 2013年 xue. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController
typedef enum {
    
    RequestTypeOfTopic,
    RequestTypeOfWeiBo,
    RequestTypeOfUser,
    RequestTypeOfUserByTag,
    
}RequestType;
@end
