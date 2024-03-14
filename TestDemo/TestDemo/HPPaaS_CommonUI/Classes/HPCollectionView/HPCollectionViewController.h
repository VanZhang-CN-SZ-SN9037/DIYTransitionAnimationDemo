//
//  HPCollectionViewController.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//

#import <UIKit/UIKit.h>
 
#import "HPCollectionView.h"

@interface HPCollectionViewController : UIViewController
//Desc:
@property (strong, nonatomic) HPCollectionView *collectionView;

- (void)dataSouece:(void(^)(HPCollectionView *collectionView,HPDataSource*datasource))datasourceHandlerBlock delegate:(void(^)(HPCollectionView *collectionView,HPDelegate*delegate))delegateHandlerBlock;
@end
 
