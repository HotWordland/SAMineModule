//
//  RBShaperLayerView.m
//  RiverBank
//
//  Created by Curse Tom on 2020/11/24.
//

#import "RBShaperLayerView.h"

@implementation RBShaperLayerView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0].CGColor;
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0].CGColor;
    }
    return self;

}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
//    [super setBackgroundColor:backgroundColor];
    ((CAShapeLayer *)self.layer).fillColor = backgroundColor.CGColor;
}


@end
