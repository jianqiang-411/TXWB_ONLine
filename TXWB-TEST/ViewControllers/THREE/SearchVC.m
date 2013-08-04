//
//  SearchVC.m
//  TXWB-TEST
//
//  Created by SDJG on 13-7-22.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "SearchVC.h"
#import "ASIHTTPRequest.h"
#import "HttpRequestModel.h"
#import "CustomCell_One.h"
#import "Define.h"
#import "TXWBObject.h"
#import "AppUItility.h"
@interface SearchVC () <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) ASIHTTPRequest *asiRequest;
@property (strong, nonatomic) HttpRequestModel *httpRM;
@property (retain, nonatomic) NSMutableArray *arrTableList;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) UIScrollView *scroll;
@property (retain, nonatomic) NSArray *arrType;
@property (assign, nonatomic) RequestType requestType;
@end

@implementation SearchVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.httpRM = [HttpRequestModel shareHttpRequestModel];
        self.requestType = RequestTypeOfTopic;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [_searchBar setShowsCancelButton:YES];
    _searchBar.tintColor = [UIColor colorWithRed:0.45 green:0.47 blue:0.53 alpha:0.5];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
    
    self.arrType = @[@"全部",@"用户",@"图片",@"好友广播",@"名人广播",@"视频"];
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 40)];
    _scroll.backgroundColor = [UIColor lightGrayColor];
    _scroll.userInteractionEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = FALSE;
    _scroll.contentSize = CGSizeMake([_arrType count]*80.0, 40);
    [self.view addSubview:_scroll];
    
    [self creatButtonsOnScrollView];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+40, 320, self.view.bounds.size.height) style:UITableViewStylePlain];
    _table.rowHeight = 80.0f;
    _table.dataSource = self;
    _table.delegate = self;
    
    [self.view addSubview:_table];
    
}



- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_arrTableList == nil) {
        self.arrTableList = [[NSMutableArray alloc] initWithCapacity:10];
    }
    else {
        [_arrTableList removeAllObjects];
    }
    
    NSString *strUrl = nil;
    switch (_requestType) {
        case RequestTypeOfTopic:
        {
            strUrl = [NSString stringWithFormat:@"http://open.t.qq.com/api/search/ht?format=json&keyword=%@&pagesize=20&page=1&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_searchBar.text,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
        }
            break;
        case RequestTypeOfWeiBo:
        {
            //http://open.t.qq.com/api/search/t?format=xml&keyword=高考&pagesize=20&page=1&contenttype=0&sorttype=0&msgtype=0&searchtype=0&starttime=0&endtime=0&longitue=&latitude=&radius=20000&province=&city=&needdup=0&oauth_consumer_key=xx&access_token=xx&openid=xx&clientip=xx&oauth_version=2.a&scope=xx
            strUrl = [NSString stringWithFormat:@"http://open.t.qq.com/api/search/ht?format=json&keyword=%@&pagesize=20&page=1&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_searchBar.text,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
        }
            break;
        case RequestTypeOfUser:
        {
            //http://open.t.qq.com/api/search/user?format=xml&keyword=china394337002&pagesize=20&page=1&oauth_consumer_key=xx&access_token=xx&openid=xx&clientip=xx&oauth_version=2.a&scope=xx
            strUrl = [NSString stringWithFormat:@"http://open.t.qq.com/api/search/ht?format=json&keyword=%@&pagesize=20&page=1&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_searchBar.text,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
        }
            break;
        case RequestTypeOfUserByTag:
        {
            //http://open.t.qq.com/api/search/userbytag?format=xml&keyword=高考&pagesize=15&page=1&oauth_consumer_key=xx&access_token=xx&openid=xx&clientip=xx&oauth_version=2.a&scope=xx

            strUrl = [NSString stringWithFormat:@"http://open.t.qq.com/api/search/ht?format=json&keyword=%@&pagesize=20&page=1&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_searchBar.text,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
        }
            break;
            
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString:strUrl];

    self.asiRequest = [ASIHTTPRequest requestWithURL:url];
    
    [_asiRequest setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_asiRequest.responseData options:kNilOptions error:&error];
        NSDictionary *dicTemp = [dic objectForKey:@"data"];
        NSArray *arrData = [dicTemp objectForKey:@"info"];
        switch (_requestType) {
            case RequestTypeOfTopic:
            {

                _arrTableList = [NSMutableArray arrayWithArray:arrData];
                
            }
                break;
            case RequestTypeOfWeiBo:
            {
                
            }
                break;
            case RequestTypeOfUser:
            {
                
            }
                break;
            case RequestTypeOfUserByTag:
            {
                
            }
                break;
                
            default:
                break;
        }
//
//        for (NSDictionary *dicComment in arrData) {
//            TXWBObject *txwb = [[TXWBObject alloc] initWithDictionary:dicComment];
//            
//            [_arrTableList addObject:txwb];
//            
//        }
        [_table reloadData];
    }];
    [_asiRequest setFailedBlock:^{
        [AppUItility showBoxWithMessage:@"请求评论数据失败..."];
    }];
    [_asiRequest startSynchronous];
    [_searchBar resignFirstResponder];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (_requestType) {
        case RequestTypeOfTopic:
        {
            return [_arrTableList count];
            
        }
            break;
        case RequestTypeOfWeiBo:
        {
            
        }
            break;
        case RequestTypeOfUser:
        {
            
        }
            break;
        case RequestTypeOfUserByTag:
        {
            
        }
            break;
            
        default:
            break;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (_requestType) {
        case RequestTypeOfTopic:
        {
            static NSString *cellIndentifire = @"cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifire];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifire];
                [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            }
            NSDictionary *dic = [_arrTableList objectAtIndex:indexPath.row];
            cell.textLabel.text = [dic objectForKey:@"id"];
            cell.detailTextLabel.text = [dic objectForKey:@"text"];
            
            return cell;
        }
            break;
        case RequestTypeOfWeiBo:
        {
            
        }
            break;
        case RequestTypeOfUser:
        {
            
        }
            break;
        case RequestTypeOfUserByTag:
        {
            
        }
            break;
            
        default:
            break;
    }
return nil;
}

- (void)creatButtonsOnScrollView
{
    
    for (int i = 0; i < [_arrType count]; i++) {

        CGFloat fBtnWidth = 80.0f;
        CGFloat fBtnHeight = 40.0f;
        CGRect rect = CGRectMake(fBtnWidth*i, 0, fBtnWidth, fBtnHeight);
   
        [self creatButtonWithFram:rect andTitle:[_arrType objectAtIndex:i] andTag:5000+i];
    }
}

- (void)creatButtonWithFram:(CGRect)rect
                   andTitle:(NSString *)title
                     andTag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.tag = tag;
    [btn setBackgroundImage:[UIImage imageNamed:@"search_tabbar_btn_h@2x.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"search_tabbar_btn_nor@2x.png"] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickedTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:btn];
}

- (void)clickedTypeButton:(UIButton *)sender
{
    //UIButton *btn = (UIButton *)[_scroll viewWithTag:sender.tag];
    switch (sender.tag) {
        case 5000:
        {
            //1.she bgColor
            //2.she RequestType
            //NSLog(@"000");
        }
            break;
        case 5001:
        {
           // NSLog(@"111");
        }
            break;
        case 5002:
        {
            //NSLog(@"222");
        }
            break;
        case 5003:
        {
            //NSLog(@"333");
        }
            break;
        case 5004:
        {
            //NSLog(@"444");
        }
            break;
        case 5005:
        {
            //NSLog(@"555");
        }
            break;
        default:
            break;
    }
}

@end
