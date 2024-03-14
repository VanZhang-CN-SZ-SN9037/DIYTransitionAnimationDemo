//
//  HPNavigationTransitionAnimator+PushFromItemAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/24.
//

#import "HPBaseTransitionAnimator+PushFromItemAnimation.h"

@implementation HPBaseTransitionAnimator (PushFromItemAnimation)
- (void)pushFromItemWithTransitionState:(HPPageTransitionState)state{
    
    typeof (self) __weak weakSelf = self;
    
    CGPoint itemCenter  = self.params.itemCenter;
    CGSize itemSize = self.params.itemSize;
    UIImage *itemImg = [UIImage imageNamed:weakSelf.params.itemImageName];
    if (CGSizeEqualToSize(itemSize, CGSizeZero)) {
        itemSize = CGSizeMake(20, 20);
    }
    if (CGPointEqualToPoint(itemCenter, CGPointZero)) {
        itemCenter = self.fromView.center;
    }
//    if (!itemImg) {
//        itemImg = [self.fromView snapshotViewAfterScreenUpdates:NO];
//    }
    
    void (^CallOpenPageHandler)(void) = ^(void){
        
         
        weakSelf.containerView.backgroundColor = weakSelf.toView.backgroundColor;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
        imageView.image = itemImg;
        [weakSelf.containerView addSubview:imageView];
        imageView.center = itemCenter;
        
        CGFloat initialScale = itemSize.width / CGRectGetWidth(imageView.frame);
        imageView.transform = CGAffineTransformMakeScale(initialScale, initialScale);
        
        NSLog(@"y : %f", imageView.center.y);
        
        // toView在UIImageView到达最终位置，动画完成之后再显示出来
        weakSelf.toView.frame = [weakSelf.transitionContext finalFrameForViewController:weakSelf.toViewController];
        [weakSelf.containerView addSubview:weakSelf.toView];
        CGPoint toViewFinalCenter = weakSelf.toView.center;
        weakSelf.toView.center = toViewFinalCenter;
        weakSelf.toView.alpha = 0.0f;
        
        
        NSTimeInterval duration = weakSelf.duration;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 / 0.55 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            imageView.transform = CGAffineTransformIdentity;
            imageView.center = toViewFinalCenter;
            
            weakSelf.fromView.alpha = 0.0f; // fromView 渐隐
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            
            weakSelf.toView.alpha = 1.0f;
            weakSelf.fromView.alpha = 1.0f;
            
            [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
        }];
    };
    
    void (^CallClosePageHandler)(void) = ^(void){
//        NSLog(@"animationPercentage:%.2f",weakSelf.params.animationPercentage);
//        NSLog(@"shouldComplete:%d",weakSelf.params.shouldComplecte);
        weakSelf.toView.frame = [weakSelf.transitionContext finalFrameForViewController:weakSelf.toViewController];
        [weakSelf.containerView insertSubview:weakSelf.toView belowSubview:weakSelf.fromView];

        weakSelf.toView.alpha = 0.0f;

        weakSelf.fromView.backgroundColor = [UIColor clearColor];

        NSTimeInterval duration = [weakSelf transitionDuration:weakSelf.transitionContext];

        [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGFloat initialScale = itemSize.width / 200;
            weakSelf.fromView.transform = CGAffineTransformMakeScale(initialScale, initialScale);
            weakSelf.fromView.center = itemCenter;

            weakSelf.toView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            //由于加入了手势必须判断

            weakSelf.fromView.alpha = 0.0f;
            [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
        }];
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
