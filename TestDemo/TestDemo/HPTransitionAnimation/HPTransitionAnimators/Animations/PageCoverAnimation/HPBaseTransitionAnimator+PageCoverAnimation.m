//
//  HPNavigationTransitionAnimator+PageCoverAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator+PageCoverAnimation.h"

@implementation HPBaseTransitionAnimator (PageCoverAnimation)
- (void)pageCoverAnimationWithTransitionState:(HPPageTransitionState)state{
    
    __weak typeof(self)  weakSelf = self;
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containView = self.containerView;
    void (^CallOpenPageHandler)(void) = ^(void){
        [containView addSubview:toVC.view];
        [containView addSubview:fromVC.view];
        [containView addSubview:tempView];
        
        tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
        tempView.alpha = 0.1;
        tempView.hidden = NO;
        
        [UIView animateWithDuration:weakSelf.duration animations:^{
            
            tempView.layer.transform = CATransform3DIdentity;
            tempView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            if ([weakSelf.transitionContext transitionWasCancelled]) {
                toVC.view.hidden = YES;
                [weakSelf.transitionContext completeTransition:NO];
            }else{
                toVC.view.hidden = NO;
                [weakSelf.transitionContext completeTransition:YES];
            }
            [tempView removeFromSuperview];
            
        }];
        
    };
    void (^CallClosePageHandler)(void) = ^(void){
        
        
        [containView addSubview:fromVC.view];
        [containView addSubview:toVC.view];
        [containView addSubview:tempView];
        
        fromVC.view.hidden = YES;
        toVC.view.hidden = NO;
        toVC.view.alpha = 1;
        tempView.hidden = NO;
        tempView.alpha = 1;
        
        [UIView animateWithDuration:weakSelf.duration animations:^{
            tempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
            tempView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            if ([weakSelf.transitionContext transitionWasCancelled]) {
                
                fromVC.view.hidden = NO;
                [weakSelf.transitionContext completeTransition:NO];
                tempView.alpha = 1;
                
            }else{
                [weakSelf.transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
                
            }
            [tempView removeFromSuperview];
        }];

    //            //小心循环引用
    //            __weak UIViewController * weakToVC = toVC;
    //            __weak UIViewController * weakFromVC = fromVC;
    //
    //            self.willEndInteractiveBlock = ^(BOOL success){
    //
    //                if (success) {
    //                    weakToVC.view.hidden = NO;
    //                    [tempView removeFromSuperview];
    //
    //                }else{
    //                    weakFromVC.view.hidden = NO;
    //                    tempView.alpha = 1;
    //                }
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
