//
//  HPSliderPageContainer.h
//  HPSliderContainerKitDemo
//
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//

#import <UIKit/UIKit.h>




@class HPSliderPageContainer;
@protocol HPSliderPageContainerProtocol <NSObject>

-(void)container:(HPSliderPageContainer*)container didScrollToItemAtIndex:(NSInteger)index;

@end
@interface HPSliderPageContainer : UIView


@property (nonatomic,strong) UIColor *backgroundColor;  /**< 背景色  */


@property(weak, nonatomic) id <HPSliderPageContainerProtocol>delegate;


+(instancetype)containerWithFrame:(CGRect)frame delegate:(id<HPSliderPageContainerProtocol>)delegate;

+(instancetype)containerWithFrame:(CGRect)frame Item:(NSArray *)items delegate:(id<HPSliderPageContainerProtocol>)delegate;


-(void)selectItemAtIndex:(NSInteger)index;
/**
 *  刷新界面数据
 * 
 */
- (void)reloadDataWithSubViewDisplayVcInstance:(NSArray *)vcs;
/**
 *  可以传递参数的刷新方法
 */
- (void)reloadDataWithSubViewDisplayVcInstance:(NSArray *)vcs withParams:(NSArray *)params;



@end
