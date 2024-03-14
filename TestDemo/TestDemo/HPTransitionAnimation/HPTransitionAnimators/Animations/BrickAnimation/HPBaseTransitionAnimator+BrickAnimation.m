//
//  HPNavigationTransitionAnimator+BrickAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator+BrickAnimation.h"

@implementation HPBaseTransitionAnimator (BrickAnimation)
- (void)presentWithBrickAnimationWithTransitionState:(HPPageTransitionState)state option:(HP_BrickAnimation_Options)option{
    switch (option) {
        case HP_BrickAnimation_Option_CloseVertical:
        case HP_BrickAnimation_Option_CloseHorizontal:
            [self presentWithBrickCloseAnimationWithAnimationOption:option];
            break;
        case HP_BrickAnimation_Option_OpenVertical:
        case HP_BrickAnimation_Option_OpenHorizontal:
            [self presentWithBrickOpenAnimationWithAnimationOption:option];
            break;
        default:
            break;
    }
}

- (void)presentWithBrickOpenAnimationWithAnimationOption:(HP_BrickAnimation_Options)option{
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    __block CGRect rect0 = CGRectZero;
    __block CGRect rect1 = CGRectZero;
    
    void (^CallCommonOpenPageHandler)(void) = ^(void){
        switch (option) {
            case HP_BrickAnimation_Option_OpenVertical:{
                rect0 = CGRectMake(0 , 0 , screenWidth, screenHeight/2);
                rect1 = CGRectMake(0 , screenHeight/2 , screenWidth, screenHeight/2);
            }break;
            case HP_BrickAnimation_Option_OpenHorizontal:{
                rect0 = CGRectMake(0 , 0 , screenWidth/2, screenHeight);
                rect1 = CGRectMake(screenWidth/2 , 0 , screenWidth/2, screenHeight);
            }break;
                
            default:
                break;
        }
        
        UIImage *image0 = [self imageFromView:fromVC.view atFrame:rect0];
        UIImage *image1 = [self imageFromView:fromVC.view atFrame:rect1];
        
        UIImageView *imgView0 = [[UIImageView alloc] initWithImage:image0];
        UIImageView *imgView1 = [[UIImageView alloc] initWithImage:image1];
        
        [containView addSubview:fromVC.view];
        [containView addSubview:toVC.view];
        [containView addSubview:imgView0];
        [containView addSubview:imgView1];
        
        
        [UIView animateWithDuration:self.duration animations:^{
            if (option==HP_BrickAnimation_Option_OpenVertical) {
                imgView0.layer.transform = CATransform3DMakeTranslation(0, -screenHeight/2, 0);
                imgView1.layer.transform = CATransform3DMakeTranslation(0, screenHeight/2, 0);
    
            }else if (option==HP_BrickAnimation_Option_OpenHorizontal) {
                imgView0.layer.transform = CATransform3DMakeTranslation(-screenWidth/2, 0, 0);
                imgView1.layer.transform = CATransform3DMakeTranslation(screenWidth/2, 0, 0);
            }
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                
                [transitionContext completeTransition:NO];
                [imgView0 removeFromSuperview];
                [imgView1 removeFromSuperview];
                
            }else{
                [transitionContext completeTransition:YES];
                [imgView0 removeFromSuperview];
                [imgView1 removeFromSuperview];
            }
        }];
        
    };
    
    
    void (^CallCommonClosePageHandler)(void) = ^(void){
        switch (option) {
            case HP_BrickAnimation_Option_OpenVertical:{
                rect0 = CGRectMake(0 , 0 , screenWidth, screenHeight/2);
                rect1 = CGRectMake(0 , screenHeight/2 , screenWidth, screenHeight/2);
            }break;
            case HP_BrickAnimation_Option_OpenHorizontal:{
                rect0 = CGRectMake(0 , 0 , screenWidth/2, screenHeight);
                rect1 = CGRectMake(screenWidth/2 , 0 , screenWidth/2, screenHeight);
            }break;
            default:
                break;
        }
        
        
        UIImage *image0 = [self imageFromView:toVC.view atFrame:rect0];
        UIImage *image1 = [self imageFromView:toVC.view atFrame:rect1];
        
        UIImageView *imgView0 = [[UIImageView alloc] initWithImage:image0];
        UIImageView *imgView1 = [[UIImageView alloc] initWithImage:image1];
        
        [containView addSubview:fromVC.view];
        [containView addSubview:toVC.view];
        [containView addSubview:imgView0];
        [containView addSubview:imgView1];
        
        toVC.view.hidden = YES;
        
        
        switch (option) {
            case HP_BrickAnimation_Option_OpenVertical:{
                imgView0.layer.transform = CATransform3DMakeTranslation(0, -screenHeight/2, 0);
                imgView1.layer.transform = CATransform3DMakeTranslation(0, screenHeight/2, 0);
            }break;
            case HP_BrickAnimation_Option_OpenHorizontal:{
                imgView0.layer.transform = CATransform3DMakeTranslation(-screenWidth/2, 0, 0);
                imgView1.layer.transform = CATransform3DMakeTranslation(screenWidth/2, 0, 0);
            }break;
            default:
                break;
        }
        [UIView animateWithDuration:self.duration animations:^{
            imgView0.layer.transform = CATransform3DIdentity;
            imgView1.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
            }
            toVC.view.hidden = NO;
            [imgView0 removeFromSuperview];
            [imgView1 removeFromSuperview];
        }];
        
        
//            __weak UIViewController *weakToVC = toVC;
//
//            self.willEndInteractiveBlock = ^(BOOL sucess) {
//                if (sucess) {
//                    weakToVC.view.hidden = NO;
//
//                }else{
//                    weakToVC.view.hidden = YES;
//                }
//                [imgView0 removeFromSuperview];
//                [imgView1 removeFromSuperview];
//            };
        
    };
    
    switch (self.pageState) {
        
        case HPPageTransitionState_ModalTransition_Present:
        case HPPageTransitionState_NavigationTransition_Push:
            CallCommonOpenPageHandler();
        break;
        case HPPageTransitionState_ModalTransition_Dissmiss:
        case HPPageTransitionState_NavigationTransition_Pop:
            CallCommonClosePageHandler();
            break;
        case HPPageTransitionState_NavigationTransition_None:
            NSLog(@"HPNavigationTransitionState_None");
            break;
            
    }
    
    
    
    
     
    
    
  
    
    
    
    
    
    
    
    
}
- (void)presentWithBrickCloseAnimationWithAnimationOption:(HP_BrickAnimation_Options)option{
    UIViewController *fromVC = self.fromViewController;
    UIViewController *toVC = self.toViewController;
    UIView *containView = self.containerView;
    id <UIViewControllerContextTransitioning>transitionContext = self.transitionContext;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    __block CGRect rect0 = CGRectZero;
    __block CGRect rect1 = CGRectZero;
    
    void (^CallCommonOpenPageHandler)(void) = ^(void){
        switch (option) {
            case HP_BrickAnimation_Option_CloseHorizontal:{
                rect0 = CGRectMake(0, 0 , screenWidth/2, screenHeight);
                rect1 = CGRectMake(screenWidth/2 , 0 , screenWidth/2, screenHeight);
            }break;
            case HP_BrickAnimation_Option_CloseVertical:{
                rect0 = CGRectMake(0, 0 , screenWidth, screenHeight/2);
                rect1 = CGRectMake(0 , screenHeight/2 , screenWidth, screenHeight/2);
            }break;
                
            default:
                break;
        }
        UIImage *image0 = [self imageFromView:toVC.view atFrame:rect0];
        UIImage *image1 = [self imageFromView:toVC.view atFrame:rect1];
        
        UIImageView *imgView0 = [[UIImageView alloc] initWithImage:image0];
        UIImageView *imgView1 = [[UIImageView alloc] initWithImage:image1];
        
        [containView addSubview:fromVC.view];
        [containView addSubview:toVC.view];
        [containView addSubview:imgView0];
        [containView addSubview:imgView1];
        
        toVC.view.hidden = YES;
        
        switch (option) {
            case HP_BrickAnimation_Option_CloseHorizontal:{
                imgView0.layer.transform = CATransform3DMakeTranslation(-screenWidth/2, 0, 0);
                imgView1.layer.transform = CATransform3DMakeTranslation(screenWidth/2, 0, 0);
            }break;
            case HP_BrickAnimation_Option_CloseVertical:{
                imgView0.layer.transform = CATransform3DMakeTranslation(0, -screenHeight/2, 0);
                imgView1.layer.transform = CATransform3DMakeTranslation(0, screenHeight/2, 0);
            }break;
            default:
                break;
        }
        [UIView animateWithDuration:self.duration animations:^{
            imgView0.layer.transform = CATransform3DIdentity;
            imgView1.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
            }
            [imgView0 removeFromSuperview];
            [imgView1 removeFromSuperview];
        }];
    };
    
    
    void (^CallCommonClosePageHandler)(void) = ^(void){
        switch (option) {
            case HP_BrickAnimation_Option_CloseHorizontal:{
                rect0 = CGRectMake(0, 0 , screenWidth/2, screenHeight);
                rect1 = CGRectMake(screenWidth/2 , 0 , screenWidth/2, screenHeight);
            }break;
            case HP_BrickAnimation_Option_CloseVertical:{
                rect0 = CGRectMake(0, 0 , screenWidth, screenHeight/2);
                rect1 = CGRectMake(0 , screenHeight/2 , screenWidth, screenHeight/2);
            }break;
                
            default:
                break;
        }
        
        
        UIImage *image0 = [self imageFromView:fromVC.view atFrame:rect0];
        UIImage *image1 = [self imageFromView:fromVC.view atFrame:rect1];
        
        UIImageView *imgView0 = [[UIImageView alloc] initWithImage:image0];
        UIImageView *imgView1 = [[UIImageView alloc] initWithImage:image1];
        
        [containView addSubview:fromVC.view];
        [containView addSubview:toVC.view];
        [containView addSubview:imgView0];
        [containView addSubview:imgView1];
        
        
        [UIView animateWithDuration:self.duration animations:^{
            switch (option) {
                case HP_BrickAnimation_Option_CloseHorizontal:{
                    imgView0.layer.transform = CATransform3DMakeTranslation(-screenWidth/2, 0, 0);
                    imgView1.layer.transform = CATransform3DMakeTranslation(screenWidth/2, 0, 0);
                }break;
                    
                case HP_BrickAnimation_Option_CloseVertical:{
                    imgView0.layer.transform = CATransform3DMakeTranslation(0, -screenHeight/2, 0);
                    imgView1.layer.transform = CATransform3DMakeTranslation(0, screenHeight/2, 0);
                }break;
                default:
                    break;
            }
            
            
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
                
            }
            toVC.view.hidden = NO;
            [imgView0 removeFromSuperview];
            [imgView1 removeFromSuperview];
        }];
        
        
//            __weak UIViewController *weakToVC = toVC;
//
//            self.willEndInteractiveBlock = ^(BOOL sucess) {
//                if (sucess) {
//                    [imgView0 removeFromSuperview];
//                    [imgView1 removeFromSuperview];
//
//                }else{
//                    weakToVC.view.hidden = YES;
//                }
//                [imgView0 removeFromSuperview];
//                [imgView1 removeFromSuperview];
//
//            };
        
    };
    
    switch (self.pageState) {
        
        case HPPageTransitionState_ModalTransition_Present:
        case HPPageTransitionState_NavigationTransition_Push:
            CallCommonOpenPageHandler();
        break;
        case HPPageTransitionState_ModalTransition_Dissmiss:
        case HPPageTransitionState_NavigationTransition_Pop:
            CallCommonClosePageHandler();
        break;
        case HPPageTransitionState_NavigationTransition_None:{
            NSLog(@"HPNavigationTransitionState_None");
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
