//
//  TwoVC.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "TwoVC.h"

@interface TwoVC () <PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)PullingRefreshTableView *pullingRefresh;

@end

@implementation TwoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"more_icon7"];
        self.tabBarItem.title = @"消息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pullingRefresh = [[PullingRefreshTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    //_pullingRefresh.dataSource = self;
    _pullingRefresh.delegate = self;
    _pullingRefresh.separatorStyle =UITableViewCellSeparatorStyleNone;
    //[_pullingRefresh launchRefreshing];
    [self.view addSubview:_pullingRefresh];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

#pragma mark-pullingdelegate
//上拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    //[self performSelector:@selector(loadHeadData) withObject:nil afterDelay:0.5];
}
//下拉
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    //[self performSelector:@selector(loadFootData) withObject:nil afterDelay:0.5];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
