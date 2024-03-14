//
//  UIBarButtonItem+HPCommonUI.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/10.
//

#import "UIBarButtonItem+HPCommonUI.h"
#import "UIButton+HPCommonUI.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (HPCommonUI)

//
+ (instancetype)leftItemWithImage:(UIImage*)image click:(HPBarBtnItemHandler)actionClickBlock{
   
    return [self leftItemWithImage:image
                             frame:CGRectMake(0, 0, 24, 44)
                             click:actionClickBlock];
}
+ (instancetype)rightItemWithImage:(UIImage*)image click:(HPBarBtnItemHandler)actionClickBlock{
   
    return [self rightItemWithImage:image
                              frame:CGRectMake(0, 0, 24, 44)
                              click:actionClickBlock];
}//
+ (instancetype)leftItemWithImage:(UIImage*)image  frame:(CGRect)rect click:(HPBarBtnItemHandler)actionClickBlock{
    
    return [self itemWithTitle:nil
                    titleColor:nil
                         image:image
                     titleFont:nil
                         frame:rect
              contentHAligment:UIControlContentHorizontalAlignmentLeft
                  contentStyle:HPButtonContent_LeftIcon_RightTitle_Default
                         click:actionClickBlock];
}
+ (instancetype)rightItemWithImage:(UIImage*)image frame:(CGRect)rect  click:(HPBarBtnItemHandler)actionClickBlock{
   
    return [self itemWithTitle:nil
                    titleColor:nil
                         image:image
                     titleFont:nil
                         frame:rect
              contentHAligment:UIControlContentHorizontalAlignmentRight
                  contentStyle:HPButtonContent_LeftIcon_RightTitle_Default
                         click:actionClickBlock];
}
//

+ (instancetype)rightItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)tFont  click:(HPBarBtnItemHandler)actionClickBlock{
   
    return [self itemWithTitle:title
                    titleColor:titleColor
                         image:nil
                     titleFont:tFont
                         frame:CGRectMake(0, 0, 80, 44)
              contentHAligment:UIControlContentHorizontalAlignmentRight
                  contentStyle:HPButtonContent_LeftIcon_RightTitle_Default
                         click:actionClickBlock];
}
//
+ (instancetype)leftItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)tFont  click:(HPBarBtnItemHandler)actionClickBlock{
   
    return [self itemWithTitle:title
                    titleColor:titleColor
                         image:nil
                     titleFont:tFont
                         frame:CGRectMake(0, 0, 80, 44)
              contentHAligment:UIControlContentHorizontalAlignmentLeft
                  contentStyle:HPButtonContent_LeftIcon_RightTitle_Default
                         click:actionClickBlock];
}
 
+ (instancetype)leftItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)tFont image:(UIImage*)image contentStyle:(HPButtonContentStyle)contentStyle click:(HPBarBtnItemHandler)actionClickBlock{
    
    return [self itemWithTitle:title
                    titleColor:titleColor
                         image:image
                     titleFont:tFont
                         frame:CGRectMake(0, 0, 80, 44)
              contentHAligment:UIControlContentHorizontalAlignmentLeft
                  contentStyle:contentStyle
                         click:actionClickBlock];
}

+ (instancetype)rightItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)tFont image:(UIImage*)image contentStyle:(HPButtonContentStyle)contentStyle  click:(HPBarBtnItemHandler)actionClickBlock{
    
    return [self itemWithTitle:title
                    titleColor:titleColor
                         image:image
                     titleFont:tFont
                         frame:CGRectMake(0, 0, 80, 44)
              contentHAligment:UIControlContentHorizontalAlignmentRight
                  contentStyle:contentStyle
                         click:actionClickBlock];
}
+ (instancetype)itemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor image:(UIImage*)image titleFont:(UIFont*)tFont frame:(CGRect)rect contentHAligment:(UIControlContentHorizontalAlignment)ha contentStyle:(HPButtonContentStyle)contentStyle click:(HPBarBtnItemHandler)actionClickBlock{
    UIButton *button =  [UIButton customBtnWithTitle:title titleColor:titleColor titleFont:tFont image:image frame:rect contentHAligment:ha contentStyle:contentStyle click:actionClickBlock];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    objc_setAssociatedObject(item, @selector(customBtn), button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return item;
}
- (UIButton *)customBtn{
    UIButton *customBtn = objc_getAssociatedObject(self, _cmd);
    return customBtn;
}
@end
