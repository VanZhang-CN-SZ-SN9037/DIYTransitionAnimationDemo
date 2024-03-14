//
//  HPTransitionAnimation+ViewControllerTransitioningDelegate.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/24.
//

#import "HPTransitionAnimation+ViewControllerTransitioningDelegate.h"
#import "UIViewController+HPTransitionAnimation.h"
#import <objc/runtime.h>
@implementation HPTransitionAnimation (ViewControllerTransitioningDelegate)
-(void)setViewController:(UIViewController *)viewController{
    objc_setAssociatedObject(self, @selector(viewController), viewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIViewController *)viewController{
    return objc_getAssociatedObject(self, _cmd);
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{ 
    return self.viewController.presentAnimator;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.viewController.dissmissAnimator;
}


- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.viewController.presentAnimator.interactiveTransition.interacting?self.viewController.presentAnimator.interactiveTransition:nil;
}
//
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.viewController.dissmissAnimator.interactiveTransition.interacting?self.viewController.dissmissAnimator.interactiveTransition:nil;
}
@end
