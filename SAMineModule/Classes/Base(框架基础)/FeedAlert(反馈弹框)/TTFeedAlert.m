//
//  TTFeedAlert.m
//  Travel-Tp
//
//  Created by Curse Tom on 2020/3/19.
//  Copyright © 2020 Ryzen. All rights reserved.
//

#import "TTFeedAlert.h"

@implementation TTFeedAlert
/**
 配置ui
*/
-(void)setUpUi{
    [super setUpUi];
    self.view.layer.cornerRadius = 4;
    self.view.clipsToBounds = true;
}
/**
 点击确定
*/
- (IBAction)clickSure:(UIButton *)sender {
    [self eventEmit:@"sure" param:@{}];
}

@end
