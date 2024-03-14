//
//  HPCollectionView.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import <UIKit/UIKit.h>

#import "HPDataSource.h"
#import "HPDelegate.h"
#import "HPCollectionViewFlowLayout.h"
#import "HPCollectionViewCell.h"
@interface HPCollectionView : UICollectionView
@property (strong, nonatomic) HPDataSource <UICollectionViewDataSource>*ns_dataSource;
@property (strong, nonatomic) HPDelegate <UICollectionViewDelegate>*ns_delegate;

 



@end
 
