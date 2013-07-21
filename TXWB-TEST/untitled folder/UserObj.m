//
//  UserObj.m
//  TXWB-TEST
//
//  Created by SDJG on 13-7-11.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "UserObj.h"
#import "UserInfo.h"
#import "HttpRequestModel.h"
@implementation UserObj

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.userInfo = [UserInfo shareUserInfo];
        HttpRequestModel *httpModel = [HttpRequestModel shareHttpRequestModel];
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        _userInfo.birth_year = [[dataDic objectForKey:@"birth_year"] integerValue];
        _userInfo.birth_month = [[dataDic objectForKey:@"birth_month"] integerValue];
        _userInfo.birth_day = [[dataDic objectForKey:@"birth_day"] integerValue];
        
        
        ////////////
        _userInfo.fansnum = [[dataDic objectForKey:@"fansnum"] integerValue];
        _userInfo.favnum = [[dataDic objectForKey:@"favnum"] integerValue];
        _userInfo.head = [dataDic objectForKey:@"head"];
        _userInfo.name = [dataDic objectForKey:@"name"];
        _userInfo.nick = [dataDic objectForKey:@"nick"];

        
        /////////////        
        _userInfo.exp = [[dataDic objectForKey:@"exp"] integerValue];

        
        
        
        
    }
    
    return self;
}

@end
