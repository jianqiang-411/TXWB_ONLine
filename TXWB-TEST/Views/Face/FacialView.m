//
//  FacialView.m
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacialView.h"


@implementation FacialView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    //self.faceData = [[NSMutableArray alloc] initWithCapacity:105];
    }
    return self;
}

-(void)loadFacialView:(int)page size:(CGSize)size
{
    //NSLog(@"==%@",_faces);
	//row number
	for (int i=0; i<4; i++) {
		//column numer
		for (int y=0; y<9; y++) {
			UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setFrame:CGRectMake(y*size.width, i*size.height, size.width, size.height)];
            if (i==3&&y==8) {
                [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
                button.tag=10000;
                
            }else{
                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
                [button setImage:[UIImage imageNamed:[_faces objectAtIndex:i*9+y+page*35]] forState:UIControlStateNormal];
                [button setTitle: [_faces objectAtIndex:i*3+y+(page*19)]forState:UIControlStateNormal];
                button.tag=i*9+y+(page*35);
                
            }
			[button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
		}
	}
}


-(void)selected:(UIButton*)bt
{
    if (bt.tag==10000) {
        NSLog(@"点击删除");
        [delegate selectedFacialView:@"删除"];
    }else{
        NSString *str=[_faces objectAtIndex:bt.tag];
        NSLog(@"点击其他%@",str);
        [delegate selectedFacialView:str];
    }	
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

@end
