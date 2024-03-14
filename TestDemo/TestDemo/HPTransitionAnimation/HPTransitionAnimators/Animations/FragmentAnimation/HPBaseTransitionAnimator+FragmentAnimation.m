//
//  HPNavigationTransitionAnimator+FragmentAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator+FragmentAnimation.h"

@implementation HPBaseTransitionAnimator (FragmentAnimation)
- (void)presentWithFragmentAnimationWithTransitionState:(HPPageTransitionState)state option:(HP_FragmentAnimation_Options)option startPosition:(HP_Animation_StartPosition)position{
    switch (option) {
        case HP_FragmentAnimation_Option_Show:{
            [self showFragmentAnimationWithTransitionState:state startPosition:position];
        }break;
        case HP_FragmentAnimation_Option_Hide:{
            [self hideFragmentAnimationWithTransitionState:state startPosition:position];
        }break;
    }
}

- (void)showFragmentAnimationWithTransitionState:(HPPageTransitionState)state startPosition:(HP_Animation_StartPosition)position{
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
    
    void (^CallOpenPageHandler)(void) = ^(void){
        UIView *toVCTempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
        
        [containView addSubview:toVC.view];
        [containView addSubview:fromVC.view];
        
        NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
        
        CGSize size = fromVC.view.frame.size;
        CGFloat fragmentWidth = 20.0f;
        
        NSInteger rowNum = size.width/fragmentWidth + 1;
        for (int i = 0; i < rowNum ; i++) {
            
            for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
                CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
                UIView *fragmentView = [toVCTempView resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
                [containView addSubview:fragmentView];
                [fragmentViews addObject:fragmentView];
                fragmentView.frame = rect;
                switch (position) {
                    case HP_Animation_StartPosition_Right:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation(random()%50 *50, 0, 0);
                    }break;
                    case HP_Animation_StartPosition_Left:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation( - random()%50 *50, 0 , 0);
                    }break;
                    case HP_Animation_StartPosition_Top:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation(0, - random()%50 *50, 0);
                    }break;
                    case HP_Animation_StartPosition_Bottom:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation(0, random()%50 *50, 0);
                    }break;
                }
                fragmentView.alpha = 0;
            }
            
        }
        
        [UIView animateWithDuration:self.duration animations:^{
            for (UIView *fragmentView in fragmentViews) {
                fragmentView.layer.transform = CATransform3DIdentity;
                fragmentView.alpha = 1;
                
            }
        } completion:^(BOOL finished) {
            for (UIView *fragmentView in fragmentViews) {
                [fragmentView removeFromSuperview];
            }
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
                fromVC.view.hidden = NO;
            }else{
                [transitionContext completeTransition:YES];
                fromVC.view.hidden = NO;
            }
            
        }];
    };
    
    void (^CallClosePageHandler)(void) = ^(void){
        
        UIView *fromTempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        
        [containView addSubview:toVC.view];
        
        NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
        
        CGSize size = fromVC.view.frame.size;
        CGFloat fragmentWidth = 20.0f;
        
        NSInteger rowNum = size.width/fragmentWidth + 1;
        for (int i = 0; i < rowNum ; i++) {
            
            for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
                
                CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
                UIView *fragmentView = [fromTempView resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
                [containView addSubview:fragmentView];
                [fragmentViews addObject:fragmentView];
                fragmentView.frame = rect;
            }
            
        }
        
        toVC.view.hidden = NO;
        fromVC.view.hidden = YES;
        
        [UIView animateWithDuration:self.duration animations:^{
            for (UIView *fragmentView in fragmentViews) {
                
                CGRect rect = fragmentView.frame;
                
                switch (position) {
                    case HP_Animation_StartPosition_Right:{
                        rect.origin.x = rect.origin.x + random()%50 *50;
                    }break;
                    case HP_Animation_StartPosition_Left:{
                        rect.origin.x = rect.origin.x - random()%50 *50;
                    } break;
                    case HP_Animation_StartPosition_Top:{
                        rect.origin.y = rect.origin.y - random()%50 *50;
                    }break;
                    case HP_Animation_StartPosition_Bottom:{
                        rect.origin.y = rect.origin.y + random()%50 *50;
                    }break;
                         
                }
                
                fragmentView.frame = rect;
                fragmentView.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            for (UIView *fragmentView in fragmentViews) {
                [fragmentView removeFromSuperview];
            }
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
                fromVC.view.hidden = NO;
            }else{
                [transitionContext completeTransition:YES];
                fromVC.view.hidden = NO;
            }
            
        }];
        
//            self.willEndInteractiveBlock = ^(BOOL sucess) {
//                if (sucess) {
//                    for (UIView *fragmentView in fragmentViews) {
//                        [fragmentView removeFromSuperview];
//                    }
//                }else{
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


- (void)hideFragmentAnimationWithTransitionState:(HPPageTransitionState)state  startPosition:(HP_Animation_StartPosition)position{
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
  
    
    
    
    
    void (^CallOpenPageHandler)(void) = ^(void){
        UIView *fromTempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        [containView addSubview:toVC.view];
        
        NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
        
        CGSize size = fromVC.view.frame.size;
        CGFloat fragmentWidth = 20.0f;
        
        NSInteger rowNum = size.width/fragmentWidth + 1;
        for (int i = 0; i < rowNum ; i++) {
            for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
                CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
                UIView *fragmentView = [fromTempView resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
                [containView addSubview:fragmentView];
                [fragmentViews addObject:fragmentView];
                fragmentView.frame = rect;
            }
            
        }
        
        toVC.view.hidden = NO;
        fromVC.view.hidden = YES;
        
        [UIView animateWithDuration:self.duration animations:^{
            for (UIView *fragmentView in fragmentViews) {
                CGRect rect = fragmentView.frame;
                switch (position) {
                    case HP_Animation_StartPosition_Right:{
                        rect.origin.x = rect.origin.x - random()%50 *50;
                    }break;
                    case HP_Animation_StartPosition_Left:{
                        rect.origin.x = rect.origin.x + random()%50 *50;
                    }break;
                    case HP_Animation_StartPosition_Top:{
                        rect.origin.y = rect.origin.y + random()%50 *50;
                    }break;
                    case HP_Animation_StartPosition_Bottom:{
                        rect.origin.y = rect.origin.y - random()%50 *50;
                    }break;
                }
                fragmentView.frame = rect;
                fragmentView.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            
            for (UIView *fragmentView in fragmentViews) {
                [fragmentView removeFromSuperview];
            }
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
                fromVC.view.hidden = NO;
            }else{
                [transitionContext completeTransition:YES];
                fromVC.view.hidden = NO;
            }
            
        }];
        
    };
    
    void (^CallClosePageHandler)(void) = ^(void){
        [containView addSubview:toVC.view];
        NSMutableArray *fragmentViews = [[NSMutableArray alloc] init];
        CGSize size = fromVC.view.frame.size;
        CGFloat fragmentWidth = 20.0f;
        
        NSInteger rowNum = size.width/fragmentWidth + 1;
        for (int i = 0; i < rowNum ; i++) {
            
            for (int j = 0; j < size.height/fragmentWidth + 1; j++) {
                
                CGRect rect = CGRectMake(i*fragmentWidth, j*fragmentWidth, fragmentWidth, fragmentWidth);
                UIView *fragmentView = [toVC.view resizableSnapshotViewFromRect:rect  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
                [containView addSubview:fragmentView];
                [fragmentViews addObject:fragmentView];
                fragmentView.frame = rect;
                switch (position) {
                    case HP_Animation_StartPosition_Right:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation(-random()%50 *50, 0, 0);
                    }break;
                    case HP_Animation_StartPosition_Left:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation(random()%50 *50, 0, 0);
                    }break;
                    case HP_Animation_StartPosition_Top:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation(0, random()%50 *50, 0);
                    }break;
                    case HP_Animation_StartPosition_Bottom:{
                        fragmentView.layer.transform = CATransform3DMakeTranslation(0, -random()%50 *50, 0);
                    }break;
                }
                fragmentView.alpha = 0;
            }
            
        }
        
        toVC.view.hidden = YES;
        fromVC.view.hidden = NO;
        
        [UIView animateWithDuration:self.duration animations:^{
            
            for (UIView *fragmentView in fragmentViews) {
                fragmentView.alpha = 1;
                fragmentView.layer.transform = CATransform3DIdentity;
            }
        } completion:^(BOOL finished) {
            for (UIView *fragmentView in fragmentViews) {
                [fragmentView removeFromSuperview];
            }
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
            }
            toVC.view.hidden = NO;
            
        }];
        
//            __weak UIViewController * weakToVC = toVC;
//            self.willEndInteractiveBlock = ^(BOOL sucess) {
//                if (sucess) {
//                    for (UIView *fragmentView in fragmentViews) {
//                        [fragmentView removeFromSuperview];
//                    }
//                    weakToVC.view.hidden = NO;
//                }else{
//
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
