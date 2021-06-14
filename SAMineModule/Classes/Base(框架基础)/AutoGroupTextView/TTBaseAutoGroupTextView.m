//
//  TTBaseAutoGroupTextView.m
//  RiverBank
//
//  Created by Curse Tom on 2020/11/27.
//

#import "TTBaseAutoGroupTextView.h"

@interface TTBaseAutoGroupTextView()

@end
@implementation TTBaseAutoGroupTextView

/** 文案字体大小 */
-(CGFloat)textFontSize
{
    return 16;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (!self.textFont) {
            self.textFont = [UIFont systemFontOfSize:self.textFontSize];
        }
        [self setup];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        if (!self.textFont) {
            self.textFont = [UIFont systemFontOfSize:self.textFontSize];
        }
        [self setup];
    }
    return self;
}
- (void)setup {
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    //实时监听textView值得改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark ====== 计算高度 ======
//UITextViewDelegate代理, 在这里让textView高度自适应, 同时设置最大高度, 类似于QQ微信输入框的效果
- (void)textDidChange {
    //计算高度
    CGFloat height = ceilf([self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height);
    if (height > _maxTextH) {
        height = _maxTextH;
        self.scrollEnabled = YES;   //当textView大于最大高度的时候让其可以滚动
    } else {
        self.scrollEnabled = NO;
        if (_textChangedBlock && self.scrollEnabled == NO) {
            _textChangedBlock(height);
        }
    }
    if (_textChangedBlock) {
        _textChangedBlock(height);
    }
    [self layoutIfNeeded];
}
#pragma mark ====== 设置placeholder ======
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    /**
     *  根据最大的行数计算textView的最大高度
     *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

#pragma mark ====== 回调 ======
- (void)textValueDidChanged:(TextHeightChangedBlock)block {
    _textChangedBlock = block;
}

#pragma mark ====== 移除监听 ======
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

@end
