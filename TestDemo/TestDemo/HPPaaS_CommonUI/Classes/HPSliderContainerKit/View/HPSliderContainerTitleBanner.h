//
//  HPSliderContainerTitleBanner.h
//  HPSliderContainerKitDemo
//
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HPSliderContainerTitleBanner;
@protocol HPSliderContainerTitleBannerProtocol <NSObject>

-(void)banner:(HPSliderContainerTitleBanner*)banner didSelectItemAtIndex:(NSInteger)index;

@end
@interface HPSliderContainerTitleBanner : UIView

@property (nonatomic,strong) UIFont *normalTitleFont; /**< 正常(非选中)标签字体  default is 14*/
@property (nonatomic,strong) UIFont *selectedTitleFont; /**< 选中状态标签字体  default is 16*/

@property (nonatomic,strong) UIColor *normalTitleColor; /**< 正常(非选中)标签字体颜色  default is darkGrayColor*/
@property (nonatomic,strong) UIColor *selectedTitleColor; /**< 选中状态标签字体颜色  default is redColor*/

@property (nonatomic,strong) UIColor  *selectedIndicatorColor; /**< 下方滑块颜色 default is redColor*/


@property (nonatomic,strong) id itemNormalColor; /**< 正常(非选中)标签字体颜色  default is darkGrayColor*/
@property (nonatomic,strong) id  itemSelectedColor; /**< 选中状态标签字体颜色  default is redColor*/


/**
 *  如果tag设置了tagItemSize,则宽度默认跟tagItemSize宽度相同,高度为2(也可手动更改)
 *  如果tag使用自由文本宽度,则默认与第一个标签宽度相同,高度为2,而且宽度会随选中的标签文本宽度改变
 */
@property (nonatomic,assign) CGSize tagItemSize; /**< 每个tag标签的size,如果不设置则会根据文本长度计算*/

@property (nonatomic,assign) CGSize  selectedIndicatorSize;

@property (nonatomic,strong,readonly) UIView *selectionIndicator;

@property(assign, nonatomic) CGFloat minimumInteritemSpacing;

@property(assign, nonatomic) CGFloat minimumLineSpacing;


@property(weak, nonatomic) id <HPSliderContainerTitleBannerProtocol>delegate;
@property (nonatomic,assign,readonly) NSInteger selectedIndex;   /**< 记录tag当前选中的cell索引  */



+ (instancetype)bannerWithFrame:(CGRect)frame delegate:(id<HPSliderContainerTitleBannerProtocol>)delegate;

- (void)setScrollEanble:(BOOL)enable;
- (void)reloadDataWithItems:(NSArray*)items;
- (void)selectItemAtIndex:(NSInteger)index;
@end
