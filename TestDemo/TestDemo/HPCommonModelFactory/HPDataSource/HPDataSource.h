//
//  HPDataSource.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import <UIKit/UIKit.h>
 

typedef enum{
    HPC_SupplementaryElement_Header = 0,
    HPC_SupplementaryElement_Footer
}HPCollectionViewSupplementaryElementKind;
@protocol HPDataSourceProtocol <NSObject>

@optional
/**
 * WorkFor:UITableView Instance
 * NumberOfSections
 * NumberOfRows
 * ItemForRow
 */
- (void)tb_SetNumberOfSections:(NSUInteger(^)(UITableView*tableView))SectioHPConfigBlock
               setNumberOfRows:(NSUInteger(^)(UITableView*tableView,NSUInteger section))RowConfigBlock
                 setCellForRow:(UITableViewCell*(^)(UITableView*tableView,NSIndexPath *indexPath))CellConfigBlock;
/**
 * WorkFor:UICollectionView Instance
 * NumberOfSections
 * NumberOfRows
 * ItemForRow
*/
- (void)col_SetNumberOfSections:(NSUInteger(^)(UICollectionView*collecitonView))SectioHPConfigBlock
                setNumberOfRows:(NSUInteger(^)(UICollectionView*collecitonView,NSUInteger section))RowConfigBlock
                  setItemForRow:(UICollectionViewCell*(^)(UICollectionView*collecitonView,NSIndexPath *indexPath))CellConfigBlock;

/**
 * WorkFor:UICollectionView Instance
 * canMoveItemAtIndexPath
 * moveItemAtIndexPath toIndexPath
*/
- (void)col_SetItemMoveSwitchOfIndexPath:(BOOL(^)(UICollectionView*collecitonView,NSIndexPath *indexPath))CanMoveItemConfigBlock
     setItemMoveFromIndexPathToIndexPath:(void(^)(UICollectionView*collecitonView,NSIndexPath *sourceIndexPath,NSIndexPath *destinationIndexPath))RowConfigBlock;




/**
 * WorkFor:UICollectionView Instance
 * SetSupplementaryElementView
*/
- (void)col_SetSupplementaryElementViewAtIndexPath:(UICollectionReusableView *(^)(UICollectionView*collecitonView,HPCollectionViewSupplementaryElementKind kind,NSIndexPath *indexPath))SetSupplementaryElementViewConfigBlock;


@end

@interface HPDataSource : NSObject<HPDataSourceProtocol,UITableViewDataSource,UICollectionViewDataSource>
+ (instancetype)sharedInstance;
- (HPDataSource*(^)(Class registingItemClass,UITableView*tableView))registTableViewCellWithClass;
- (HPDataSource*(^)(Class registingItemClass,UICollectionView*collectionView,NSString*kind))registCollectionViewItemWithClass;

@end
 
