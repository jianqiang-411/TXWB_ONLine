//
//  UserInfo.m
//  TXWB-TEST
//
//  Created by xue on 13-7-6.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *userInfo = nil;
@implementation UserInfo

+ (UserInfo *)shareUserInfo
{
    @synchronized (self) {
        if (userInfo == nil) {
            userInfo = [[UserInfo alloc] init];
        }
    }
    return userInfo;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        self.birth_year = [[dataDic objectForKey:@"birth_year"] integerValue];
        self.birth_month = [[dataDic objectForKey:@"birth_month"] integerValue];
        self.birth_day = [[dataDic objectForKey:@"birth_day"] integerValue];
        
        
        ////////////
        self.fansnum = [[dataDic objectForKey:@"fansnum"] integerValue];
        self.favnum = [[dataDic objectForKey:@"favnum"] integerValue];
        self.head = [dataDic objectForKey:@"head"];
        self.name = [dataDic objectForKey:@"name"];
        self.nick = [dataDic objectForKey:@"nick"];
        
        
        /////////////
        
        self.exp = [[dataDic objectForKey:@"exp"] integerValue];   
        
             
           
    
        
    }
    
    return self;
}

@end
