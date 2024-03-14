//
//  HPPercentDrivenInteractiveTransition.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import "HPPercentDrivenInteractiveTransition.h"
#import "UINavigationController+HPTransitionAnimation.h"
 

@interface HPPercentDrivenInteractiveTransition ()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, assign) CGFloat percentage;

@property (nonatomic, weak) UIViewController *topViewController;//presented or push
/**手势方向*/
@property (nonatomic, assign) HPDrivenInteractiveTransitionGestureDirection direction;
/**手势类型*/
@property (nonatomic, assign) HPDrivenInteractiveTransitionState state;

@end

@implementation HPPercentDrivenInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionState:(HPDrivenInteractiveTransitionState)state gestureDirection:(HPDrivenInteractiveTransitionGestureDirection)direction{
    return [[self alloc] initWithTransitionState:state gestureDirection:direction];
}

- (instancetype)initWithTransitionState:(HPDrivenInteractiveTransitionState)state gestureDirection:(HPDrivenInteractiveTransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _state = state;
    }
    return self;
}



- (void)wireToViewController:(UIViewController *)viewController{
    self.topViewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}
-(CGFloat)completionSpeed{
    CGFloat speed = 1 - self.percentComplete;
//    NSLog(@"speed:%.2f",speed);
    return speed;
}


//- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
//    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
//    switch (gestureRecognizer.state) {
//        case UIGestureRecognizerStateBegan:
//            // 1. Mark the interacting flag. Used when supplying it in delegate.
//            self.interacting = YES;
////            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
//            [self startGesture];
//            break;
//        case UIGestureRecognizerStateChanged: {
//            // 2. Calculate the percentage of guesture
//            CGFloat fraction = translation.y / 400.0;
//            //Limit it between 0 and 1
//            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
//            self.shouldComplete = (fraction > 0.5);
//
//            [self updateInteractiveTransition:fraction];
//            break;
//        }
//        case UIGestureRecognizerStateEnded:
//        case UIGestureRecognizerStateCancelled: {
//            // 3. Gesture over. Check if the transition should happen or not
//            self.interacting = NO;
//            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
//                [self cancelInteractiveTransition];
//            } else {
//                [self finishInteractiveTransition];
//            }
//            break;
//        }
//        default:
//            break;
//    }
//}
/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer{
//    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    //手势百分比
    CGFloat percentageFraction = 0;
    CGFloat compareWidth = [UIScreen mainScreen].bounds.size.width*2;
    CGFloat compareHeight = [UIScreen mainScreen].bounds.size.height*1.758;
    CGFloat transitionX = 0;
    CGFloat transitionY = 0;
    switch (self.direction) {
        case HPDrivenInteractiveTransition_Gesture_Direction_Left:{
//            compareWidth = 500;
            transitionX = -[gestureRecognizer translationInView:gestureRecognizer.view].x;
            transitionX*=1.0;
            percentageFraction = transitionX / compareWidth;
        }break;
        case HPDrivenInteractiveTransition_Gesture_Direction_Right:{
//            compareWidth = 500;
            transitionX = [gestureRecognizer translationInView:gestureRecognizer.view].x;
            transitionX*=1.0;
            percentageFraction = transitionX / compareWidth;
        }break;
        case HPDrivenInteractiveTransition_Gesture_Direction_Up:{
            transitionY = -[gestureRecognizer translationInView:gestureRecognizer.view].y;
            transitionY*=1.0;
            percentageFraction = transitionY / compareHeight;
        }break;
        case HPDrivenInteractiveTransition_Gesture_Direction_Down:{
            transitionY = [gestureRecognizer translationInView:gestureRecognizer.view].y;
            transitionY*=1.0;
            percentageFraction = transitionY / compareHeight;
        }break;
    }
    // 2. Calculate the percentage of guesture
    percentageFraction = fminf(fmaxf(percentageFraction, 0.0), 1.0);
    self.shouldComplete = (percentageFraction > 0.5);
    self.percentage = percentageFraction;
    NSLog(@"percentageFraction:%.2f,transitionX:%.2f",percentageFraction,transitionX);
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            //手势开始的时候标记手势状态，并开始相应的事件
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
//            // 2. Calculate the percentage of guesture
            //手势过程中，通过updateInteractiveTransition设置动画过程进行的百分比
            [self updateInteractiveTransition:percentageFraction];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (percentageFraction > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }break;
        default:
            break;
    }
}

- (void)startGesture{
    switch (self.state) {
        case HPDrivenInteractiveTransition_State_Present:
        case HPDrivenInteractiveTransition_State_Dismiss:
            !self.modalHandlerBlock?:self.modalHandlerBlock(self.percentage,self.shouldComplete);
            break;
        case HPDrivenInteractiveTransition_State_Push:
        case HPDrivenInteractiveTransition_State_Pop:
            !self.navigationHandlerBlock?:self.navigationHandlerBlock(self.percentage,self.shouldComplete);
            break;
    }
}
//- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    NSLog(@"%s",__func__);
//}
@end
