//
//  JGProvinceManagerModel.h
//  JGAreaPicker
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGAreaManagerModel : NSObject

//地区编码
@property (nonatomic, copy) NSString *areaId;
//地区名
@property (nonatomic, copy) NSString *areaName;

@end


@interface JGCityManagerModel : NSObject

//地区编码
@property (nonatomic, copy) NSString *areaId;
//地区名
@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, strong) NSArray<JGAreaManagerModel *> *counties;

@end


@interface JGProvinceManagerModel : NSObject

//地区编码
@property (nonatomic, copy) NSString *areaId;
//地区名
@property (nonatomic, copy) NSString *areaName;
//子集
@property (nonatomic, strong) NSArray<JGCityManagerModel *> *cities;

@end







NS_ASSUME_NONNULL_END
