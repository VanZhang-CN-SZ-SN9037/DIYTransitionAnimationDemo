//
//  HPNavigationTransitionAnimator+InsideThenPushAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator+InsideThenPushAnimation.h"

@implementation HPBaseTransitionAnimator (InsideThenPushAnimation)
 

- (void)insideThenPushAnimationWithTransitionState:(HPPageTransitionState)state{
    
        
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
    
    
    void (^CallOpenPageHandler)(void) = ^(void){
        UIViewController *fromVC = self.fromViewController;
        UIViewController *toVC = self.toViewController;
        UIView *containView = self.containerView;
        id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
        
        UIView *fromView = fromVC.view;
        UIView *toView = toVC.view;
        [containView addSubview:fromView];
        [containView addSubview:toView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        
        toView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
        [UIView animateWithDuration:self.duration animations:^{
            
            fromView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
            toView.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished){
            
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
                fromView.layer.transform = CATransform3DIdentity;
                
            }else{
                [transitionContext completeTransition:YES];
                fromView.layer.transform = CATransform3DIdentity;
            }
        }];
    };

    
    
    void (^CallClosePageHandler)(void) = ^(void){
            UIView *tempToView = [toVC.view snapshotViewAfterScreenUpdates:YES];
            UIView *tempFromView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
            
            UIView *fromView = fromVC.view;
            UIView *toView = toVC.view;
            
            [containView addSubview:toView];
            [containView addSubview:fromView];
            
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            toView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
            fromView.layer.transform = CATransform3DIdentity;
            [UIView animateWithDuration:self.duration animations:^{
                toView.layer.transform = CATransform3DIdentity;
                fromView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
                
            } completion:^(BOOL finished){
                
                [tempToView removeFromSuperview];
                toView.hidden = NO;
                [tempFromView removeFromSuperview];
                toView.layer.transform = CATransform3DIdentity;
                if ([transitionContext transitionWasCancelled]) {
                    [transitionContext completeTransition:NO];
                }else{
                    [transitionContext completeTransition:YES];
                }
            }];
            
    //            self.willEndInteractiveBlock = ^(BOOL success) {
    //
    //                if (success) {
    //                    toView.layer.transform = CATransform3DIdentity;
    //                    fromView.hidden = YES;
    //                    [containerView addSubview:tempToView];
    //                }else {
    //                    fromView.hidden = NO;
    //                    toView.layer.transform = CATransform3DIdentity;
    //
    //                    [tempToView removeFromSuperview];
    //                    [containerView addSubview:tempFromView];
    //
    //
    //                }
    //
    //            };
    };
    
    switch (state) {
        
        case HPPageTransitionState_NavigationTransition_Push:
        case HPPageTransitionState_ModalTransition_Present:
            CallOpenPageHandler();
            break;
        case HPPageTransitionState_NavigationTransition_Pop:
        case HPPageTransitionState_ModalTransition_Dissmiss:
            CallClosePageHandler();
            break;
        case HPPageTransitionState_NavigationTransition_None:break;
    }
}


@end
