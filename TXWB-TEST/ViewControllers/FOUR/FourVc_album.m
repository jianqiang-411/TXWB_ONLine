//
//  FourVc_album.m
//  TXWB-TEST
//
//  Created by shangde.Jim on 13-7-25.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "FourVc_album.h"
#import "EMAsyncImageView.h"
#import "GalleryCell.h"
#import "HttpRequestModel.h"
#import "Define.h"
#import "ASIHTTPRequest.h"
#import "PhotoVC.h"
@interface FourVc_album ()

@property (nonatomic, retain) NSArray *urlArray;
@property (strong, nonatomic) HttpRequestModel *httpRM;

@end

@implementation FourVc_album

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        
	}
	return self;
}

- (void)viewDidLoad {
    
	[super viewDidLoad];
    self.navigationItem.title = @"微相册";
    
	[self.collectionView registerNib:[UINib nibWithNibName:@"GalleryCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    self.httpRM = [HttpRequestModel shareHttpRequestModel];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 68, 44);
    [btnBack setBackgroundImage:[UIImage imageNamed:@"topbar_button_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setTitle:@"后退" forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
	
}

- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
    [self getPics];
}


- (void)getPics {
    
    
	UIActivityIndicatorView  *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activity.center = self.view.center;
	activity.hidesWhenStopped = TRUE;
	[self.view addSubview:activity];
	[activity startAnimating];
	NSURL *url = nil;
	url = [NSURL URLWithString:[NSString stringWithFormat: @"http://open.t.qq.com/api/statuses/get_micro_album?format=json&reqnum=20&name=baojianqia5572&fopenid=&pageflag=0&pagetime=&lastid=&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=all",TX_APP_KEY,_httpRM.accessToken,_httpRM.openid,_httpRM.client_id]];
    
    
	NSURLRequest *req = [NSURLRequest requestWithURL:url];
	[NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
		NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"jsonFlickrFeed" withString:@""];
		responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
		responseString = [responseString stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
		NSError *jsonError;
		NSData *trimmedData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:trimmedData options:NSJSONReadingAllowFragments error:&jsonError];
        

		if (jsonError) {
			//NSLog(@"JSON parse error: %@", jsonError);
			return;
		}
		NSDictionary *dic = [json objectForKey:@"data"];
        NSArray *arr = [dic objectForKey:@"info"];
        
        NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:[arr count]];
        for (NSDictionary *temp in arr) {
            NSString *str = [temp objectForKey:@"image"];
            str = [str stringByAppendingString:@"/160"];
            [muArr addObject:str];
        }
        
		_urlArray = [NSArray arrayWithArray:muArr];
		[self.collectionView reloadData];
		[activity stopAnimating];
		[activity removeFromSuperview];
	}];
    
    
}

#pragma mark Collection View Methods
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section { return UIEdgeInsetsMake(10, 10, 10, 10); }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_urlArray count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, 140);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	GalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	NSURL *url = [NSString stringWithFormat:@"%@",[_urlArray objectAtIndex:indexPath.row]];
    [url self];
    cell.picView.imageUrl = [_urlArray objectAtIndex:indexPath.row];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
	GalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.picView.imageUrl = [_urlArray objectAtIndex:indexPath.row];
    
    PhotoVC *photoVC = [[PhotoVC alloc] init];
    photoVC.picUrl = cell.picView.imageUrl;
    photoVC.originImg = cell.picView;
    photoVC.originFame = cell.frame;
    
    [self presentViewController:photoVC animated:YES completion:nil];
}


@end
