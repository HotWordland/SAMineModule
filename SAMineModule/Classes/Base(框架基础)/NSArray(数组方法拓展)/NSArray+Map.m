//
//  NSArray+Map.m
//  Travel-Tp
//
//  Created by Curse Tom on 2020/2/14.
//  Copyright © 2020 Ryzen. All rights reserved.
//

#import "NSArray+Map.h"


@implementation NSArray (Map)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj, idx)];
    }];
    return result;
}


@end
