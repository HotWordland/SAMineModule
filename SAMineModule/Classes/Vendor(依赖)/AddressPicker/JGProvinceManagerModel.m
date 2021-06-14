//
//  JGProvinceManagerModel.m
//  JGAreaPicker
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JGProvinceManagerModel.h"


@implementation JGAreaManagerModel

@end


@implementation JGCityManagerModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"counties" : NSStringFromClass([JGAreaManagerModel class])};
}
@end


@implementation JGProvinceManagerModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cities" : NSStringFromClass([JGCityManagerModel class])};
}

@end
