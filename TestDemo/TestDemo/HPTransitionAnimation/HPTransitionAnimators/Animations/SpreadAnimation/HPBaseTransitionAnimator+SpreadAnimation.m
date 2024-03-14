//
//  HPNavigationTransitionAnimator+SpreadAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator+SpreadAnimation.h"
#import <objc/runtime.h>

@implementation HPBaseTransitionAnimator (SpreadAnimation)

- (void)presentWithPointSpreadAnimationWithTransitionState:(HPPageTransitionState)state{
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
    __weak typeof(self)  weakSelf = self;
    void (^CallOpenPageHandler)(void) = ^(void){
        
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
        
        [containView addSubview:toVC.view];
        [containView addSubview:fromVC.view];
        [containView addSubview:tempView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
         
        
        CGRect rect = CGRectMake(containView.center.x - 1, containView.center.y - 1, 2, 2);
        if (weakSelf.fromView) {
            CGPoint tempCenter = [weakSelf.fromView convertPoint:weakSelf.fromView.center toView:containView];
            rect = CGRectMake(tempCenter.x - 1, tempCenter.y - 1, 2, 2);
        }
        
        if (!CGPointEqualToPoint(weakSelf.params.point,CGPointZero)) {
            CGPoint tempCenter = [weakSelf.fromView convertPoint:weakSelf.params.point toView:containView];
            rect = CGRectMake(tempCenter.x - 1, tempCenter.y - 1, 2, 2);
        }
        
        UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];
        UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = endPath.CGPath;
        tempView.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.delegate = weakSelf;
        
        animation.fromValue = (__bridge id)(startPath.CGPath);
        animation.toValue = (__bridge id)((endPath.CGPath));
        animation.duration = weakSelf.duration;
        animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayer addAnimation:animation forKey:@"PointNextPath"];
         
        weakSelf.completionBlock = ^(){
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{

                [transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
            }
            [tempView removeFromSuperview];

        };
             
  
        
    };
    
    
    void (^CallClosePageHandler)(void) = ^(void){
        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO]; //YES会导致闪一下
        [containView addSubview:toVC.view];
        [containView addSubview:tempView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        CGRect rect = CGRectMake(containView.center.x-1, containView.center.y-1, 2, 2);
        if (self.fromView) {
            CGPoint tempCenter = [self.fromView convertPoint:self.fromView.center toView:containView];
            rect = CGRectMake(tempCenter.x - 1, tempCenter.y - 1, 2, 2);
        }
        
        UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = endPath.CGPath;
        tempView.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.delegate = weakSelf;
        animation.fromValue = (__bridge id)(startPath.CGPath);
        animation.toValue = (__bridge id)((endPath.CGPath));
        animation.duration = weakSelf.duration;
        animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayer addAnimation:animation forKey:@"PointBackPath"];
        
//            self.willEndInteractiveBlock = ^(BOOL sucess) {
//                if (sucess) {
//                    maskLayer.path = endPath.CGPath;
//                }else{
//                    maskLayer.path = startPath.CGPath;
//                }
//            };
        
 
            weakSelf.completionBlock = ^(){

                if ([transitionContext transitionWasCancelled]) {
                    [transitionContext completeTransition:NO];
                }else{

                    [transitionContext completeTransition:YES];
                    toVC.view.hidden = NO;
                }
                [tempView removeFromSuperview];

            };
        
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
- (void)presentWithSideSpreadAnimationWithTransitionState:(HPPageTransitionState)state startPosition:(HP_Animation_StartPosition)position{
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
  
    
    __weak typeof(self)  weakSelf = self;
    void (^CallOpenPageHandler)(void) = ^(void){
        UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
        
        [containView addSubview:toVC.view];
        [containView addSubview:fromVC.view];
        [containView addSubview:tempView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        CGRect rect0 ;
        CGRect rect1 = CGRectMake(0, 0, screenWidth, screenHeight);
        switch (position) {
            case HP_Animation_StartPosition_Left:{
                rect0 = CGRectMake(0, 0, 2, screenHeight);
            }break;
            case HP_Animation_StartPosition_Right:{
                rect0 = CGRectMake(screenWidth, 0, 2, screenHeight);
            }break;
            case HP_Animation_StartPosition_Top:{
                rect0 = CGRectMake(0, 0, screenWidth, 2);
            }break;
            case HP_Animation_StartPosition_Bottom:{
                rect0 = CGRectMake(0, screenHeight , screenWidth, 2);
            }break;
        }
        
        
        UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
        UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:rect1];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = endPath.CGPath; //动画结束后的值
        tempView.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id)(startPath.CGPath);
        animation.toValue = (__bridge id)((endPath.CGPath));
        animation.duration = weakSelf.duration;
        animation.delegate = weakSelf;
        [maskLayer addAnimation:animation forKey:@"NextPath"];
          
            weakSelf.completionBlock = ^(){
                if ([transitionContext transitionWasCancelled]) {
                    [transitionContext completeTransition:NO];
                }else{
                    [transitionContext completeTransition:YES];
                }
                [tempView removeFromSuperview];
            };
      
    };
    
    
    void (^CallClosePageHandler)(void) = ^(void){
        
        UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];
        [containerView addSubview:tempView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGRect rect0 ;
        CGRect rect1 = CGRectMake(0, 0, screenWidth, screenHeight);
        
        switch (position) {
            case HP_Animation_StartPosition_Left:{
                rect0 = CGRectMake(screenWidth-2, 0, 2, screenHeight);
            }break;
            case HP_Animation_StartPosition_Right:{
                rect0 = CGRectMake(0, 0, 2, screenHeight);
            }break;
            case HP_Animation_StartPosition_Top:{
                rect0 = CGRectMake(0, screenHeight - 2 , screenWidth, 2);
            }break;
            case HP_Animation_StartPosition_Bottom:{
                rect0 = CGRectMake(0, 0, screenWidth, 2);
            }break;
        }
        
        UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
        UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:rect1];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        tempView.layer.mask = maskLayer;
        maskLayer.path = endPath.CGPath;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.delegate = weakSelf;
        animation.fromValue = (__bridge id)(startPath.CGPath);
        animation.toValue = (__bridge id)((endPath.CGPath));
        animation.duration = self.duration;
        animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayer addAnimation:animation forKey:@"BackPath"];
        
        
        __weak UIViewController * weakToVC = toVC;
        
//            self.willEndInteractiveBlock = ^(BOOL success) {
//
//                if (success) {
//                    maskLayer.path = endPath.CGPath;
//
//                }else{
//                    maskLayer.path = startPath.CGPath;
//                }
//
//            };
//
        
         
            weakSelf.completionBlock = ^(){

                [tempView removeFromSuperview];

                if ([transitionContext transitionWasCancelled]) {
                    [transitionContext completeTransition:NO];

                }else{
                    [transitionContext completeTransition:YES];
                    weakToVC.view.hidden = NO;
                }
            };
      
            
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









- (void)setCompletionBlock:(HPTransitionAnimationHandler)completionBlock{
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (HPTransitionAnimationHandler)completionBlock{
    return objc_getAssociatedObject(self, _cmd);
}

@end
