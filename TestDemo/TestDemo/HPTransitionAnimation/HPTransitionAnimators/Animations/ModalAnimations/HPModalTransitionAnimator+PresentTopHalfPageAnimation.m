//
//  HPModalTransitionAnimator+PresentTopHalfPageAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPModalTransitionAnimator+PresentTopHalfPageAnimation.h"

@implementation HPModalTransitionAnimator (PresentTopHalfPageAnimation)


 
- (void)presentTopHalfPageAnimationWithTransitionState:(HPPageTransitionState)state{
    
    __weak typeof(self)  weakSelf = self;
    void (^CallOpenPageHandler)(void) = ^(void){
        //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
        UIViewController *toVC = weakSelf.toViewController;
        UIViewController *fromVC = weakSelf.fromViewController;
        //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        tempView.frame = fromVC.view.frame;
        //因为对截图做动画，vc1就可以隐藏了
        fromVC.view.hidden = YES;
        //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理者所有做转场动画的视图
        UIView *containerView = weakSelf.containerView;
        //将截图视图和vc2的view都加入ContainerView中
        [containerView addSubview:tempView];
        [containerView addSubview:toVC.view];
        //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
        toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, 400);
        //开始动画吧，使用产生弹簧效果的动画API
        [UIView animateWithDuration:weakSelf.duration delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
            //首先我们让vc2向上移动
            toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
            //然后让截图视图缩小一点即可
            tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        } completion:^(BOOL finished) {
            //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在，会出现无法交互的情况，切记
            [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
            //转场失败后的处理
            if ([weakSelf.transitionContext transitionWasCancelled]) {
                //失败后，我们要把vc1显示出来
                fromVC.view.hidden = NO;
                //然后移除截图视图，因为下次触发present会重新截图
                [tempView removeFromSuperview];
            }
        }];
    };
    
    void (^CallClosePageHandler)(void) = ^(void){
        //注意在dismiss的时候fromVC就是vc2了，toVC才是VC1了，注意理解这个逻辑关系
        UIViewController *fromVC = weakSelf.fromViewController;
        UIViewController *toVC = weakSelf.toViewController;
        //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
        UIView *containerView = weakSelf.containerView;
        NSArray *subviewsArray = containerView.subviews;
        UIView *tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
        //动画吧
        [UIView animateWithDuration:weakSelf.duration animations:^{
            //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
            fromVC.view.transform = CGAffineTransformIdentity;
            tempView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if ([weakSelf.transitionContext transitionWasCancelled]) {
                //失败了接标记失败
                [weakSelf.transitionContext completeTransition:NO];
            }else{
                //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
                [weakSelf.transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
                [tempView removeFromSuperview];
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
@end
