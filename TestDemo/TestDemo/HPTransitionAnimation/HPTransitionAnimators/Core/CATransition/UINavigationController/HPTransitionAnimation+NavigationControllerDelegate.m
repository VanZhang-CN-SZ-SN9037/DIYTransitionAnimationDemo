//
//  HPTransitionAnimation+NavigationControllerDelegate.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/24.
//

#import "HPTransitionAnimation+NavigationControllerDelegate.h"
#import "UINavigationController+HPTransitionAnimation.h"
#import <objc/runtime.h>
@implementation HPTransitionAnimation (NavigationControllerDelegate)
-(void)setNavigationController:(UINavigationController *)navigationController{
    objc_setAssociatedObject(self, @selector(navigationController), navigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UINavigationController *)navigationController{
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark - <UINavigationControllerDelegate>
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if (animationController==navigationController.pushAnimator) {
        return !navigationController.pushAnimator.interactiveTransition.interacting?nil:navigationController.pushAnimator.interactiveTransition;
    }else  if (animationController==navigationController.popAnimator) {
        return !navigationController.popAnimator.interactiveTransition.interacting?nil:navigationController.popAnimator.interactiveTransition;
    }else{
        return nil;
    }
}
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    id <UIViewControllerAnimatedTransitioning> anmation = nil;
    switch (operation) {
        case UINavigationControllerOperationNone:{
            anmation = nil;
        } break;
        case UINavigationControllerOperationPush:{
            anmation = self.navigationController.pushAnimator;
        } break;
        case UINavigationControllerOperationPop:{
            anmation = self.navigationController.popAnimator;;
        } break;
    }
    return anmation;
}

@end
