//
//  CommentCell.h
//  SSSDemo
//
//  Created by kevin on 13-6-13.
//  Copyright (c) 2013年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comment;
@interface CommentCell : UITableViewCell
- (void)configContentCellWithComment:(Comment *)comment;
- (void)resizeContentCellHeight;
@end
