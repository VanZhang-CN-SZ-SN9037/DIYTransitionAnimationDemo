//
//  UITabBarController+HPTransitionAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import "UITabBarController+HPTransitionAnimation.h"
#import "HPTransitionAnimation+TabbarControllerDelegate.h"
#import <objc/runtime.h>

@interface UITabBarController ()
@property (weak, nonatomic) id tempDelegate;
@end
@implementation UITabBarController (HPTransitionAnimation)
- (void)setTempDelegate:(id)tempDelegate{
    objc_setAssociatedObject(self, @selector(tempDelegate), tempDelegate, OBJC_ASSOCIATION_RETAIN);
}
-(id)tempDelegate{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelectItemAnimator:(HPTabBarCtrlTransitionAnimator *)selectItemAnimator{
    objc_setAssociatedObject(self, @selector(selectItemAnimator), selectItemAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HPTabBarCtrlTransitionAnimator *)selectItemAnimator{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setDidSelectItem:(NSUInteger)itemIndex animationOptions:(HPTabBarSelectItemTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params{
    if ((self.viewControllers.count-1)<=itemIndex) {
        UIViewController *animationItemVc = self.viewControllers[itemIndex];
        [self setDidSelectViewController:animationItemVc animationOptions:option params:params];
    }
}

 
- (void)setDidSelectViewController:(UIViewController *)viewController animationOptions:(HPTabBarSelectItemTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params{
    [self setAnimatorWithOptions:option params:params];
    [self resetTabBarCtrlDelegateWithExcuteHandler:NULL];
}

- (void)setAnimatorWithOptions:(HPTabBarSelectItemTransitionAnimationOptions)options params:(HPBaseTransitionAnimatorParams*)params{
    HPTabBarCtrlTransitionAnimator *animator = [HPTabBarCtrlTransitionAnimator animatorWithTransitionAnimationOptions:options];
    animator.params = params;
    if (params) {
        [HPTransitionAnimation shareInstance].tempSelectTabItemAnimatorParams = params;
    }
    self.selectItemAnimator = animator;
}
- (void)resetTabBarCtrlDelegateWithExcuteHandler:(HPTransitionAnimationHandler)handlerBlock{
    if (self.delegate&&(self.delegate!=[HPTransitionAnimation shareInstance])) {
        self.tempDelegate = self.delegate;
    }
    self.delegate = [HPTransitionAnimation shareInstance];
    [HPTransitionAnimation shareInstance].tabBarController = self;
    !handlerBlock?:handlerBlock();
}
- (void)resetTabBarCtrlDelegate{ 
    if (self.tempDelegate&&(self.tempDelegate!=self.delegate)) {
        self.delegate = self.tempDelegate;
        self.tempDelegate = nil;
    }
}
  


@end
