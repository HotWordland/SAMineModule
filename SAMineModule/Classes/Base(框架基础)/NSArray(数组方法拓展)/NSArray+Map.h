//
//  NSArray+Map.h
//  Travel-Tp
//
//  Created by Curse Tom on 2020/2/14.
//  Copyright © 2020 Ryzen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Map)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

@end

NS_ASSUME_NONNULL_END
