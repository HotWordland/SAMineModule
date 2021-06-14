//
//  TTBaseTableViewCell.m
//  Travel-Tp
//
//  Created by Ryzen on 2019/11/4.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import "TTBaseTableViewCell.h"

@implementation TTBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUi];
    }
    return self;
}
+(id)generateView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
+(id)generateViewWithXibName:(NSString *)xibName{
    return [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] lastObject];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setSelected:highlighted animated:animated];
    [self highlightHandle:highlighted animated:animated];
}
/**
 高亮的处理
 交给子类复写
*/
-(void)highlightHandle:(BOOL)highlighted animated:(BOOL)animated
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = highlighted ? 0.6 : 1;
    }];
}
+(CGFloat)getHeight{
    return 0;
}
/**
 设置ui
 */
- (void)setUpUi{
    [self fm_instanceLoadXib];
    if (self.view) {
        //    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
//        self.layer.cornerRadius = self.view.layer.cornerRadius = 3.f;
        PREPCONSTRAINTS(self.view);
        [self.contentView addSubview:self.view];
        ALIGN_TOP(self.view, 0);
        ALIGN_BOTTOM(self.view, 0);
        ALIGN_LEFT(self.view, 0);
        ALIGN_RIGHT(self.view, 0);
        self.view.backgroundColor = [UIColor whiteColor];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/** 获取当前布局状态高度 */
-(CGFloat)getCurrentLayoutHeight
{
    [self layoutIfNeeded];
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */
-(void)eventEmit:(id)event param:(id)param
{
    !self.emitEvent ?: self.emitEvent(event, param);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
