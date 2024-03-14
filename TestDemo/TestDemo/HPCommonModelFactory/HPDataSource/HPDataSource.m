//
//  HPDataSource.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import "HPDataSource.h"


typedef NSUInteger(^HP_Request_tb_SectionNumbersWithView_Handler)(UITableView*view);
typedef NSUInteger(^HP_Request_tb_NumbersWithIndxPath_Handler)(UITableView*view,NSUInteger section);

typedef NSUInteger(^HP_Request_col_SectionNumbersWithView_Handler)(UICollectionView*view);
typedef NSUInteger(^HP_Request_col_NumbersWithIndxPath_Handler)(UICollectionView*view,NSUInteger section);

typedef UITableViewCell*(^HP_Request_TableViewCellWithIndxPath_Handler)(UITableView*view,NSIndexPath *indexPath);
typedef UICollectionViewCell*(^HP_Request_CollectionViewCellWithIndxPath_Handler)(UICollectionView*view,NSIndexPath *indexPath);

 
typedef BOOL(^HP_Request_col_CanMoveItemSwitch_Handler)(UICollectionView*view,NSIndexPath *indexPath);
typedef void(^HP_Request_col_ItemMoveTrendIndxPath_Handler)(UICollectionView*view,NSIndexPath *fromIndexPath,NSIndexPath *toIndexPath);

typedef UICollectionReusableView*(^HP_Request_col_SupplementaryElementWithIndxPath_Handler)(UICollectionView*view,HPCollectionViewSupplementaryElementKind kind,NSIndexPath *indexPath);


@interface HPDataSource ()<UITableViewDataSource>
//Desc:
@property (copy, nonatomic) HP_Request_tb_SectionNumbersWithView_Handler tb_requestSectionNumberOfTableView;
@property (copy, nonatomic) HP_Request_tb_NumbersWithIndxPath_Handler tb_requestRowsNumberOfSections;
@property (copy, nonatomic) HP_Request_TableViewCellWithIndxPath_Handler tb_requestTableViewCellForRow;
@end
@interface HPDataSource ()<UICollectionViewDataSource>

@property (copy, nonatomic) HP_Request_col_SectionNumbersWithView_Handler col_requestSectionNumberOfCollectionView;
@property (copy, nonatomic) HP_Request_col_NumbersWithIndxPath_Handler col_requestRowsNumberOfSections;
@property (copy, nonatomic) HP_Request_CollectionViewCellWithIndxPath_Handler col_requestCollectionViewCellForRow;



@property (copy, nonatomic) HP_Request_col_CanMoveItemSwitch_Handler col_requestItemMoveSwitchOfCollectionView;
@property (copy, nonatomic) HP_Request_col_ItemMoveTrendIndxPath_Handler col_requestItemMoveOfIndexPath;
@property (copy, nonatomic) HP_Request_col_SupplementaryElementWithIndxPath_Handler col_requestSupplementaryElementWithIndxPath;




@end
 
@implementation HPDataSource

#pragma UITableView-Datasource

- (HPDataSource*(^)(Class ,UITableView*))registTableViewCellWithClass{
    return ^(Class registingItemClass,UITableView*tableView){
        NSString *reuseId = NSStringFromClass(registingItemClass);
        
        if ([registingItemClass isKindOfClass:[UITableViewCell class]]||[registingItemClass isSubclassOfClass:[UITableViewCell class]]) {
            [tableView registerClass:registingItemClass forCellReuseIdentifier:reuseId];
        }else  if ([registingItemClass isKindOfClass:[UITableViewHeaderFooterView class]]||[registingItemClass isSubclassOfClass:[UITableViewHeaderFooterView class]]) {
            [tableView registerClass:registingItemClass forHeaderFooterViewReuseIdentifier:reuseId];
        }else{
            NSLog(@"注册失败");
            
        }
        return self;
    };
}// Display customization :Read Detail From UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return !self.tb_requestSectionNumberOfTableView?0:self.tb_requestSectionNumberOfTableView(tableView);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return !self.tb_requestRowsNumberOfSections?0:self.tb_requestRowsNumberOfSections(tableView,section);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return !self.tb_requestTableViewCellForRow?nil:self.tb_requestTableViewCellForRow(tableView,indexPath);
}

#pragma UICollectionView-Datasource
- (HPDataSource*(^)(Class ,UICollectionView*,NSString*))registCollectionViewItemWithClass{
    return ^(Class registingItemClass,UICollectionView*collectionView,NSString*kind){
        NSString *reuseId = NSStringFromClass(registingItemClass);
        if ([registingItemClass isKindOfClass:[UICollectionViewCell class]]||[registingItemClass isSubclassOfClass:[UICollectionViewCell class]]) {
            [collectionView registerClass:registingItemClass forCellWithReuseIdentifier:reuseId];
        }else  if ([registingItemClass isKindOfClass:[UICollectionReusableView class]]||[registingItemClass isSubclassOfClass:[UICollectionReusableView class]]) {
            [collectionView registerClass:registingItemClass forSupplementaryViewOfKind:kind withReuseIdentifier:reuseId];
        } else{
            NSLog(@"注册失败");
        }
        return self;
    };
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return !self.col_requestSectionNumberOfCollectionView?0:self.col_requestSectionNumberOfCollectionView(collectionView);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return !self.col_requestRowsNumberOfSections?0:self.col_requestRowsNumberOfSections(collectionView,section);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return !self.col_requestCollectionViewCellForRow?nil:self.col_requestCollectionViewCellForRow(collectionView,indexPath);
}
  
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    HPCollectionViewSupplementaryElementKind kd = HPC_SupplementaryElement_Header;
    kd = (kind == UICollectionElementKindSectionHeader)?HPC_SupplementaryElement_Header:HPC_SupplementaryElement_Footer;
    reusableView = !self.col_requestSupplementaryElementWithIndxPath?nil:self.col_requestSupplementaryElementWithIndxPath(collectionView,kd,indexPath);
    return reusableView;
}
//
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return !self.col_requestItemMoveSwitchOfCollectionView?NO:self.col_requestItemMoveSwitchOfCollectionView(collectionView,indexPath);
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
      !self.col_requestItemMoveOfIndexPath?:self.col_requestItemMoveOfIndexPath(collectionView,sourceIndexPath,destinationIndexPath);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//
/*
 [[HPDataSource sharedInstance]tb_NumberOfSections:^NSUInteger(UIView *view, NSUInteger section) {
    return 0;
 } numberOfRows:^NSUInteger(UIView *view, NSUInteger section) {
    return 0;
 } cellForRow:^UITableViewCell *(UITableView *view, NSIndexPath *indexPath) {
    return nil;
 }];
 [[HPDataSource sharedInstance]col_NumberOfSections:^NSUInteger(UIView *view, NSUInteger section) {
    return 0;
 } numberOfRows:^NSUInteger(UIView *view, NSUInteger section) {
    return 0;
 } cellForRow:^UICollectionViewCell *(UICollectionView *view, NSIndexPath *indexPath) {
    return nil;
 }];
 */ 
+ (instancetype)sharedInstance{
    return [[self alloc]init];
}
@end
#pragma NSTableView
@interface HPDataSource(NSTableView)
@end
@implementation HPDataSource(NSTableView)
- (void)tb_SetNumberOfSections:(HP_Request_tb_SectionNumbersWithView_Handler)SectioHPConfigBlock setNumberOfRows:(HP_Request_tb_NumbersWithIndxPath_Handler)RowConfigBlock setCellForRow:(HP_Request_TableViewCellWithIndxPath_Handler)CellConfigBlock
{
    self.tb_requestSectionNumberOfTableView = [SectioHPConfigBlock copy];
    self.tb_requestRowsNumberOfSections = [RowConfigBlock copy];
    self.tb_requestTableViewCellForRow = [CellConfigBlock copy];
}


@end

#pragma HPCollectionView
@interface HPDataSource(HPCollectionView)
@end

@implementation HPDataSource(HPCollectionView)


- (void)col_SetNumberOfSections:(HP_Request_col_SectionNumbersWithView_Handler)SectioHPConfigBlock setNumberOfRows:(HP_Request_col_NumbersWithIndxPath_Handler)RowConfigBlock setItemForRow:(HP_Request_CollectionViewCellWithIndxPath_Handler)CellConfigBlock{
    self.col_requestSectionNumberOfCollectionView = [SectioHPConfigBlock copy];
    self.col_requestRowsNumberOfSections = [RowConfigBlock copy];
    self.col_requestCollectionViewCellForRow = [CellConfigBlock copy];
}
-(void)col_SetItemMoveSwitchOfIndexPath:(HP_Request_col_CanMoveItemSwitch_Handler)CanMoveItemConfigBlock setItemMoveFromIndexPathToIndexPath:(HP_Request_col_ItemMoveTrendIndxPath_Handler)RowConfigBlock{
    self.col_requestItemMoveSwitchOfCollectionView = [CanMoveItemConfigBlock copy];
    self.col_requestItemMoveOfIndexPath = [RowConfigBlock copy];
}
- (void)col_SetSupplementaryElementViewAtIndexPath:(UICollectionReusableView *(^)(UICollectionView *, HPCollectionViewSupplementaryElementKind kind, NSIndexPath *))SetSupplementaryElementViewConfigBlock{
    self.col_requestSupplementaryElementWithIndxPath = [SetSupplementaryElementViewConfigBlock copy];
}


@end
