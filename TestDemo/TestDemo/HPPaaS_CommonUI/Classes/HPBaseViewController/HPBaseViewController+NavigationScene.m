//
//  HPBaseViewController+NavigationScene.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import "HPBaseViewController+NavigationScene.h"

#import "HPViewUtilities.h"
#import "HPFrameworkInterface.h"

@implementation HPBaseViewController (NavigationScene)

#pragma   显示导航栏
- (void)hp_showNavBar {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma   隐藏导航栏

- (void)hp_hideNavBar {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[self.class _imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self.class _imageWithColor:[UIColor clearColor]]];
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
}
- (void)hp_cleanNavBar {
    self.navigationController.navigationBar.translucent = YES;
    //    //    导航栏变为透明
    [self.navigationController.navigationBar setBackgroundImage:[self.class  _imageWithColor:[UIColor clearColor]] forBarMetrics:0];
    //    //    让黑线消失的方法
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[self.class _imageWithColor:[UIColor clearColor]]];
    }
    //        [self setNavBarColor:[UIColor clearColor]];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
}


 

+ (UIImage *)_imageWithColor:(UIColor *)color
{
    return [self _imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




- (void)hp_popOrDissmissToLastPage {
    [HPBaseViewController currViewController:^(UIViewController *vc) {
        //        NSArray *ctrls  = vc.childViewControllers;ctrls.count>0
        if ([vc isKindOfClass:[UINavigationController class]]) {//当前控制器是被modal出来的
            UINavigationController *nav = (UINavigationController*)vc;
            [nav popViewControllerAnimated :YES];
        }else if (vc.navigationController.topViewController == vc){
            [vc.navigationController popViewControllerAnimated:YES];
        }else if (vc.presentingViewController){
            [vc dismissViewControllerAnimated:YES completion:NULL];
        }
    }];
}

- (void)hp_popToHomePageWithTabIndex:(NSInteger)index completion:(HPComplectionHandlerBlock)completion {
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    NSInteger viewIndex = 0;
    for (UIView *view in keyWindow.subviews)
    {
        if (viewIndex > 0)
        {
            [view removeFromSuperview];
        }
        viewIndex++;
    }
    
    self.tabBarController.selectedIndex = index;
    
    if ([self.tabBarController presentedViewController]) {
        [self.tabBarController dismissViewControllerAnimated:NO completion:^{
            for (UINavigationController *nav in self
                 .tabBarController.viewControllers) {
                [nav popToRootViewControllerAnimated:NO];
            }
            if (completion)
                completion();
        }];
    } else {
        for (UINavigationController *nav in self
             .tabBarController.viewControllers) {
            [nav popToRootViewControllerAnimated:NO];
        }
        if (completion)
            completion();
    }
}

- (void)hp_popWithAnimated:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)hp_pushOrModalToNextPage:(UIViewController *)nextPage {
    if (!nextPage) { return;}
    [HPBaseViewController currViewController:^(UIViewController *vc) {
//        NSArray *ctrls  = vc.childViewControllers;ctrls.count>0
        if ([vc isKindOfClass:[UINavigationController class]]) {//当前控制器是被modal出来的
            UINavigationController *nav = (UINavigationController*)vc;
            [nav pushViewController:nextPage animated:YES];
        }else if (vc.navigationController.topViewController == vc){
             
            [vc.navigationController pushViewController:nextPage animated:YES];
        }else if (vc.presentingViewController){
            [vc presentViewController:nextPage animated:YES completion:NULL];
        }
    }];
}

- (void)hp_pushViewController:(UIViewController *)controller {
    if (!controller) { return;}
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)hp_returnToViewControllerWithClass:(Class)targetVcClass {
    if (!targetVcClass) { return;}
    [self.navigationController.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:targetVcClass]) {
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
            return;
        }
    }];
}

- (void)hp_setupBackItemWithTitle:(NSString *)title forViewController:(UIViewController *)vc backHandle:(HPComplectionHandlerBlock)backBlock {
    UIButton *backBarBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBarBtn setTitle:title forState:UIControlStateNormal];
    [backBarBtn setTitleColor:[HPFrameworkInterface sharedInstance].navigationBarBackButtonTextColor forState:UIControlStateNormal];
    backBarBtn.titleLabel.font = [HPFrameworkInterface sharedInstance].navigationBarBackButtonTextFont;
    backBarBtn.contentVerticalAlignment =  UIControlContentVerticalAlignmentCenter;
    backBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBarBtn setImage:[HPFrameworkInterface sharedInstance].navigationBarBackButtonImage forState:UIControlStateNormal];
    [backBarBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBarBtn];
    vc.navigationItem.leftBarButtonItem  = leftItem;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
+(void)currViewController:(void(^)(UIViewController*vc))actionBlock{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //    NSLog(@"window:%@",window);
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    //    NSLog(@"nextResponder:%@",nextResponder);
    if ([nextResponder isKindOfClass:[UIView class]]) {
        nextResponder = window.rootViewController;
    }
    if([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController *tab = (UITabBarController*)nextResponder;
        UIViewController*tabSelectedVc = tab.selectedViewController;
        if ([tabSelectedVc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController*)tabSelectedVc;
            result = !nav.visibleViewController?nav.topViewController:nav.visibleViewController;
        }else{
            result = tabSelectedVc;
        }
    }else if([nextResponder isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController*)nextResponder;
        result = !nav.visibleViewController?nav.topViewController:nav.visibleViewController;
    }else{
        result = nextResponder;
    }
    
    !actionBlock?:actionBlock(result);
}

@end
