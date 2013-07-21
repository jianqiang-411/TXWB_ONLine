//
//  UserObj.h
//  TXWB-TEST
//
//  Created by SDJG on 13-7-11.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
@interface UserObj : NSObject
@property (strong, nonatomic) UserInfo *userInfo;
- (id)initWithDictionary:(NSDictionary *)dic;
@end
