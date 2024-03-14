//
//  HPBubble.h
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/7.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HP_Bubble_Style_Circle = 0,//圆
    HP_Bubble_Style_Rectangle,//矩形
    HP_Bubble_Style_Customization,//自定义UI形状
    HP_Bubble_Style_Circle_WithShadowLine,//带阴影的圆
    HP_Bubble_Style_Rectangle_WithShadowLine,//带阴影的矩形
    HP_Bubble_Style_Customization_WithShadowLine//自定义UI形状带阴影
}HPBubbleStyle;

@interface HPBubble : UIView
/**
 *  颜色
 */
@property (nonatomic , strong ) UIColor *color;


/**
 *  父视图中可移动范围边距 默认为 0 0 0 0 (气泡默认可活动范围为父视图大小)
 */
 @property (nonatomic , assign ) UIEdgeInsets edgeInsets;

/**
 *   气泡类型
 */
@property (assign, nonatomic) HPBubbleStyle style;
/**
 *  添加动画
 */
- (void)addAnimations;
/**
 *  移除动画
 */
- (void)endAnimator;
/**
 *  自动动画
 */
@property (assign, nonatomic) BOOL autoAnimation;

+ (instancetype)circleBubbleWithCenter:(CGPoint)point bubbleImg:(UIImage *)image clickCallBack:(void (^)(void))clickHandlerBlock;

+ (instancetype)bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect bubbleImg:(UIImage*)image clickCallBack:(void(^)(void))clickHandlerBlock;
 
+ (instancetype)bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect custtomView:(UIView*)view clickCallBack:(void(^)(void))clickHandlerBlock;

@end

