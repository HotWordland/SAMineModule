//
//  NSLayoutConstraint+Multiplier.m
//  CloudCulturalTourism
//
//  Created by Ryzen on 2020/10/22.
//  Copyright © 2020 cqlyy. All rights reserved.
//

#import "NSLayoutConstraint+Multiplier.h"

@implementation NSLayoutConstraint (Multiplier)

-(instancetype)updateMultiplier:(CGFloat)multiplier {

    [NSLayoutConstraint deactivateConstraints:[NSArray arrayWithObjects:self, nil]];

   NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:self.firstItem attribute:self.firstAttribute relatedBy:self.relation toItem:self.secondItem attribute:self.secondAttribute multiplier:multiplier constant:self.constant];
    [newConstraint setPriority:self.priority];
    newConstraint.shouldBeArchived = self.shouldBeArchived;
    newConstraint.identifier = self.identifier;
    newConstraint.active = true;

    [NSLayoutConstraint activateConstraints:[NSArray arrayWithObjects:newConstraint, nil]];
    //NSLayoutConstraint.activateConstraints([newConstraint])
    return newConstraint;
}

@end
