//
//  SALoginController.m
//  SA
//
//  Created by Curse Tom on 2021/5/9.
//

#import "SALoginController.h"
#import "SAMineController.h"
@import WebKit;

@interface SALoginController ()
@property (strong, nonatomic) WKWebView* webView;

@end

@implementation SALoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clickLogin:(UIButton *)sender {
    SAMineController *vc = [[SAMineController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
