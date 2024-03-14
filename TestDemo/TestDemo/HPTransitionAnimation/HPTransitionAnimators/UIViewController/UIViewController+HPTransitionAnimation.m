//
//  UIViewController+HPTransitionAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/23.
//

#import "UIViewController+HPTransitionAnimation.h"
#import "HPTransitionAnimation+ViewControllerTransitioningDelegate.h"
#import <objc/runtime.h>


@interface UIViewController()
@property (strong, nonatomic) HPModalTransitionAnimator *presentAnimator;
@property (strong, nonatomic) HPModalTransitionAnimator *dissmissAnimator;
//Desc:
@property (weak, nonatomic) id tempDelegate;
@property (strong, nonatomic) HPPercentDrivenInteractiveTransition *tempInteractiveTransition;
@end
@implementation UIViewController (HPTransitionAnimation)
- (void)setTempInteractiveTransition:(HPPercentDrivenInteractiveTransition *)tempInteractiveTransition{
    objc_setAssociatedObject(self, @selector(tempInteractiveTransition), tempInteractiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(id)tempInteractiveTransition{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setTempDelegate:(id)tempDelegate{
    objc_setAssociatedObject(self, @selector(tempDelegate), tempDelegate, OBJC_ASSOCIATION_RETAIN);
}
-(id)tempDelegate{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setPresentAnimator:(HPModalTransitionAnimator *)presentAnimator{
    objc_setAssociatedObject(self, @selector(presentAnimator), presentAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(HPModalTransitionAnimator *)presentAnimator{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setDissmissAnimator:(HPModalTransitionAnimator *)dissmissAnimator{
    objc_setAssociatedObject(self, @selector(dissmissAnimator), dissmissAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(HPModalTransitionAnimator *)dissmissAnimator{
    return objc_getAssociatedObject(self, _cmd);
} 
- (void)presentViewController:(UIViewController*)presentedViewController animationOption:(HPPageTransitionAnimationOptions)options params:(HPBaseTransitionAnimatorParams*)params completion:(HPTransitionAnimationComplection)completion{
    presentedViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    __weak typeof(self)  weakSelf = self;
    [self setAnimatorForViewController:presentedViewController withTransitionState:HPPageTransitionState_ModalTransition_Present options:options params:params];
   
//    presentedViewController.tempInteractiveTransition = [HPPercentDrivenInteractiveTransition interactiveTransitionWithTransitionState:HPDrivenInteractiveTransition_State_Dismiss gestureDirection:HPDrivenInteractiveTransition_Gesture_Direction_Down];
//    __weak typeof(presentedViewController)  weakPresentedViewController = presentedViewController;
//    presentedViewController.tempInteractiveTransition.modalHandlerBlock = ^(CGFloat percentage, BOOL shouldComplete) {
//        [weakPresentedViewController dismissViewControllerAnimationOptions:options params:params completion:NULL];
////        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
//
//    };
//    [presentedViewController.tempInteractiveTransition wireToViewController:presentedViewController];
    
    
    
    [self resetTransitioningDelegateForViewController:presentedViewController withExcuteHandler:^{
        [weakSelf presentViewController:presentedViewController animated:YES completion:completion];
    }];
}
- (void)dismissViewControllerAnimationOptions:(HPPageTransitionAnimationOptions)options params:(HPBaseTransitionAnimatorParams*)params completion:(HPTransitionAnimationComplection)completion{
    
    [self setAnimatorForViewController:self withTransitionState:HPPageTransitionState_ModalTransition_Dissmiss options:options params:params];
    if (self.tempInteractiveTransition) {
        self.dissmissAnimator.interactiveTransition = self.tempInteractiveTransition;
    }
    __weak typeof(self)  weakSelf = self;
    [self resetTransitioningDelegateForViewController:self withExcuteHandler:^{
        [weakSelf dismissViewControllerAnimated:YES completion:completion];
        weakSelf.tempInteractiveTransition = nil;
    }];
}
- (void)setAnimatorForViewController:(UIViewController*)viewController withTransitionState:(HPPageTransitionState)state options:(HPPageTransitionAnimationOptions)options params:(HPBaseTransitionAnimatorParams*)params{
    HPModalTransitionAnimator *animator = [HPModalTransitionAnimator animatorWithTransitionState:state animationOptions:options];
 
    switch (state) {
        case HPPageTransitionState_ModalTransition_Present:{
            animator.params = params;
            if (params) {
                [HPTransitionAnimation shareInstance].tempPresentAnimatorParams = params;
            }
            viewController.presentAnimator = animator;
        }break;
        case HPPageTransitionState_ModalTransition_Dissmiss:{
            if (!params) {
                 params =  [HPTransitionAnimation shareInstance].tempPresentAnimatorParams;
            }
            animator.params = params;
            viewController.dissmissAnimator = animator;
            
        }break;
        default:break;
    }
}
- (void)resetTransitioningDelegateForViewController:(UIViewController*)viewController withExcuteHandler:(HPTransitionAnimationHandler)handlerBlock{
    if (viewController.transitioningDelegate&&(viewController.transitioningDelegate!=[HPTransitionAnimation shareInstance])) {
        viewController.tempDelegate = viewController.transitioningDelegate;
    }
    viewController.transitioningDelegate = [HPTransitionAnimation shareInstance];
    [HPTransitionAnimation shareInstance].viewController = viewController;
    !handlerBlock?:handlerBlock();
    if (viewController.tempDelegate&&(viewController.tempDelegate!=viewController.transitioningDelegate)) {
        viewController.transitioningDelegate = viewController.tempDelegate;
        viewController.tempDelegate = nil;
    }
}
 
@end

@implementation UIViewController (CATransition)

- (void)presentViewController:(UIViewController *)viewControllerToPresent animation:(HP_CATransition_Animation_Options)option completion:(HPTransitionAnimationComplection)completion{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewControllerToPresent animation:option flipPosition:HP_CATransition_Animation_FlipPosition_Top completion:completion];
}
- (void)dismissViewControllerAnimation:(HP_CATransition_Animation_Options)option completion:(HPTransitionAnimationComplection)completion{
    [self dismissViewControllerAnimation:option flipPosition:HP_CATransition_Animation_FlipPosition_Bottom completion:completion];
}


- (void)presentViewController:(UIViewController *)viewControllerToPresent animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position completion:(HPTransitionAnimationComplection)completion{
    CATransition *animator = [HPTransitionAnimation createAnimation:option  withFlipPosition:position];
    [self.view.window.layer addAnimation:animator forKey:@"kTransitionAnimation"];
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewControllerToPresent animated:NO completion:completion];
    
}
- (void)dismissViewControllerAnimation:(HP_CATransition_Animation_Options)option  flipPosition:(HP_CATransition_Animation_FlipPosition)position completion:(HPTransitionAnimationComplection)completion{
    CATransition *animator = [HPTransitionAnimation createAnimation:option  withFlipPosition:position];
    [self.view.window.layer addAnimation:animator forKey:@"kTransitionAnimation"];
    [self dismissViewControllerAnimated:NO completion:completion];
}
@end
