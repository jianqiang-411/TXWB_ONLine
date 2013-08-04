//
//  FacialView.h
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol facialViewDelegate

-(void)selectedFacialView:(NSString*)str;

@end


@interface FacialView : UIView {

	id<facialViewDelegate>delegate;
	
}

@property(nonatomic,assign)id<facialViewDelegate>delegate;
@property (retain, nonatomic) NSArray *faces;
-(void)loadFacialView:(int)page size:(CGSize)size;

@end
