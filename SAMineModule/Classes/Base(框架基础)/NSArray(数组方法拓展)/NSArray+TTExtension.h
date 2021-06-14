//
//  NSArray+TTExtension.h
//  RiverBank
//
//  Created by Ryzen on 2021/1/5.
//

#import <Foundation/Foundation.h>
#import "NSArray+Map.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (TTExtension)
/** 过滤 */
-(NSArray *)filter:(BOOL (^)(id _Nullable evaluatedObject, NSDictionary<NSString *, id> * _Nullable bindings))block;

@end

NS_ASSUME_NONNULL_END
