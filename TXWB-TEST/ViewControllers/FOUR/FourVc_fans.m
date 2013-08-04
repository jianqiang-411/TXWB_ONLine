//
//  FourVc_fans.m
//  TXWB-TEST
//
//  Created by shangde.Jim on 13-7-25.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "FourVc_fans.h"
#import "TXWBObject.h"
#import <QuartzCore/QuartzCore.h>
#import "Define.h"
#import "HttpRequestModel.h"
#import "AppUItility.h"
#import "CustomCell_One.h"
#import "UserInfo.h"
#import "PullingRefreshTableView.h"
@interface FourVc_fans ()<PullingRefreshTableViewDelegate, UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) NSMutableArray *arrTableList;
@property (nonatomic,strong) PullingRefreshTableView *pullingRefresh;
@property (strong, nonatomic) HttpRequestModel *httpRM;
@property (assign, nonatomic) BOOL bIsRefreshing;

@end

@implementation FourVc_fans

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.httpRM = [HttpRequestModel shareHttpRequestModel];
        self.arrTableList = [[NSMutableArray alloc] initWithCapacity:20];

        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.frame = CGRectMake(0, 0, 68, 44);
        [btnBack setBackgroundImage:[UIImage imageNamed:@"topbar_button_back.png"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
        [btnBack setTitle:@"后退" forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    }
    return self;
}

- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"我收听的人";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.pullingRefresh = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) pullingDelegate:self];
    _pullingRefresh.dataSource = self;
    _pullingRefresh.delegate = self;
    _pullingRefresh.backgroundColor = [UIColor clearColor];
    _pullingRefresh.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_pullingRefresh launchRefreshing];
    [self.view addSubview: _pullingRefresh];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_pullingRefresh launchRefreshing];
    [self.view addSubview: _pullingRefresh];

}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *newCellIdentifier = @"NewCell";
    CustomCell_One *cell = [tableView dequeueReusableCellWithIdentifier:newCellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomCell_One alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellEditingStyleNone];
        
    }
    TXWBObject *txwb = [_arrTableList objectAtIndex:indexPath.row];
    [cell configContentCellWithQiuShi:txwb];
    return cell;
    
    
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self getCellHeightWithIndexPath:indexPath];
    
    
}

- (float)getCellHeightWithIndexPath:(NSIndexPath *)indexPaht
{
    TXWBObject *txwb = [_arrTableList objectAtIndex:indexPaht.row];
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:14.0f];
    float fRowHeight = 0.0f;
    float fContentHeight = 0.0f;
    float fSCHeadHeight = 0.0f;
    float fSCContentHeight = 0.0f;
    float fSCImageHeight = 0.0f;
    
    if (txwb.text != nil && ![txwb.text isEqualToString:@""]) {
        CGSize size = [txwb.text sizeWithFont:font constrainedToSize:CGSizeMake(280, 150) lineBreakMode:NSLineBreakByTruncatingTail];
        fContentHeight = size.height;
    }
    
    if ((txwb.scHead != nil && ![txwb.scHead isEqualToString:@""]) || (txwb.scNick != nil && ![txwb.scNick isEqualToString:@""])) {
        fSCHeadHeight = 45.0f;
    }
    
    if (txwb.scText != nil && ![txwb.scText isEqualToString:@""]) {
        CGSize size = [txwb.scText sizeWithFont:font constrainedToSize:CGSizeMake(260, 220) lineBreakMode:NSLineBreakByTruncatingTail];
        fSCContentHeight = size.height;
    }
    
    if (txwb.arrSCImgUrl != nil && (NSNull *)txwb.arrSCImgUrl != [NSNull null]) {
        fSCImageHeight = 80.0f;
    }
    
    fRowHeight = fContentHeight + fSCHeadHeight + fSCContentHeight +fSCImageHeight +110.0f;
    
    return fRowHeight;
    
}

#pragma mark-pullingdelegate
//上拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5];
}
//下拉
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5];
}

#pragma mark -
#pragma mark 本类方法
- (void)loadData
{
    if (_bIsRefreshing) {
        [_arrTableList removeAllObjects];
        _pullingRefresh.reachedTheEnd = NO;
    }
    else {
        if (_httpRM.hasnext == 0) {//下面还有
            _pageflag++;
            
            if(_pageflag > 20) {
                _pullingRefresh.reachedTheEnd = YES;
                [_pullingRefresh tableViewDidFinishedLoadingWithMessage:@"下面没有了"];
                return; }
            
        } else {
            _pullingRefresh.reachedTheEnd = YES;
            [_pullingRefresh tableViewDidFinishedLoadingWithMessage:@"下面没有了"];
            
            return;
        }
        
    }
    
    self.pagetime = 0;
    self.reqnum = 20;
    self.type = 0;
    self.contenttype = 0;
    
    
    
    
    NSURL* url = [NSURL URLWithString:@"https://open.t.qq.com/api/friends/idollist_s"];
    //urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/home_timeline?format=json&pageflag=%d&pagetime=%d&reqnum=%d&type=%d&contenttype=%d&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_pageflag,_pagetime,_reqnum,_type,_contenttype,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:TX_APP_KEY forKey:@"oauth_consumer_key"];
    [request setPostValue:_httpRM.accessToken forKey:@"access_token"];
    [request setPostValue:_httpRM.openid forKey:@"openid"];
    [request setPostValue:_httpRM.client_id forKey:@"clientip"];
    [request setPostValue:@"2.a" forKey:@"oauth_version"];
    [request setPostValue:@"all" forKey:@"scope"];
    [request setPostValue:@"json" forKey:@"format"];
    [request setPostValue:@"0"  forKey:@"pageflag"];
    [request setPostValue:@"0" forKey:@"pagetime"];
    [request setPostValue:@"70" forKey:@"reqnum"];
    [request setPostValue:@"0" forKey:@"lastid"];
    
    UserInfo *userInfo = [UserInfo shareUserInfo];
    [request setPostValue:userInfo.openid forKey:@"fopenid"];
    [request setPostValue:@"3" forKey:@"type"];
    [request setPostValue:@"0" forKey:@"contenttype"];
    
    
    
    [request setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];

        NSDictionary *dicTemp = [dic objectForKey:@"data"];
        
        
        _httpRM.hasnext = [[dicTemp objectForKey:@"hasnext"] integerValue];
        
        NSArray *tempArr = [dicTemp objectForKey:@"info"];
        
        for (NSDictionary *tempDic in tempArr) {
            TXWBObject *txwb = [[TXWBObject alloc] initWithDictionary:tempDic];
            [_arrTableList addObject:txwb];
        }
        [_pullingRefresh reloadData];
        _bIsRefreshing = NO;
        [_pullingRefresh tableViewDidFinishedLoading];
        [self.navigationController setNavigationBarHidden:NO];
        
    }];
    
    [request startAsynchronous];
    
    [request setFailedBlock:^{
        _bIsRefreshing = NO;
        [_pullingRefresh tableViewDidFinishedLoading];
        [AppUItility showBoxWithMessage:@"网络异常，请检查网络连接..."];
    }];
}


#pragma mark - UIScrollViewDelegate
// －－－－上拉和下拉的刷新必须重写下面的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_pullingRefresh tableViewDidScroll:scrollView];
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_pullingRefresh tableViewDidEndDragging:scrollView];
}

@end
