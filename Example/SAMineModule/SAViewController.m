//
//  SAViewController.m
//  SAMineModule
//
//  Created by WonderLand on 06/12/2021.
//  Copyright (c) 2021 WonderLand. All rights reserved.
//

#import "SAViewController.h"
@import SAMineModule;

@interface SAViewController ()

@end

@implementation SAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SAMineController *mvc = [[SAMineController alloc] init];
        [self presentViewController:mvc animated:true completion:^{
            
        }];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
