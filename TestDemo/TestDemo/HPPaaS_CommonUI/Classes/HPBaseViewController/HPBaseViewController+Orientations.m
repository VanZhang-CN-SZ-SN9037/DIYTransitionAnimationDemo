//
//  HPBaseViewController+Orientations.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import "HPBaseViewController+Orientations.h"

@implementation HPBaseViewController (Orientations)
#pragma mark - 屏幕旋转
//设置为默认不支持自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}
//初始化屏幕方向--垂直
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
//支持的屏幕方向
//仅仅用当前导航栏的Ctrl  PushPop 的viewCtrl才有效果
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
@end
