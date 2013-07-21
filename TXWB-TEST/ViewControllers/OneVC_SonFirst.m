//
//  OneVC_SonFirst.m
//  TXWB-TEST
//
//  Created by SDJG on 13-7-13.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "OneVC_SonFirst.h"
#import "Define.h"
#import "CustomCell_One.h"
#import <QuartzCore/QuartzCore.h>
#import "TXWBObject.h"
#import "AppUItility.h"
#import "CustomCell_One.h"
#import "CommentVC.h"
@interface OneVC_SonFirst () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) ASIHTTPRequest *asiRequest;
@property (strong, nonatomic) UIScrollView *photo;
@property (strong, nonatomic) UIButton *btnRebroadcast;//转播
@property (strong, nonatomic) UIButton *btnComment;//评论
@property (strong, nonatomic) UITableView *txwbTable;
@property (strong, nonatomic) UITableView *commentTable;
@property (strong, nonatomic) UILabel *lblUserName;
//@property (strong, nonatomic) UILabel *lblAtCount;
@property (retain, nonatomic) NSMutableArray *arrTableList;
@property (strong, nonatomic) HttpRequestModel *httpRM;
@property (assign, nonatomic) BOOL bIsRefreshing;
@end

@implementation OneVC_SonFirst

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.httpRM = [HttpRequestModel shareHttpRequestModel];
        self.navigationItem.title = @"最新微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   

    self.photo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 85)];
    _photo.backgroundColor = [UIColor colorWithRed:0.45 green:0.47 blue:0.53 alpha:0.5];
    _photo.userInteractionEnabled = YES;
    [self.view addSubview:_photo];
    UIImageView *imgvw_Photo1 = [[UIImageView alloc] initWithFrame:CGRectMake(3, 2.5, 80, 80)];
    [imgvw_Photo1.layer setMasksToBounds:YES];
    [imgvw_Photo1.layer setCornerRadius:10];
    if (![_txwb.head isEqualToString:@""]) {
        NSData *data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/100",_txwb.head]]];
        imgvw_Photo1.image = [UIImage imageWithData:data1];
    }
    else imgvw_Photo1.image = [UIImage imageNamed:@"filter_effect_4@2x.png"];
    
    [_photo addSubview:imgvw_Photo1];
    
    
    
    self.lblUserName = [[UILabel alloc] initWithFrame:CGRectMake(100, 2, 200, 40)];
    [_lblUserName setBackgroundColor:[UIColor clearColor]];
    [_lblUserName setTextAlignment:NSTextAlignmentLeft];
    [_lblUserName setTextColor:[UIColor redColor]];
    [_lblUserName setFont:[UIFont systemFontOfSize:20]];
    [_lblUserName setText:_txwb.nick];
    [_photo addSubview:_lblUserName];
    
    self.btnRebroadcast = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRebroadcast setFrame:CGRectMake(100, 45, 70, 40)];
    [_btnRebroadcast setTitle:@"转播" forState:UIControlStateNormal];
    [_btnRebroadcast addTarget:self action:@selector(doRebroadcast:) forControlEvents:UIControlEventTouchUpInside];
    [_photo addSubview:_btnRebroadcast];
    
    self.btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnComment setFrame:CGRectMake(180, 45, 70, 40)];
    [_btnComment setTitle:@"评论" forState:UIControlStateNormal];
    [_btnComment addTarget:self action:@selector(doComment:) forControlEvents:UIControlEventTouchUpInside];
    [_photo addSubview:_btnComment];
    
    //关注人数
    /*
    self.lblAtCount = [[UILabel alloc] initWithFrame:CGRectMake(100, 45, 200, 30)];
    [_lblAtCount setBackgroundColor:[UIColor clearColor]];
    [_lblAtCount setTextAlignment:NSTextAlignmentLeft];
    [_lblAtCount setTextColor:[UIColor redColor]];
    [_lblAtCount setFont:[UIFont systemFontOfSize:14]];
    [_lblAtCount setText:[NSString stringWithFormat:@"%d人收听",_txwb.idolnum]];
    [_photo addSubview:_lblAtCount];
     */
    
    self.txwbTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, _fContentCellHeight) style:UITableViewStylePlain];
    [_txwbTable setBackgroundColor:[UIColor clearColor]];
    [_txwbTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_txwbTable setAllowsSelection:NO];
    [_txwbTable setScrollEnabled:NO];
    _txwbTable.dataSource = self;
    _txwbTable.delegate = self;
    
    
    self.commentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, kScreenWidth, kScreenHeight-44) style:UITableViewStylePlain];
    [_commentTable setBackgroundColor:[UIColor clearColor]];
    [_commentTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_commentTable setAllowsSelection:NO];
    _commentTable.dataSource = self;
    _commentTable.delegate = self;
    [_commentTable setTableHeaderView:_txwbTable];
    [self.view addSubview:_commentTable];

}

- (void)doRebroadcast:(UIButton *)sender
{
    NSLog(@"转播");
}

- (void)doComment:(UIButton *)sender
{
    NSLog(@"评论");
    CommentVC *commentVC = [[CommentVC alloc] initWithNibName:@"CommentVC" bundle:nil];
    commentVC.txwb = _txwb;
    [self presentViewController:commentVC animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void)loadData
{
    if (_arrTableList == nil) {
        self.arrTableList = [[NSMutableArray alloc] initWithCapacity:10];
    }
    else {
        [_arrTableList removeAllObjects];
    }

    NSString *strUrl = [NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/user_timeline?format=json&pageflag=0&pagetime=0&reqnum=20&lastid=0&name=%@&fopenid=&type=0&contenttype=0&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",_txwb.name,TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id];
    NSLog(@"url == %@",strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    self.asiRequest = [ASIHTTPRequest requestWithURL:url];

    [_asiRequest setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_asiRequest.responseData options:kNilOptions error:&error];
        NSDictionary *dicTemp = [dic objectForKey:@"data"];
        NSArray *arrData = [dicTemp objectForKey:@"info"];
        for (NSDictionary *dicComment in arrData) {
            TXWBObject *txwb = [[TXWBObject alloc] initWithDictionary:dicComment];
            
            [_arrTableList addObject:txwb];
            
        }
        [_commentTable reloadData];
    }];
    [_asiRequest setFailedBlock:^{
        [AppUItility showBoxWithMessage:@"请求评论数据失败..."];
    }];
    [_asiRequest startSynchronous];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _txwbTable) {
        return 1;
    }
    else
        return [_arrTableList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _txwbTable) {
        static NSString *strIndentifier = @"TXWBCell";
        CustomCell_One *txwbCell = [tableView dequeueReusableCellWithIdentifier:strIndentifier];
        if (txwbCell == nil) {
            txwbCell = [[CustomCell_One alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIndentifier];
            txwbCell.backgroundColor = [UIColor clearColor];
            txwbCell.contentView.backgroundColor = [UIColor clearColor];
            [txwbCell setSelectionStyle:UITableViewCellEditingStyleNone];
        }
        [txwbCell configContentCellWithQiuShi:_txwb];
        return txwbCell;
    } else {
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
}

#pragma mark - TableViewDelegate

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

@end
