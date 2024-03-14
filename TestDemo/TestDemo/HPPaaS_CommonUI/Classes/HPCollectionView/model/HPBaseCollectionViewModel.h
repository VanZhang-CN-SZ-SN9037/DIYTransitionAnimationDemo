//
//  HPBaseCollectionViewModel.h
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/7.
//

#import "HPBaseViewModel.h"
 
#import "HPCommonItemModel.h"

@interface HPBaseCollectionViewModel : HPBaseViewModel
@property (weak, nonatomic) UICollectionView *collectionView;
//Desc:
@property (strong, nonatomic) HPCommonItemModel *content;
//需要在子类重载
-(void)hp_actionWithIndex:(NSIndexPath *)index item:(UICollectionViewCell*)cell;
@end
