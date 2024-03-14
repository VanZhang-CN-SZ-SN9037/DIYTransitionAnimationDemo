//
//  UIButton+HPCommonUI.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/10.
//

#import "UIButton+HPCommonUI.h"

#import <objc/runtime.h>


 
@interface _HPCustomButton :UIButton
//Desc:
@property (assign, nonatomic) HPButtonContentStyle style;
+ (instancetype)btnWithTitle:(NSString*)title
                  titleColor:(UIColor*)titleColor
                   titleFont:(UIFont*)tFont
                       image:(UIImage*)image
                       frame:(CGRect)rect
            contentHAligment:(UIControlContentHorizontalAlignment)ha
                contentStyle:(HPButtonContentStyle)contentStyle
                       click:(HPButtonHandler)actionClickBlock;
@end


@implementation _HPCustomButton
+ (instancetype)btnWithTitle:(NSString*)title titleColor:(UIColor*)titleColor  titleFont:(UIFont*)tFont  image:(UIImage*)image frame:(CGRect)rect contentHAligment:(UIControlContentHorizontalAlignment)ha contentStyle:(HPButtonContentStyle)contentStyle click:(HPButtonHandler)actionClickBlock{
    _HPCustomButton *button = [[_HPCustomButton alloc]initWithFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = tFont;
    button.contentHorizontalAlignment = ha;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    button.style = contentStyle;
    [button click:actionClickBlock];
    return button;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self relayoutWithContentStyle:self.style];
}


- (void)relayoutWithContentStyle:(HPButtonContentStyle)contentStyle{
    UIImageView *contentImgView = self.imageView;
    UILabel *contentLbl = self.titleLabel;
    CGRect imgViewRect = contentImgView.frame;
    CGRect titleLblRect = contentLbl.frame;
    CGFloat contentWidth = CGRectGetWidth(imgViewRect) + CGRectGetWidth(titleLblRect);
    UIControlContentHorizontalAlignment hAligment = self.contentHorizontalAlignment;
    
    switch (contentStyle) {
        case HPButtonContent_LeftIcon_RightTitle_Default:{//
            if (hAligment==UIControlContentHorizontalAlignmentRight) {
                CGFloat left_1st_contentX = CGRectGetWidth(self.frame) - contentWidth;
                [contentImgView setFrame:CGRectMake(left_1st_contentX, CGRectGetMinY(imgViewRect), CGRectGetWidth(imgViewRect), CGRectGetHeight(imgViewRect))];
            } else if (hAligment==UIControlContentHorizontalAlignmentCenter) {
                CGFloat left_1st_contentX = (CGRectGetWidth(self.frame) - contentWidth)/2;
                [contentImgView setFrame:CGRectMake(left_1st_contentX, CGRectGetMinY(imgViewRect), CGRectGetWidth(imgViewRect), CGRectGetHeight(imgViewRect))];
               
            } else { //UIControlContentHorizontalAlignmentLeft 和其它情况
                [contentImgView setFrame:CGRectMake(0, CGRectGetMinY(imgViewRect), CGRectGetWidth(imgViewRect), CGRectGetHeight(imgViewRect))];
            }
            CGFloat contentLblX = CGRectGetMaxX(contentImgView.frame);
            [contentLbl setFrame:CGRectMake(contentLblX, CGRectGetMinY(titleLblRect), CGRectGetWidth(titleLblRect), CGRectGetHeight(titleLblRect))];
        }break;
            
        case HPButtonContent_RightIcon_LeftTitle:{//
            if (hAligment==UIControlContentHorizontalAlignmentRight) {
                CGFloat left_1st_contentX = CGRectGetWidth(self.frame) - contentWidth;
                [contentLbl setFrame:CGRectMake(left_1st_contentX, CGRectGetMinY(titleLblRect), CGRectGetWidth(titleLblRect), CGRectGetHeight(titleLblRect))];
            } else if (hAligment==UIControlContentHorizontalAlignmentCenter) {
                CGFloat left_1st_contentX = (CGRectGetWidth(self.frame) - contentWidth)/2;
                [contentLbl setFrame:CGRectMake(left_1st_contentX, CGRectGetMinY(titleLblRect), CGRectGetWidth(titleLblRect), CGRectGetHeight(titleLblRect))];
            } else { //UIControlContentHorizontalAlignmentLeft 和其它情况
                [contentLbl setFrame:CGRectMake(0, CGRectGetMinY(titleLblRect), CGRectGetWidth(titleLblRect), CGRectGetHeight(titleLblRect))];
                
            }
            CGFloat imgViewX = CGRectGetMaxX(contentLbl.frame);
            [contentImgView setFrame:CGRectMake(imgViewX, CGRectGetMinY(imgViewRect), CGRectGetWidth(imgViewRect), CGRectGetHeight(imgViewRect))];
        }break;
            
        case HPButtonContent_TopIcon_BottomTitle:{//
            CGFloat contentLblHeight = CGRectGetHeight(titleLblRect);
            [contentLbl setFrame:CGRectMake(0, (CGRectGetHeight(self.frame) -contentLblHeight - 5), CGRectGetWidth(self.frame), CGRectGetHeight(titleLblRect))];
            contentLbl.textAlignment = NSTextAlignmentCenter;
            
            CGFloat tmpWidth = CGRectGetWidth(self.frame);
            CGFloat imgViewW = tmpWidth>CGRectGetWidth(imgViewRect)?tmpWidth:CGRectGetWidth(imgViewRect);
            
            CGFloat tmpHeight = (CGRectGetHeight(self.frame)-CGRectGetHeight(contentLbl.frame) - 5 - 5 );
            CGFloat imgViewH = tmpHeight>CGRectGetHeight(imgViewRect)?tmpHeight:CGRectGetHeight(imgViewRect);
            

            CGFloat imgViewX = (imgViewW == CGRectGetWidth(self.frame))?0:CGRectGetMinX(imgViewRect);
            CGFloat imgViewY = (imgViewH == CGRectGetWidth(imgViewRect))?0:5;
            [contentImgView setContentMode:UIViewContentModeScaleAspectFit];
            [contentImgView setFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        }break;
            
        case HPButtonContent_BottomIcon_TopTitle:{//
            CGFloat contentLblHeight = CGRectGetHeight(titleLblRect);
            [contentLbl setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), contentLblHeight)];
            contentLbl.textAlignment = NSTextAlignmentCenter;
            
            CGFloat tmpWidth = CGRectGetWidth(self.frame);
            CGFloat imgViewW = tmpWidth>CGRectGetWidth(imgViewRect)?tmpWidth:CGRectGetWidth(imgViewRect);
            
            
            CGFloat tmpHeight = (CGRectGetHeight(self.frame)-CGRectGetHeight(contentLbl.frame) - 5 - 5 );
            CGFloat imgViewH = tmpHeight>CGRectGetHeight(imgViewRect)?tmpHeight:CGRectGetHeight(imgViewRect);
            
            CGFloat imgViewX = (imgViewW == CGRectGetWidth(self.frame))?0:CGRectGetMinX(imgViewRect);
            CGFloat imgViewY = (imgViewH == CGRectGetWidth(imgViewRect))?CGRectGetMaxY(contentLbl.frame):(CGRectGetMaxY(contentLbl.frame)+5);
            
            [contentImgView setContentMode:UIViewContentModeScaleAspectFit];
            [contentImgView setFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        }break;
    }
}

@end

@implementation UIButton (HPCommonUI)

-(void)observeControlEvents:(UIControlEvents)events withAction:(HPButtonHandler)action{
    objc_setAssociatedObject(self, @selector(btnClick:), action, OBJC_ASSOCIATION_RETAIN);
    [self addTarget:self action:@selector(btnClick:) forControlEvents:events];
}
-(void)click:(HPButtonHandler)block{
    [self observeControlEvents:UIControlEventTouchUpInside withAction:block];
}
-(void)btnClick:(UIButton*)sendor{
    HPButtonHandler clickBlock = objc_getAssociatedObject(self, _cmd);
    !clickBlock?:clickBlock(sendor);
}
+ (instancetype)customBtnWithTitle:(NSString*)title titleColor:(UIColor*)titleColor  titleFont:(UIFont*)tFont  image:(UIImage*)image frame:(CGRect)rect contentHAligment:(UIControlContentHorizontalAlignment)ha contentStyle:(HPButtonContentStyle)contentStyle click:(HPButtonHandler)actionClickBlock{
    return [_HPCustomButton btnWithTitle:title
                              titleColor:titleColor
                               titleFont:tFont
                                   image:image
                                   frame:rect
                        contentHAligment:ha
                            contentStyle:contentStyle
                                   click:actionClickBlock];
}

@end
