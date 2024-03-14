//
//  HPCommonUIFactory.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import <Foundation/Foundation.h>
#import "HPTableView.h"
//#import "HPCollectionView.h"
//#import "HPMenuOperation.h"
//#import "HPBubble.h"
typedef NS_ENUM(NSUInteger,HPMenuBarPosition) {
    HPMenuBarPosition_Left = 0,
    HPMenuBarPosition_Center,
    HPMenuBarPosition_Right,
};
//typedef void(^CommonMenuItemHandler)(HPMenuItem *item);
typedef void(^CommonClickHandler)(void);
@interface HPCommonUIFactory : NSObject

+ (HPTableView*)tableViewWithSuperView:(UIView*)superView
                            datasource:(void(^)(HPTableView *tableView,HPDataSource*datasource))datasourceHandlerBlock
                              delegate:(void(^)(HPTableView *tableView,HPDelegate*delegate))delegateHandlerBlock;

//+ (HPCollectionView*)collectionViewWithSuperView:(UIView*)superView
//                            collectionViewLayout:(UICollectionViewLayout*)layout
//                                      datasource:(void(^)(HPCollectionView *collectionView,HPDataSource*datasource))datasourceHandlerBlock
//                                        delegate:(void(^)(HPCollectionView *collectionView,HPDelegate*delegate))delegateHandlerBlock;



+ (void)tableView:(HPTableView*)tableView
       datasource:(void(^)(HPTableView *tableView,HPDataSource*datasource))datasourceHandlerBlock
         delegate:(void(^)(HPTableView *tableView,HPDelegate*delegate))delegateHandlerBlock;

//+ (void)collectionView:(HPCollectionView*)collectionView
//            datasource:(void(^)(HPCollectionView *collectionView,HPDataSource*datasource))datasourceHandlerBlock
//              delegate:(void(^)(HPCollectionView *collectionView,HPDelegate*delegate))delegateHandlerBlock;
//
//
//+ (void)configItemMoveWithCollectionView:(HPCollectionView*)collectionView;
//
////上拉菜单 下拉菜单
//
//+ (HPMenuOperation*)menuWithItemTitles:(NSArray<NSString*>*)titles itemActionHandler:(NSArray<CommonMenuItemHandler>*)actions;
//
//+ (HPMenuOperation*)menuWithItemImages:(NSArray<UIImage*>*)imgs itemActionHandler:(NSArray<CommonMenuItemHandler>*)actions;
//
//+ (HPMenuOperation*)menuWithItemTitles:(NSArray<NSString*>*)titles itemImages:(NSArray<UIImage*>*)imgs itemActionHandler:(NSArray<CommonMenuItemHandler>*)actions;
//
//+ (void)showNavigationMenu:(HPMenuOperation*)menu withMenuBarPoisition:(HPMenuBarPosition)position;
//+ (void)showTabBarMenu:(HPMenuOperation*)menu withMenuBarPoisition:(HPMenuBarPosition)position;
//
//
////
//+ (UILabel*)labelWithText:(NSString*)text;
//+ (UILabel*)labelWithText:(NSString*)text textColor:(UIColor*)textColor;
//+ (UILabel*)centerLabelWithText:(NSString*)text textColor:(UIColor*)textColor;
//+ (UILabel*)labelWithText:(NSString*)text textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment;
//
//
//
////
//+ (UIImageView*)imageViewWithImageNamed:(NSString*)imageNamed;
//+ (UIImageView*)blurImageViewWithImageNamed:(NSString*)imageNamed;
//+ (UIImageView*)imageViewWithImageNamed:(NSString*)imageNamed contentMode:(UIViewContentMode)contentMode;
//+ (void)imageView:(UIImageView*)imageView startAnimationWithImages:(NSArray<UIImage*>*)images;
//+ (void)imageView:(UIImageView*)imageView startAnimationWithImages:(NSArray<UIImage*>*)images animationDuration:(CGFloat)duration;
//+ (UIImage*)imageWithNamed:(NSString*)imageNamed;
//
////
//
//
//+ (UIButton*)buttonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor;
//+ (UIButton*)buttonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor selectedTitle:(NSString*)selectedTitle  selectedTitleColor:(UIColor*)selectedTitleColor; 
//+ (UIButton*)buttonWithTitle:(NSString*)title  titleColor:(UIColor*)titleColor selectedTitle:(NSString*)selectedTitle  selectedTitleColor:(UIColor*)selectedTitleColor backgroundImage:(UIImage*)backgroundImage ;
//+ (UIButton*)buttonWithTitle:(NSString*)title  titleColor:(UIColor*)titleColor selectedTitle:(NSString*)selectedTitle  selectedTitleColor:(UIColor*)selectedTitleColor image:(UIImage*)image;
//
//
//// 悬浮 控件
//+ (HPBubble*)showCircleBubbleOnView:(UIView*)view bubbleCenter:(CGPoint)point bubbleImg:(UIImage *)image click:(CommonClickHandler)clockBlock;
//+ (HPBubble*)showBubbleOnView:(UIView*)view bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect bubbleImg:(UIImage*)image click:(CommonClickHandler)clockBlock;
//+ (HPBubble*)showBubbleOnView:(UIView*)view bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect custtomBubbleView:(UIView*)bubbleView click:(CommonClickHandler)clockBlock;

@end
 
