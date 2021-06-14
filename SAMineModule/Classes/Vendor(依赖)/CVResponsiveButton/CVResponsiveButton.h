//
//  CVResponsiveButton.h
//
//  Created by Richard Jung on 2013-06-24.
//  Copyright (c) 2013 by Jung IT & CoreVision. All rights reserved.
//  Licensed under MIT

#warning 需要添加button的title才能生效 

#import <UIKit/UIKit.h>

@interface CVResponsiveButton : UIButton {
    
    BOOL _dontRemove;
}

#pragma mark - Events
@property (copy) void (^willStartTouch)(CVResponsiveButton *button);
@property (copy) void (^didStartTouch)(CVResponsiveButton *button);
@property (copy) void (^willEndTouch)(CVResponsiveButton *button);
@property (copy) void (^didEndTouch)(CVResponsiveButton *button);

#pragma mark - Options
@property (nonatomic, strong) UIColor *highlightBackgroundColor;
@property (assign, readwrite) float fadingTime;

@end
