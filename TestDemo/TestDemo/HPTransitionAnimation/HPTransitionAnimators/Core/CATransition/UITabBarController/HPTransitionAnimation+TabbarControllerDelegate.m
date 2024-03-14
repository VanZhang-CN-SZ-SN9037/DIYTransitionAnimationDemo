//
//  HPTransitionAnimation+TabbarControllerDelegate.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import "HPTransitionAnimation+TabbarControllerDelegate.h"
#import "UIViewController+HPTransitionAnimation.h"
#import "UITabBarController+HPTransitionAnimation.h"
#import <objc/runtime.h>

@implementation HPTransitionAnimation (TabbarControllerDelegate)
-(void)setTabBarController:(UITabBarController *)tabBarController{
    objc_setAssociatedObject(self, @selector(tabBarController), tabBarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UITabBarController *)tabBarController{
    return objc_getAssociatedObject(self, _cmd);
}

//- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                      interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController{
//    return nil;
//}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    [self.tabBarController resetTabBarCtrlDelegate];
}
- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC{
    return self.tabBarController.selectItemAnimator;
}
@end
