//
//  CVResponsiveButton.m
//
//  Created by Richard Jung on 2013-06-24.
//  Copyright (c) 2013 by Jung IT & CoreVision. All rights reserved.
//  Licensed under MIT

#import "CVResponsiveButton.h"

#define HIGHLIGHT_COLOR [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1]
@interface CVResponsiveButton ()

@property (nonatomic, retain) UIView *highlightView;

@end

@implementation CVResponsiveButton

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    _dontRemove = NO;
    self.highlightBackgroundColor = HIGHLIGHT_COLOR;
    self.fadingTime = 0.7;
    [self addTarget:self action:@selector(performAction) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(showHighlighting) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(hideHighlighting) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(hideHighlighting) forControlEvents:UIControlEventTouchCancel];

}

#pragma mark - Actions
- (void)performAction {
    [self hideHighlighting];
}

#pragma mark - Highlight management
- (void)showHighlighting {
    if (self.willStartTouch != nil) {
        self.willStartTouch(self);
    }
    if (self.highlightView == nil) {
        self.highlightView = [[UIView alloc] initWithFrame:self.bounds];
        self.highlightView.backgroundColor = self.highlightBackgroundColor;
        self.highlightView.alpha = 0.0f;
        self.highlightView.userInteractionEnabled = YES;
        [self insertSubview:self.highlightView atIndex:([self.subviews count] - 1)];
    } else {
        _dontRemove = YES;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.highlightView.alpha = 0.5f;
    }];
    if (self.didStartTouch != nil) {
        self.didStartTouch(self);
    }
}

- (void)hideHighlighting {
    
    if (self.willEndTouch != nil) {
        
        self.willEndTouch(self);
    }
    
    [UIView animateWithDuration:self.fadingTime
                          delay:0.0
                        options:UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.highlightView.alpha = 0.0f;
                     }
                     completion:^(BOOL completed) {
                         
                         if (!_dontRemove) {
                            
                             if (self.didEndTouch != nil) {
                                 
                                 self.didEndTouch(self);
                             }
                             [self.highlightView removeFromSuperview];
                             self.highlightView = nil;
                         }
                     }];
}

@end
