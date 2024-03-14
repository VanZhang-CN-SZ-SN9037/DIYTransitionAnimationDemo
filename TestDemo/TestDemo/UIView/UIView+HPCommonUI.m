//
//  UIView+HPCommonUI.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//  Copyright © 2020 NebulaSky. All rights reserved.
//

#import "UIView+HPCommonUI.h"

@implementation UIView (HPCommonUI) 
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

@end
@implementation UIView (HPNib)
+ (instancetype)loadingXib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class])
                                        owner:nil
                                      options:nil].lastObject;
}
+ (UINib *)loadingNib:(Class)aClass {
    NSString *className = NSStringFromClass(aClass);
    return [UINib nibWithNibName:className bundle:[NSBundle mainBundle]];
}
+ (UINib *)loadingNib{
    return [UIView loadingNib:self];
}
+ (NSString *)reuseId{
    return NSStringFromClass([self class]);
}
+ (NSString *)headerReuseId{
    return [self reuseId];
}
+ (NSString *)footerReuseId{
    return [self reuseId];
}
@end

@implementation UIView (HPRadiusCorner)
- (void)addCornerWithRadius:(CGFloat)radius{
    [self addCornerWithRadius:radius borderWidth:0 borderColor:nil];
}
- (void)addCornerWithRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    [self addCornerWithRadius:radius roundingCorners:UIRectCornerAllCorners borderWidth:width borderColor:color];
}

- (void)addCornerWithRadius:(CGFloat)radius roundingCorners:(UIRectCorner)corners borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    maskLayer.path =  maskPath.CGPath;
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.mask = maskLayer;
    
    if (width&&color) {
        NSLog(@"%s",__func__);
    }
}
@end

@implementation UIView (HPResponder)
+ (UIViewController*)viewController{
    UIViewController *result = nil;
    //1.
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    //2.
//    UIResponder *responder = frontView;
//    while ((responder = [responder nextResponder])) {
//        if ([responder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)responder;
//        }
//    }
    
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIWindow class]]) {
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
    return result;
}


+ (UINavigationController*)navigationController{
    UIViewController*currViewController = [self viewController];
    UINavigationController *navigationController = currViewController.navigationController;
    //? modal ?
    return navigationController;
}

 
+ (UITabBarController*)tabBarController{
    UIViewController*currViewController = [self viewController];
    UITabBarController *tabBarController = currViewController.tabBarController;
    //? modal ?
    return tabBarController;
}
@end

#import <objc/runtime.h>
@implementation UIView (HPGradientColorBanner)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

+ (UIView *)gradientViewWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIView *view = [[self alloc] init];
    [view setGradientBackgroundWithColors:colors locations:locations startPoint:startPoint endPoint:endPoint];
    return view;
}

- (void)setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    self.colors = [colorsM copy];
    self.locations = locations;
    self.startPoint = startPoint;
    self.endPoint = endPoint;
}

#pragma mark - Getter&Setter

- (NSArray *)colors {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setColors:(NSArray *)colors {
    objc_setAssociatedObject(self, @selector(colors), colors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setColors:self.colors];
    }
}

- (NSArray<NSNumber *> *)locations {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLocations:(NSArray<NSNumber *> *)locations {
    objc_setAssociatedObject(self, @selector(locations), locations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setLocations:self.locations];
    }
}

- (CGPoint)startPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setStartPoint:(CGPoint)startPoint {
    objc_setAssociatedObject(self, @selector(startPoint), [NSValue valueWithCGPoint:startPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setStartPoint:self.startPoint];
    }
}

- (CGPoint)endPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setEndPoint:(CGPoint)endPoint {
    objc_setAssociatedObject(self, @selector(endPoint), [NSValue valueWithCGPoint:endPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setEndPoint:self.endPoint];
    }
}

@end

@implementation UILabel (Gradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}


@end
