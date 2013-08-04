//
//  OneVC.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "OneVC.h"
#import "CustomCell_One.h"
#import "TXWBObject.h"
#import "HttpRequestModel.h"
#import "AppUItility.h"
#import "Define.h"
#import "UserInfo.h"
#import "OneVC_SonFirst.h"
#import "CommentVC.h"

@interface OneVC () <PullingRefreshTableViewDelegate, UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) PullingRefreshTableView *pullingRefresh;
@property (assign, nonatomic) RequestTypeOfOneViewController requestType;
@property (nonatomic, strong) UIImageView *imgvw;

@property (strong, nonatomic) UILabel *headLbl;
@property (strong, nonatomic) UIButton *btnHeadMid;
@property (strong, nonatomic) UIButton *btnHeadRight;


@property (retain, nonatomic) NSMutableArray *arrTableList;
@property (strong, nonatomic) HttpRequestModel *httpRM;
@property (assign, nonatomic) BOOL bIsRefreshing;
@property (assign, nonatomic) BOOL bIsPopView;


@end

@implementation OneVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.httpRM = [HttpRequestModel shareHttpRequestModel];
        self.arrTableList = [[NSMutableArray alloc] initWithCapacity:20];
        self.requestType = RequestTypeOfHome_timeline;
        self.bIsPopView = NO;
        [self addObserver:self forKeyPath:@"requestType" options:NSKeyValueObservingOptionNew context:nil];
        self.view.backgroundColor = [UIColor whiteColor];
        self.tabBarItem.image = [UIImage imageNamed:@"more_icon6"];
        self.tabBarItem.title = @"主页";

        /*----------------导航栏中间--------------------*/
        self.btnHeadMid = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnHeadMid.frame = CGRectMake(0, 0, 120, 30);
        [_btnHeadMid setImage:[UIImage imageNamed:@"register_arrow.png"] forState:UIControlStateNormal];
        [_btnHeadMid setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -100)];
        [_btnHeadMid setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        [_btnHeadMid setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        if ([UserInfo shareUserInfo].nick != nil && ![[UserInfo shareUserInfo].nick isEqualToString:@""])
        {
            [_btnHeadMid setTitle:[UserInfo shareUserInfo].nick forState:UIControlStateNormal];
        } 
        
        [_btnHeadMid addTarget:self action:@selector(pressedMidButton:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = _btnHeadMid;
        
        /*----------------导航栏右边--------------------*/
        self.btnHeadRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnHeadRight.frame = CGRectMake(280, 10, 40*98/88, 40);
        [_btnHeadRight setImage:[UIImage imageNamed:@"WriteNewPostNormal.png"] forState:UIControlStateNormal];
    
        [_btnHeadRight addTarget:self action:@selector(pressedRightButton:) forControlEvents:UIControlEventTouchUpInside];
        [_headLbl addSubview:_btnHeadRight];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnHeadRight];
        
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch (_requestType) {
        case RequestTypeOfHome_timeline:
            [_btnHeadMid setTitle:[UserInfo shareUserInfo].nick forState:UIControlStateNormal];        
            break;
        case RequestTypeOfMutual_list:
            [_btnHeadMid setTitle:@"相互收听" forState:UIControlStateNormal];
        default:
            break;
    }
    _bIsRefreshing = YES;
    [self loadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.pullingRefresh = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) pullingDelegate:self];
    _pullingRefresh.dataSource = self;
    _pullingRefresh.delegate = self;
    _pullingRefresh.backgroundColor = [UIColor clearColor];
    _pullingRefresh.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_pullingRefresh launchRefreshing];
    [self.view addSubview: _pullingRefresh];
    
    
    self.imgvw = [[UIImageView alloc] initWithFrame:CGRectMake(80, 10, 160, 210)];
    _imgvw.image = [UIImage imageNamed:@"poplist_bg.png"];
    _imgvw.userInteractionEnabled = YES;
    
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

- (void)pressedMidButton:(UIButton *)sender
{
    
        if (_bIsPopView == NO) {
    
            NSArray *arr = @[@"主页",@"认证用户",@"相互收听",@"QQ好友",@"微博管家"];
            float fBtnOffSet = 41;
            for (int i = 0; i < [arr count]; i++) {
                CGRect rect = CGRectMake(0, 2+fBtnOffSet*i, 160, 40);
                NSString *title = [arr objectAtIndex:i];
                [self creatButtonWithRect:rect andTitle:title andTag:100+i];
                
            }
            _bIsPopView = YES;
            [self.view addSubview:_imgvw];
        } else {
            _bIsPopView = NO;
            [_imgvw removeFromSuperview];
        }
    
    
    
    
}

- (void)creatButtonWithRect:(CGRect)rect
                   andTitle:(NSString *)title
                     andTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.tag = tag;
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeHttpRequestType:) forControlEvents:UIControlEventTouchUpInside];
    [_imgvw addSubview:btn];
}

- (void)changeHttpRequestType:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 100:
        case 101: 
            self.requestType = RequestTypeOfHome_timeline;
            break;
        case 102:
        case 103:
        case 104:
            self.requestType = RequestTypeOfMutual_list;
            break;
        default:
            break;
    }
    [_imgvw removeFromSuperview];
}

- (void)pressedRightButton:(UIButton *)sender
{
    CommentVC *commentVC = [[CommentVC alloc] initWithNibName:@"CommentVC" bundle:nil];
    [self presentViewController:commentVC animated:YES completion:nil];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTableList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (_requestType) {
            case RequestTypeOfHome_timeline:
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
                break;
            case RequestTypeOfMutual_list:
            {
                static NSString *cellIndentifier = @"cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                }
                
                TXWBObject *txwb = [_arrTableList objectAtIndex:indexPath.row];
                if ((NSNull *)txwb.head != [NSNull null] && ![txwb.head isEqualToString:@""]) {
                    
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100",txwb.head]];
                    
                    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                } else {
                    cell.imageView.image = [UIImage imageNamed:@"filter_effect_4@2x.png"];
                }
                if (![txwb.nick isEqualToString:@""]) {
                    cell.textLabel.text = txwb.nick;
                } else {
                    cell.textLabel.text = @"匿名";
                }
                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d人关注",txwb.idolnum];
                return cell;
            }
            default:
                break;
        }
    
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneVC_SonFirst *sonFirst = [[OneVC_SonFirst alloc] init];
    sonFirst.txwb = [_arrTableList objectAtIndex:indexPath.row];
    sonFirst.fContentCellHeight = [self getCellHeightWithIndexPath:indexPath];
    [self.navigationController pushViewController:sonFirst animated:YES];
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (_requestType) {
            case RequestTypeOfHome_timeline:
            {
                return [self getCellHeightWithIndexPath:indexPath];
            }
                break;
            case RequestTypeOfMutual_list:
            {
                return 120.0f;
            }
            default:
                break;
        }

    
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
        _pageflag = 0;
        _startindex = 0;
        [_arrTableList removeAllObjects];
        _pullingRefresh.reachedTheEnd = NO;
    }
    else {
        if (_httpRM.hasnext == 0) {//下面还有
            _pageflag++;
            if (_requestType == RequestTypeOfMutual_list) {
                _startindex = _reqnum*(_pageflag - 1);
            } else {
             if(_pageflag > 20) {
                _pullingRefresh.reachedTheEnd = YES;
                [_pullingRefresh tableViewDidFinishedLoadingWithMessage:@"下面没有了"];
                return; }
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
        case RequestTypeOfHome_timeline:
            urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/home_timeline?format=json&pageflag=%d&pagetime=%d&reqnum=%d&type=%d&contenttype=%d&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_pageflag,_pagetime,_reqnum,_type,_contenttype,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
            break;
        case RequestTypeOfMutual_list:
            urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/friends/mutual_list?format=json&name=%@&fopenid=&startindex=%d&reqnum=%d&install=0&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",[UserInfo shareUserInfo].name,_startindex,_reqnum,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
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
