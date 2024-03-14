//
//  HPNavigationTransitionAnimator+BoomAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator+BoomAnimation.h"

@implementation HPBaseTransitionAnimator (BoomAnimation)
- (void)presentWithBoomAnimationWithTransitionState:(HPPageTransitionState)state{
    
    __weak typeof(self)  weakSelf = self;
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
    
    void (^CallOpenPageHandler)(void) = ^(void){
         
        
        UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
        
        [containView addSubview:toVC.view];
        [containView addSubview:fromVC.view];
        [containView addSubview:tempView];
        
        tempView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        
        [UIView animateWithDuration:weakSelf.duration delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            tempView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
            }
            [tempView removeFromSuperview];
        }];
    };
    
    
    void (^CallClosePageHandler)(void) = ^(void){
            UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
            [containView addSubview:toVC.view];
            [containView addSubview:tempView];
            
            tempView.layer.transform = CATransform3DIdentity;
            
            
            
            
            
            [UIView animateWithDuration:self.duration animations:^{
                tempView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
            } completion:^(BOOL finished) {
                if ([transitionContext transitionWasCancelled]) {

                    [transitionContext completeTransition:NO];
                    fromVC.view.hidden = NO;
                    [tempView removeFromSuperview];

                }else{
                    [transitionContext completeTransition:YES];
                    toVC.view.hidden = NO;
                    fromVC.view.hidden = YES;
                    [tempView removeFromSuperview];
                }

            }];
            
        //    self.willEndInteractiveBlock = ^(BOOL sucess) {
        //        if (sucess) {
        //            [tempView removeFromSuperview];
        //        }else{
        //        }
        //    };
            
        
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
