//
//  UINavigationController+HPNavigationTransition.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/23.
//

#import "UINavigationController+HPTransitionAnimation.h" 
#import "HPTransitionAnimation+NavigationControllerDelegate.h"
#import <objc/runtime.h>

@interface UIViewController (TempDelegate)
@property (nonatomic, weak ,readonly) id tempNavDelegate;
@property (assign, nonatomic) HPPageTransitionAnimationOptions last_Navigation_Option;
@property (strong, nonatomic) HPPercentDrivenInteractiveTransition *tempInteractiveTransition;
@end
@implementation UIViewController (TempDelegate)
- (void)setTempInteractiveTransition:(HPPercentDrivenInteractiveTransition *)tempInteractiveTransition{
    objc_setAssociatedObject(self, @selector(tempInteractiveTransition), tempInteractiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(id)tempInteractiveTransition{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTempNavDelegate:(id)tempNavDelegate{
    objc_setAssociatedObject(self, @selector(tempNavDelegate), tempNavDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)tempNavDelegate{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setLast_Navigation_Option:(HPPageTransitionAnimationOptions)last_Navigation_Option{
    objc_setAssociatedObject(self, @selector(last_Navigation_Option), @(last_Navigation_Option), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(HPPageTransitionAnimationOptions)last_Navigation_Option{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end

@interface UINavigationController () 
//Desc:
@property (strong, nonatomic) HPNavigationTransitionAnimator*pushAnimator;
@property (strong, nonatomic) HPNavigationTransitionAnimator*popAnimator;

//Desc:

@end
@implementation UINavigationController (HPTransitionAnimation)
- (void)setPushAnimator:(HPNavigationTransitionAnimator *)pushAnimator{
    objc_setAssociatedObject(self, @selector(pushAnimator), pushAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HPNavigationTransitionAnimator *)pushAnimator{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setPopAnimator:(HPNavigationTransitionAnimator *)popAnimator{
    objc_setAssociatedObject(self, @selector(popAnimator), popAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HPNavigationTransitionAnimator *)popAnimator{
    return objc_getAssociatedObject(self, _cmd);
}
 
- (void)pushViewController:(UIViewController *)viewController animationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params{
    if (!params) {
        params  = [[HPBaseTransitionAnimatorParams alloc]init];
    }
    HPNavigationTransitionAnimator *animator = [HPNavigationTransitionAnimator animatorWithTransitionState:HPPageTransitionState_NavigationTransition_Push animationOptions:option];
    self.pushAnimator = animator;
    animator.params  = params;
    viewController.last_Navigation_Option = option;
    
    
    [HPTransitionAnimation shareInstance].tempPushAnimatorParams = params;
    [HPTransitionAnimation shareInstance].navigationController = self; 
    
//    __weak typeof(self)  weakSelf = self;
//
//    __weak typeof(viewController)  weakViewController = viewController;
 
   
    
    if (self.delegate) {
         viewController.tempNavDelegate = self.delegate;
    }
    self.delegate = [HPTransitionAnimation shareInstance];
    
    [self pushViewController:viewController animated:YES];
    
//    self.tempInteractiveTransition = [HPPercentDrivenInteractiveTransition interactiveTransitionWithTransitionState:HPDrivenInteractiveTransition_State_Push gestureDirection:HPDrivenInteractiveTransition_Gesture_Direction_Right];
//    [self.tempInteractiveTransition wireToViewController:viewController];
//    self.tempInteractiveTransition.navigationHandlerBlock = ^(CGFloat percentage, BOOL shouldComplete) {
//        weakSelf.pushAnimator.params.animationPercentage = percentage;
//        weakSelf.pushAnimator.params.shouldComplecte = shouldComplete;
//        [weakViewController.navigationController popViewControllerAnimationOptions:option params:weakSelf.pushAnimator.params];
//    };
    self.delegate = nil;
    if (viewController.tempNavDelegate) {
        self.delegate = viewController.tempNavDelegate;
        viewController.tempNavDelegate = nil;
    }
}
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params{
    HPNavigationTransitionAnimator *animator = [HPNavigationTransitionAnimator animatorWithTransitionState:HPPageTransitionState_NavigationTransition_Push animationOptions:option];
    self.pushAnimator = animator;
    animator.params  = params;
    [HPTransitionAnimation shareInstance].tempPushAnimatorParams = params;
    [self setViewControllers:viewControllers animated:YES];
}
- (UIViewController *)popViewControllerAnimationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params{
    if (option == HPPageTransitionAnimationOption_Last_Option) {
        option = self.viewControllers.lastObject.last_Navigation_Option;
    }
    if (!params) {
         params =  [HPTransitionAnimation shareInstance].tempPushAnimatorParams;
    }
  
    HPNavigationTransitionAnimator *animator = [HPNavigationTransitionAnimator animatorWithTransitionState:HPPageTransitionState_NavigationTransition_Pop animationOptions:option];
    self.popAnimator = animator;
    animator.params  = params;
    [HPTransitionAnimation shareInstance].navigationController = self;
    
    
    if (self.tempInteractiveTransition) {
        self.popAnimator.interactiveTransition = self.tempInteractiveTransition;
    }
    
    
    if (self.delegate) {
        self.viewControllers.lastObject.tempNavDelegate = self.delegate;
    }
    self.delegate = [HPTransitionAnimation shareInstance];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.357 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.viewControllers.lastObject.tempNavDelegate) {
            self.delegate = self.viewControllers.lastObject.tempNavDelegate;
            self.viewControllers.lastObject.tempNavDelegate = nil;
        }
    });
 
    return [self popViewControllerAnimated:YES];
    
  
}
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params{
    if (!params) {
         params =  [HPTransitionAnimation shareInstance].tempPushAnimatorParams;
    }
    HPNavigationTransitionAnimator *animator = [HPNavigationTransitionAnimator animatorWithTransitionState:HPPageTransitionState_NavigationTransition_Pop animationOptions:option];
    self.popAnimator = animator;
    
    animator.params  = params;
    if (self.viewControllers.lastObject.tempNavDelegate) {
        self.delegate = self.viewControllers.lastObject.tempNavDelegate;
        self.tempNavDelegate = nil;
    }
    return [self popToViewController:viewController animated:YES];
}
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params{
    if (!params) {
         params =  [HPTransitionAnimation shareInstance].tempPushAnimatorParams;
    }
    HPNavigationTransitionAnimator *animator = [HPNavigationTransitionAnimator animatorWithTransitionState:HPPageTransitionState_NavigationTransition_Pop animationOptions:option];
    self.popAnimator = animator;
    animator.params  = params;
    if (self.viewControllers.lastObject.tempNavDelegate) {
        self.delegate = self.viewControllers.lastObject.tempNavDelegate;
        self.tempNavDelegate = nil;
    }
    return [self popToRootViewControllerAnimated:YES];
}
 





@end

@implementation UINavigationController (CATransition)
- (void)pushViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option{
    [self pushViewController:viewController animation:option flipPosition:HP_CATransition_Animation_FlipPosition_Right];
}
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animation:(HP_CATransition_Animation_Options)option{
    [self setViewControllers:viewControllers animation:option flipPosition:HP_CATransition_Animation_FlipPosition_Right];
}
- (UIViewController *)popViewControllerAnimation:(HP_CATransition_Animation_Options)option{
    return [self popViewControllerAnimation:option flipPosition:HP_CATransition_Animation_FlipPosition_Left];
}
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option{
    return [self popToViewController:viewController animation:option flipPosition:HP_CATransition_Animation_FlipPosition_Left];
}
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimation:(HP_CATransition_Animation_Options)option{
    return [self popToRootViewControllerAnimation:option flipPosition:HP_CATransition_Animation_FlipPosition_Left];
}
- (void)pushViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position{
    CATransition *animator = [HPTransitionAnimation createAnimation:option withFlipPosition:position];
    // 在当前view上执行CATransition动画
    // [self.view.layer addAnimation:animation forKey:@"animation"];
    // 在window上执行CATransition, 即可在ViewController转场时执行动画。
    [self.view.window.layer addAnimation:animator forKey:@"kTransitionAnimation"];
    [self pushViewController:viewController animated:NO];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position{
    CATransition *animator = [HPTransitionAnimation createAnimation:option withFlipPosition:position];
    // 在当前view上执行CATransition动画
    // [self.view.layer addAnimation:animation forKey:@"animation"];
    // 在window上执行CATransition, 即可在ViewController转场时执行动画。
    [self.view.window.layer addAnimation:animator forKey:@"kTransitionAnimation"];
    [self setViewControllers:viewControllers animated:NO];
}
- (UIViewController *)popViewControllerAnimation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position{
    CATransition *animator = [HPTransitionAnimation createAnimation:option withFlipPosition:position];
    // 在当前view上执行CATransition动画
    // [self.view.layer addAnimation:animation forKey:@"animation"];
    // 在window上执行CATransition, 即可在ViewController转场时执行动画。
    [self.view.window.layer addAnimation:animator forKey:@"kTransitionAnimation"];
    return  [self popViewControllerAnimated:NO];
}
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position{
    CATransition *animator = [HPTransitionAnimation createAnimation:option withFlipPosition:position];
    // 在当前view上执行CATransition动画
    // [self.view.layer addAnimation:animation forKey:@"animation"];
    // 在window上执行CATransition, 即可在ViewController转场时执行动画。
    [self.view.window.layer addAnimation:animator forKey:@"kTransitionAnimation"];
    return  [self popToViewController:viewController animated:NO];
}
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position{
    CATransition *animator = [HPTransitionAnimation createAnimation:option withFlipPosition:position];
    // 在当前view上执行CATransition动画
    // [self.view.layer addAnimation:animation forKey:@"animation"];
    // 在window上执行CATransition, 即可在ViewController转场时执行动画。
    [self.view.window.layer addAnimation:animator forKey:@"kTransitionAnimation"];
    return  [self popToRootViewControllerAnimated:NO];
}

@end
