//
//  CustumCell.h
//  PullingRegresh
//
//  Created by kevin on 13-6-6.
//  Copyright (c) 2013年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QiuShi;

@interface CustumCell : UITableViewCell 
- (void)configContentCellWithQiuShi:(QiuShi *)qs;
- (void)resizeContentCellHeight;
@end
