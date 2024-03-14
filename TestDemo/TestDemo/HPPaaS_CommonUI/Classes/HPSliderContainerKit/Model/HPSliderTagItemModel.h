//
//  XHTagItemModel.h
//  HPSliderContainerKitDemo
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface HPSliderTagItemModel : NSObject
@property (nonatomic,copy) NSString *tagTitle; /**< 标签名  */
@property (nonatomic,strong) UIFont *normalTitleFont; /**< 正常(非选中)标签字体  */
@property (nonatomic,strong) UIFont *selectedTitleFont; /**< 选中状态标签字体  */

@property (nonatomic,strong) UIColor *normalTitleColor; /**< 正常(非选中)标签字体颜色  */
@property (nonatomic,strong) UIColor *selectedTitleColor; /**< 选中状态标签字体颜色  */

@property (assign,nonatomic) BOOL  selected;
+ (instancetype)modelWithtagTitle:(NSString *)title
               andNormalTitleFont:(UIFont *)normalTitleFont
             andSelectedTitleFont:(UIFont *)selectedTitleFont
              andNormalTitleColor:(UIColor *)normalTitleColor
            andSelectedTitleColor:(UIColor *)selectedTitleColor;

@end
