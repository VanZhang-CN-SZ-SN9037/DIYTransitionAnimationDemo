//
//  HPBaseTransitionAnimator+MiddlePageFlipAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import "HPBaseTransitionAnimator+PageFlipWithMiddleLineAnimation.h"

@interface UIView (Snapshot)
@property (nonatomic, readonly) UIImage *snapshotImage;
@property (nonatomic, strong) UIImage *contentImage;
@end

@implementation UIView (Snapshot)
- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}
- (UIImage *)contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.layer.contents];
}
- (void)setContentImage:(UIImage *)contentImage{
    self.layer.contents = (__bridge id)contentImage.CGImage;;
}
@end

@implementation HPBaseTransitionAnimator (PageFlipWithMiddleLineAnimation)

- (void)pageFlipWithMiddleLineAnimationWithTransitionState:(HPPageTransitionState)state{
    [self pageFlipWithMiddleLineAnimationWithTransitionState:state toPosition:HP_Animation_To_Position_Right];
}
- (void)pageFlipWithMiddleLineAnimationWithTransitionState:(HPPageTransitionState)state toPosition:(HP_Animation_To_Position)direction{
  
    __weak typeof(self)  weakSelf = self;
    void (^CallOpenPageHandler)(void) = ^(void){
        UIViewController *fromVC = [weakSelf.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = weakSelf.toViewController;
        UIView *toView = toVC.view;
        UIView *fromView = fromVC.view;
        UIView *containerView = weakSelf.containerView;
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.002;
        [containerView.layer setSublayerTransform:transform];
        BOOL animation = direction == HP_Animation_To_Position_Left || direction == HP_Animation_To_Position_Right;
        NSArray* toViewSnapshots = [self _xw_animationSnapFlipView:toView withDirection:direction update:YES];
        UIView* animationToView = toViewSnapshots[animation ? 1 : 0];
        NSArray* fromViewSnapshots = [self _xw_animationSnapFlipView:fromView withDirection:direction update:NO];
        UIView* animationFromView = fromViewSnapshots[animation ? 0 : 1];
        [self _xw_addShadowWithDirection:direction fromView:animationFromView toView:animationToView];
        [self _xw_setAnchorPointWithDirection:direction fromView:animationFromView toView:animationToView];
        BOOL rationAngle = direction == HP_Animation_To_Position_Left || direction == HP_Animation_To_Position_Bottom;
        BOOL flipDirection = direction == HP_Animation_To_Position_Left || direction == HP_Animation_To_Position_Right;
        animationToView.layer.transform = CATransform3DMakeRotation(rationAngle ? -M_PI_2 : M_PI_2, flipDirection ? 0.0 : 1.0, !flipDirection ? 0.0 : 1.0, 0.0);
        [UIView animateKeyframesWithDuration:weakSelf.duration
                                       delay:0.0
                                     options:0
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0.0
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        animationFromView.layer.transform = CATransform3DMakeRotation(rationAngle ? M_PI_2 : -M_PI_2, flipDirection ? 0.0 : 1.0, !flipDirection ? 0.0 : 1.0, 0.0);
                                                                        UIView *shadowView = animationFromView.subviews.lastObject;
                                                                        shadowView.alpha = 1.0f;
                                                                    }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0.5
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        animationToView.hidden = NO;
                                                                        animationToView.layer.transform = CATransform3DMakeRotation(rationAngle ? -0.001 : 0.001, flipDirection ? 0.0 : 1.0, !flipDirection ? 0.0 : 1.0, 0.0);
                                                                        UIView *shadowView = animationToView.subviews.lastObject;
                                                                        shadowView.alpha = 0.0f;
                                                                    }];
                                  } completion:^(BOOL finished) {
                                      [toViewSnapshots makeObjectsPerformSelector:@selector(removeFromSuperview)];
                                      [fromViewSnapshots makeObjectsPerformSelector:@selector(removeFromSuperview)];
                                      [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
                                  }];
    };
    
    void (^CallClosePageHandler)(void) = [CallOpenPageHandler copy];
    
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

- (void)_xw_setAnchorPointWithDirection:(HP_Animation_To_Position)direction fromView:(UIView *)fromView toView:(UIView *)toView{
    switch (direction) {
        case HP_Animation_To_Position_Left: {
            [self _xw_setAnchorPointTo:CGPointMake(1, 0.5) forView:fromView];
            [self _xw_setAnchorPointTo:CGPointMake(0, 0.5) forView:toView];
            break;
        }
        case HP_Animation_To_Position_Right: {
            [self _xw_setAnchorPointTo:CGPointMake(0, 0.5) forView:fromView];
            [self _xw_setAnchorPointTo:CGPointMake(1, 0.5) forView:toView];
            break;
        }
        case HP_Animation_To_Position_Top: {
            [self _xw_setAnchorPointTo:CGPointMake(0.5, 1) forView:fromView];
            [self _xw_setAnchorPointTo:CGPointMake(0.5, 0) forView:toView];
            break;
        }
        case HP_Animation_To_Position_Bottom: {
            [self _xw_setAnchorPointTo:CGPointMake(0.5, 0) forView:fromView];
            [self _xw_setAnchorPointTo:CGPointMake(0.5, 1) forView:toView];
            break;
        }
    }
}

- (void)_xw_setAnchorPointTo:(CGPoint)point forView:(UIView *)view{
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
}
- (NSArray<UIView *> *)_xw_animationSnapFlipView:(UIView *)view withDirection:(HP_Animation_To_Position)direction update:(BOOL)update{
    UIView *containerView = view.superview;
    CGSize size = view.bounds.size;
    CGRect rectOne = CGRectZero;
    CGRect rectTwo = CGRectZero;
    switch (direction) {
        case HP_Animation_To_Position_Left:
        case HP_Animation_To_Position_Right:{
            rectOne = CGRectMake(0, 0, view.frame.size.width / 2.0f, view.frame.size.height);
            rectTwo = CGRectMake(view.frame.size.width / 2.0f, 0, view.frame.size.width / 2.0f, view.frame.size.height);
            break;
        }
        case HP_Animation_To_Position_Top:
        case HP_Animation_To_Position_Bottom:{
            rectOne = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height / 2.0f);
            rectTwo = CGRectMake(0, view.frame.size.height / 2.0f, view.frame.size.width, view.frame.size.height / 2.0f);
            break;
        }
    }
    UIView *viewOne = [[UIView alloc]init];
    viewOne.contentImage = view.snapshotImage;
    UIView *viewTwo = [[UIView alloc]init];
    viewTwo.contentImage = viewOne.contentImage;
    viewOne.frame = rectOne;
    viewTwo.frame = rectTwo;
    viewOne.layer.contentsRect = CGRectMake(rectOne.origin.x / size.width, rectOne.origin.y / size.height, rectOne.size.width / size.width, rectOne.size.height / size.height);
    viewTwo.layer.contentsRect = CGRectMake(rectTwo.origin.x / size.width, rectTwo.origin.y / size.height, rectTwo.size.width / size.width, rectTwo.size.height / size.height);
    [containerView addSubview:viewOne];
    [containerView addSubview:viewTwo];
    return @[viewOne, viewTwo];
}

- (void)_xw_addShadowWithDirection:(HP_Animation_To_Position)direction fromView:(UIView *)fromView toView:(UIView *)toView{
    CGPoint fstartP = CGPointZero;
    CGPoint fendP = CGPointZero;
    CGPoint tstartP = CGPointZero;
    CGPoint tendP = CGPointZero;
    switch (direction) {
        case HP_Animation_To_Position_Left: {
            fstartP = CGPointMake(0.0, 0.0);
            fendP = CGPointMake(1.0, 0.0);
            tstartP = CGPointMake(1.0, 0.0);
            tendP = CGPointMake(0.0, 0.0);
            break;
        }case HP_Animation_To_Position_Right: {
            fstartP = CGPointMake(1.0, 0.0);
            fendP = CGPointMake(0.0, 0.0);
            tstartP = CGPointMake(0.0, 0.0);
            tendP = CGPointMake(1.0, 0.0);
            break;
        }case HP_Animation_To_Position_Top: {
            fstartP = CGPointMake(0.0, 0.0);
            fendP = CGPointMake(0.0, 1.0);
            tstartP = CGPointMake(0.0, 1.0);
            tendP = CGPointMake(0.0, 0.0);
            break;
        }case HP_Animation_To_Position_Bottom: {
            fstartP = CGPointMake(0.0, 1.0);
            fendP = CGPointMake(0.0, 0.0);
            tstartP = CGPointMake(0.0, 0.0);
            tendP = CGPointMake(0.0, 1.0);
            break;
        }
    }
    [self _xw_addGrandientLayerWithStartPoint:fstartP endPoint:fendP forView:fromView].alpha = 0.0f;
    [self _xw_addGrandientLayerWithStartPoint:tstartP endPoint:tendP forView:toView].alpha = 1.0f;
}

- (UIView *)_xw_addGrandientLayerWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint forView:(UIView *)view{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor];
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    UIView* shadowView = [[UIView alloc] initWithFrame:view.bounds];
    [shadowView.layer insertSublayer:gradient atIndex:0];
    [view addSubview:shadowView];
    return shadowView;
}

@end
