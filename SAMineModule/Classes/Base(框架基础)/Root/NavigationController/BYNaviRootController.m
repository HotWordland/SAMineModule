//
//  BYNaviRootController.m
//  BYLottery
//
//  Created by 情热大陆 on 2017/5/10.
//  Copyright © 2017年 Lon. All rights reserved.
//

#import "BYNaviRootController.h"

@interface BYNaviRootController ()

@end

@implementation BYNaviRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBarTintColor:NAVIBARCOLOR];
    [self.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [self.navigationBar setBarStyle:UIBarStyleBlack];
}

/*
 
 其实苹果真的考虑的很周全，为我们创造了hidesBottomBarWhenPushed这个属性，为了解决这个问题。代码非常简单，一句或者两句话即可，这里得分几种Push的情况。
 
 Case1：xib加载或者Storyboard用identifier获取Controller
 
 UIViewController *v2 = [self.storyboard instantiateViewControllerWithIdentifier:@"v2"];
 v2.hidesBottomBarWhenPushed = YES;
 [self.navigationController pushViewController:v2 animated:YES];
 Case2：拉线，也就是Storyboard用performSegue
 
 self.hidesBottomBarWhenPushed = YES;
 [self performSegueWithIdentifier:@"tov2" sender:nil];
 self.hidesBottomBarWhenPushed = NO;
 Tip:经测试证明，此种方式只会对后面的一级生效，继续往后Push还会出现TabBar，要继续往后push也隐藏Tabbar还得使用Case3的方法，也建议如此！
 
 Case3：拉线，在prepareForSegue函数里
 
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
 }
 更方便的做法：如果你在用 Storyboard，可以在 ViewController 的设置面板中把 Hide Bottom Bar on Push 属性勾选上，效果和上文代码一样。
 
 暂时就用到这几点，我之前的做法，自己手动隐藏，拉伸view，显示不但麻烦，兼容性也不好，移到iOS7上问题多多，不过用这个属性可以非常方便的实现此需求，并且在iOS6上也完美兼容哦。
 
 注意：还有个问题，这个属性只支持非自定义的Tabbar，也就是只支持原生Tabbar，如果是自定义的Tabbar会产生你意想不到的效果，我之前就遇到过，因为使用hidesBottomBarWhenPushed后，系统内部会处理TabbarController上Tabbar这个View，我之前自定义的Tabbar做法是吧原生Tabbar这个View隐藏掉，然后添加到自己绘制的Tabbar
 View上去，缺点就是这样你的自定义的TabBarview接收不到系统应有的一些响应，于是我尝试着把自定义的TabBar
 View添加到原来的TabBar View上，也就是不隐藏原生的TabBar，而是覆盖在上面，看不出任何区别，效果也能达到上面图片的效果！
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.topViewController) {
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///让当前的状态栏风格取决于导航控制器的栈顶VC，这是viewController的preferredStatusBarStyle就可以起作用了
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
- (nullable UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
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
