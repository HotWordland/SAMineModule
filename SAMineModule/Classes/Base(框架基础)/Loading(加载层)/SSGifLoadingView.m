//
//  SSGifLoadingView.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/12/26.
//  Copyright © 2018 巫龙. All rights reserved.
//
#define kGifImageRadio 3/4 // 高/宽
#import "SSGifLoadingView.h"

@implementation SSGifLoadingView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // YYImage
        YYImage *image = [YYImage imageNamed:@"loader"];
        _gifLoadingView = [[YYAnimatedImageView alloc] initWithImage:image];
        _gifLoadingView.autoPlayAnimatedImage = true;
        [self addSubview:_gifLoadingView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageWidth = self.size.width*1.3;
    CGFloat imageHeight = imageWidth*kGifImageRadio;
    self.gifLoadingView.size = CGSizeMake(imageWidth, imageHeight);
    self.gifLoadingView.center = CGPointMake(self.width/2, self.height/2);
    [self.gifLoadingView setClipsToBounds:true];
    [self setClipsToBounds:true];
}
-(void)startLoading{
#warning 如果作为wyLoadingView 则按照viewDidLayout里面重写frame 或者 在startLoading的时候来进行frame调整
    if ([self superview]) {
        UIView *superView = [self superview];
        self.frame = superView.bounds;
    }
    [_gifLoadingView startAnimating];
}
-(void)stopLoading{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_gifLoadingView stopAnimating];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
