//
//  HPNavigationTransitionAnimator+PageFlipAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator+PageFlipAnimation.h"

@implementation HPBaseTransitionAnimator (PageFlipAnimation)
  
- (void)horizontalFlipAnimationWithTransitionState:(HPPageTransitionState)state{
 
     
    __weak typeof(self)  weakSelf = self;
    
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
     
  
    void (^CallOpenPageHandler)(void) = ^(void){
        
       //对tempView做动画，避免bug;
       UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
       tempView.frame = fromVC.view.frame;
       UIView *containerView = weakSelf.containerView;
       [containerView addSubview:toVC.view];
       [containerView addSubview:tempView];
       fromVC.view.hidden = YES;
       [containerView insertSubview:toVC.view atIndex:0];
       [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
       CATransform3D transfrom3d = CATransform3DIdentity;
       transfrom3d.m34 = -0.002;
       containerView.layer.sublayerTransform = transfrom3d;
       //增加阴影
       CAGradientLayer *fromGradient = [CAGradientLayer layer];
       fromGradient.frame = fromVC.view.bounds;
       fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
                           (id)[UIColor blackColor].CGColor];
       fromGradient.startPoint = CGPointMake(0.0, 0.5);
       fromGradient.endPoint = CGPointMake(0.8, 0.5);
       UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
       fromShadow.backgroundColor = [UIColor clearColor];
       [fromShadow.layer insertSublayer:fromGradient atIndex:1];
       fromShadow.alpha = 0.0;
       [tempView addSubview:fromShadow];
       CAGradientLayer *toGradient = [CAGradientLayer layer];
       toGradient.frame = fromVC.view.bounds;
       toGradient.colors = @[(id)[UIColor blackColor].CGColor,
                               (id)[UIColor blackColor].CGColor];
       toGradient.startPoint = CGPointMake(0.0, 0.5);
       toGradient.endPoint = CGPointMake(0.8, 0.5);
       UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
       toShadow.backgroundColor = [UIColor clearColor];
       [toShadow.layer insertSublayer:toGradient atIndex:1];
       toShadow.alpha = 1.0;
       [toVC.view addSubview:toShadow];
       [UIView animateWithDuration:weakSelf.duration animations:^{
           tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
           fromShadow.alpha = 1.0;
           toShadow.alpha = 0.0;
       } completion:^(BOOL finished) {
           [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
           if ([weakSelf.transitionContext transitionWasCancelled]) {
               [tempView removeFromSuperview];
               fromVC.view.hidden = NO;
           }
       }];
    };
    
    
  void (^CallClosePageHandler)(void) = ^(void){
   
      //拿到push时候的
      UIView *tempView = containView.subviews.lastObject;
      [containView addSubview:toVC.view];
      [UIView animateWithDuration:weakSelf.duration animations:^{
          tempView.layer.transform = CATransform3DIdentity;
          fromVC.view.subviews.lastObject.alpha = 1.0;
          tempView.subviews.lastObject.alpha = 0.0;
      } completion:^(BOOL finished) {
          if ([weakSelf.transitionContext transitionWasCancelled]) {
              [weakSelf.transitionContext completeTransition:NO];
          }else{
              [weakSelf.transitionContext completeTransition:YES];
              [tempView removeFromSuperview];
              toVC.view.hidden = NO;
          }
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
- (void)verticalFlipAnimationWithTransitionState:(HPPageTransitionState)state{
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
     
    
    
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
     
    
    
    UIImage *topImg = [self imageFromView:toView atFrame:CGRectMake(0, 0, screenWidth, screenHeight/2)];
    UIImageView *topView = [[UIImageView alloc] initWithImage:topImg];
    [topView setContentMode:UIViewContentModeScaleAspectFill];
    topView.layer.transform = CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0);
    topView.layer.doubleSided = NO;
    
    UIImage *fromImgTop = [self imageFromView:fromView atFrame:CGRectMake(0, 0, screenWidth, screenHeight/2)];
    UIImageView *fromTopView = [[UIImageView alloc] initWithImage:fromImgTop];
    fromTopView.backgroundColor = [UIColor clearColor];
    fromTopView.layer.doubleSided = NO;
    
    UIImage *fromImgBottom = [self imageFromView:fromView atFrame:CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2)];
    UIImageView *fromBottomView = [[UIImageView alloc] initWithImage:fromImgBottom];
    fromBottomView.layer.doubleSided = NO;
    
    UIView *flipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    flipView.backgroundColor = [UIColor clearColor];
    [flipView.layer addSublayer:topView.layer];
    [flipView.layer addSublayer:fromBottomView.layer];
    
    //addsubView
    
    [containView addSubview:toView];
    [containView addSubview:fromTopView];
    [containView addSubview:flipView];
    
    
    [UIView animateWithDuration:self.duration animations:^{
        fromBottomView.layer.transform = CATransform3DMakeRotation(- M_PI, 1.0, 0.0, 0.0);
        topView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [fromTopView removeFromSuperview];
        [fromBottomView removeFromSuperview];
        [topView removeFromSuperview];
        [flipView removeFromSuperview];
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else {
            [containView bringSubviewToFront:toView];
            [transitionContext completeTransition:YES];
        }
        
    }];
    
    switch (state) {
        
        case HPPageTransitionState_NavigationTransition_Push:
        case HPPageTransitionState_ModalTransition_Present:
            //            self.willEndInteractiveBlock = nil;
            break;
        case HPPageTransitionState_NavigationTransition_Pop:
        case HPPageTransitionState_ModalTransition_Dissmiss:
    //            self.willEndInteractiveBlock = ^(BOOL success) {
    //                if (success) {
    //                    [fromTopView removeFromSuperview];
    //                    [fromBottomView removeFromSuperview];
    //                    [topView removeFromSuperview];
    //                    [flipView removeFromSuperview];
    //                }
    //            };
            break;
        case HPPageTransitionState_NavigationTransition_None:break;
    }
}





- (void)pageFlipAnimationWithTransitionState:(HPPageTransitionState)state option:(HP_PageFlipAnimation_Options)option{
    switch (option) {
        case HP_PageFlipAnimation_Option_HorizontalFlip:{
            [self horizontalFlipAnimationWithTransitionState:state];
        }break;
        case HP_PageFlipAnimation_Option_VerticalFlip:{
            [self verticalFlipAnimationWithTransitionState:state];
        }break;
    }
}
 




- (UIImage *)imageFromView: (UIView *)view atFrame:(CGRect)rect{
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;
    
}
@end
