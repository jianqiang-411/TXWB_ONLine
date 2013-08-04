//
//  TwoVC.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "TwoVC.h"
#import "ASIHTTPRequest.h"
#import "Define.h"
#import "HttpRequestModel.h"
#import "TXWBObject.h"
#import "AppUItility.h"
#import "CustomCell_One.h"
#import "OneVC_SonFirst.h"
@interface TwoVC () <PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) PullingRefreshTableView *pullingRefresh;
@property (retain, nonatomic) NSMutableArray *arrTableList;
@property (strong, nonatomic) HttpRequestModel *httpRM;
@property (assign, nonatomic) BOOL bIsRefreshing;

@end

@implementation TwoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"more_icon7"];
        self.tabBarItem.title = @"消息";
        self.requestType = RequestTypeOfMentions;
        self.bIsRefreshing = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.httpRM = [HttpRequestModel shareHttpRequestModel];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    view.userInteractionEnabled = YES;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(18, 3.5, 44, 37);
    [button1 setImage:[UIImage imageNamed:@"mention_all@2x.png"] forState:UIControlStateNormal];

    button1.tag = 2000;
    [button1 addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(98, 3.5, 44, 37);
    button2.tag = 2001;
    [button2 addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setImage:[UIImage imageNamed:@"mention_follow_press@2x.png"] forState:UIControlStateNormal];
    [view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(178, 3.5, 44, 37);
    button3.tag = 2002;
    [button3 addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setImage:[UIImage imageNamed:@"mention_vip_press@2x.png"] forState:UIControlStateNormal];
    [view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(258, 3.5, 44, 37);
    button4.tag = 2003;
    [button4 addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [button4 setImage:[UIImage imageNamed:@"mention_private_msg_press@2x.png"] forState:UIControlStateNormal];
    [view addSubview:button4];
    
    self.navigationItem.titleView = view;
    self.pullingRefresh = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth+200) pullingDelegate:self];
    _pullingRefresh.dataSource = self;
    _pullingRefresh.delegate = self;
    _pullingRefresh.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_pullingRefresh launchRefreshing];
    [self.view addSubview:_pullingRefresh];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setColor];
    
}

- (void)setColor
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theme"] isEqualToString:@"darkGreen"]) {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_blue.png"]]];
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_blue.png"]]];
    } else {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_red.png"]]];
        [self.tabBarController.tabBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_red.png"]]];
    }
}

- (void)clickedButton:(UIButton *)sender
{
    UIButton *btn = (UIButton *)[self.navigationItem.titleView viewWithTag:sender.tag];
    switch (sender.tag) {
            
        case 2000:
        {
            _bIsRefreshing = YES;
            _requestType = RequestTypeOfMentions;
            [btn setImage:[UIImage imageNamed:@"mention_all@2x.png"]
                 forState:UIControlStateNormal];
            [self loadData];
            [self changeBtnImage:sender.tag];
        }
            break;
        case 2001:
        {
            _bIsRefreshing = YES;
            _requestType = RequestTypeOfSpecial;
            [btn setImage:[UIImage imageNamed:@"mention_follow@2x.png"] forState:UIControlStateNormal];
            //[self loadData];
            [self changeBtnImage:sender.tag];
        }
            break;
        case 2002:
        {
            _bIsRefreshing = YES;
            _requestType = RequestTypeOfVip;
            [btn setImage:[UIImage imageNamed:@"mention_vip@2x.png"] forState:UIControlStateNormal];
            [self loadData];
            [self changeBtnImage:sender.tag];
        }
            break;
        case 2003:
        {
            _bIsRefreshing = YES;
            _requestType = RequestTypeOfRecv;
            [btn setImage:[UIImage imageNamed:@"mention_private_msg@2x.png"] forState:UIControlStateNormal];
            [self loadData];
            [self changeBtnImage:sender.tag];
        }
            break;
            
        default:
            break;
    }
}

- (void)changeBtnImage:(NSInteger)tag
{
    
    switch (tag) {
        case 2000:
        {
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2001]) setImage:[UIImage imageNamed:@"mention_follow_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2002]) setImage:[UIImage imageNamed:@"mention_vip_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2003]) setImage:[UIImage imageNamed:@"mention_private_msg_press@2x.png"] forState:UIControlStateNormal];
        }
            break;
        case 2001:
        {
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2000]) setImage:[UIImage imageNamed:@"mention_all_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2002]) setImage:[UIImage imageNamed:@"mention_vip_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2003]) setImage:[UIImage imageNamed:@"mention_private_msg_press@2x.png"] forState:UIControlStateNormal];
        }
            break;
        case 2002:
        {
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2000]) setImage:[UIImage imageNamed:@"mention_all_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2001]) setImage:[UIImage imageNamed:@"mention_follow_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2003]) setImage:[UIImage imageNamed:@"mention_private_msg_press@2x.png"] forState:UIControlStateNormal];
        }
            break;
        case 2003:
        {
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2000]) setImage:[UIImage imageNamed:@"mention_all_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2001]) setImage:[UIImage imageNamed:@"mention_follow_press@2x.png"] forState:UIControlStateNormal];
            [((UIButton *)[self.navigationItem.titleView viewWithTag:2002]) setImage:[UIImage imageNamed:@"mention_vip_press@2x.png"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
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
    OneVC_SonFirst *sonFirst = [[OneVC_SonFirst alloc] init];
    sonFirst.txwb = [_arrTableList objectAtIndex:indexPath.row];
    sonFirst.fContentCellHeight = [self getCellHeightWithIndexPath:indexPath];
    [self.navigationController pushViewController:sonFirst animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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

- (void)loadData
{
    if (_bIsRefreshing) {
        _pageflag = 0;
        _startindex = 0;
        if (_arrTableList == nil) {
            self.arrTableList = [[NSMutableArray alloc] initWithCapacity:20];
        } else {
            [_arrTableList removeAllObjects];
        }
        _pullingRefresh.reachedTheEnd = NO;
    }
    else {
            if (_httpRM.hasnext == 0) {//下面还有
                _pageflag++;
            
                if(_pageflag > 20) {
                    _pullingRefresh.reachedTheEnd = YES;
                    [_pullingRefresh tableViewDidFinishedLoadingWithMessage:@"下面没有了"];
                    return; 
                }
            
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
    

    NSString *urlStr = nil;
    NSURL *url = nil;
   
    switch (_requestType) {
        case RequestTypeOfMentions:
            urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/mentions_timeline?format=json&pageflag=%d&pagetime=%d&reqnum=%d&lastid=0&type=%d&contenttype=%d&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_pageflag,_pagetime,_reqnum,_type,_contenttype,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
            break;
        case RequestTypeOfSpecial:
            urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/special_timeline?format=json&pageflag=%d&pagetime=%d&reqnum=%d&lastid=0&type=%d&contenttype=%d&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_pageflag,_pagetime,_reqnum,_type,_contenttype,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
            break;
        case RequestTypeOfVip:
    
            urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/home_timeline_vip?format=json&pageflag=%d&pagetime=%d&reqnum=%d&lastid=0&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_pageflag,_pagetime,_reqnum,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
        
            break;
        case RequestTypeOfRecv:
        
            urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/private/recv?format=json&pageflag=%d&pagetime=%d&reqnum=%d&lastid=0&contenttype=%d&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_pageflag,_pagetime,_reqnum,_contenttype,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
        
            break;
        default:
            break;
    }
    

    url = [NSURL URLWithString:urlStr];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    
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
    

    
    [request setFailedBlock:^{
        _bIsRefreshing = NO;
        [_pullingRefresh tableViewDidFinishedLoading];
        [AppUItility showBoxWithMessage:@"网络异常，请检查网络连接..."];
    }];

    [request startAsynchronous];
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
