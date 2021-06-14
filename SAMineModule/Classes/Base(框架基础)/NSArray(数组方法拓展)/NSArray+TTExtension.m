//
//  NSArray+TTExtension.m
//  RiverBank
//
//  Created by Ryzen on 2021/1/5.
//

#import "NSArray+TTExtension.h"

@implementation NSArray (TTExtension)
/** 过滤 */
-(NSArray *)filter:(BOOL (^)(id _Nullable evaluatedObject, NSDictionary<NSString *, id> * _Nullable bindings))block{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:block]];
}
@end
