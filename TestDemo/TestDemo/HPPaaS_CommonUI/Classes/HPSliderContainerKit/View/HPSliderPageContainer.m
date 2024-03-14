//
//  HPSliderPageContainer.m
//  HPSliderContainerKitDemo
//
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//

#import "HPSliderPageContainer.h"


#import "UIView+HPCommonUI.h"



//////define this constant if you want to use Masonry without the 'mas_' prefix
//#define MAS_SHORTHAND
//////define this constant if you want to enable auto-boxing for default syntax
//#define MAS_SHORTHAND_GLOBALS
//#import <Masonry.h>

NSString *const kCachedTimeKey = @"kCachedTime";
NSString *const kCachedVCKey = @"kCachedVCName";

@interface HPSliderPageContainerCell : UICollectionViewCell
- (void)configCellWithController:(UIViewController *)controller;
@end

@implementation HPSliderPageContainerCell
- (void)configCellWithController:(UIViewController *)controller
{
    controller.view.frame = self.bounds;
    CGSize itemSize = self.bounds.size;
    NSLog(@"itemSize:%@",NSStringFromCGSize(itemSize));
    [self.contentView addSubview:controller.view];
}
@end

@interface HPSliderPageContainer ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic,weak) UICollectionView *pageCollectionView; /**< 页面展示View  */
@property (nonatomic,weak) UICollectionViewFlowLayout *pageFlowLayout;



@property (nonatomic,strong) NSArray *params;     /**< 可供传递的参数  */

@property (strong, nonatomic) NSArray *capacityItems;

@end

@implementation HPSliderPageContainer

+(instancetype)containerWithFrame:(CGRect)frame delegate:(id<HPSliderPageContainerProtocol>)delegate{
    return [self containerWithFrame:frame Item:nil delegate:delegate];
}
+(instancetype)containerWithFrame:(CGRect)frame Item:(NSArray *)items delegate:(id<HPSliderPageContainerProtocol>)delegate{
    HPSliderPageContainer *container = [[self alloc]initWithFrame:frame];
    container.delegate = delegate;
    container.capacityItems = [items copy];
    return container;
}

-(void)selectItemAtIndex:(NSInteger)index{
    [self.pageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.pageCollectionView reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMainView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupMainView];
}


#pragma - mark setupMethod

static NSString *const Id = @"HPSliderPageContainerCell";
- (void)setupMainView{
    
    //初始化页面布局
    UICollectionViewFlowLayout *pageFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    pageFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    pageFlowLayout.minimumLineSpacing = 0;
    pageFlowLayout.minimumInteritemSpacing = 0;
    self.pageFlowLayout = pageFlowLayout;
    
    //初始化页面View
    UICollectionView *pageCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:pageFlowLayout];
    [pageCollectionView registerClass:[HPSliderPageContainerCell class] forCellWithReuseIdentifier:Id];
    pageCollectionView.backgroundColor = [UIColor whiteColor];
    pageCollectionView.showsHorizontalScrollIndicator = NO;
    pageCollectionView.dataSource = self;
    pageCollectionView.delegate = self;
    pageCollectionView.pagingEnabled = YES;
    [self addSubview:pageCollectionView];
    self.pageCollectionView = pageCollectionView;
    
    [pageCollectionView setContentOffset:CGPointZero];
    [pageCollectionView setContentInset:UIEdgeInsetsZero];
}
-(void)setCapacityItems:(NSArray *)capacityItems{
    _capacityItems = capacityItems;
    [self.pageCollectionView reloadData];
}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self.pageCollectionView reloadData];
}
-(void)didMoveToWindow{
    [super didMoveToWindow];
    [self.pageCollectionView reloadData];
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark - UICollectionViewDataSource Protocol Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.capacityItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //页面
    HPSliderPageContainerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Id forIndexPath:indexPath];
    UIViewController *currPageVc = self.capacityItems[indexPath.row];
    if (self.params.count>0&&![currPageVc valueForKey:@"XHParamJsonStr"]) {
        [currPageVc setValue:self.params[indexPath.item] forKey:@"XHParamJsonStr"];
    }
    [cell configCellWithController:currPageVc];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout Protocol Methods
//sizeForItemAtIndexPath 只调用一次,一次性计算所有cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-5);
//    DLog(@"itemSize:%@",NSStringFromCGSize(itemSize));
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}


#pragma - mark UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UICollectionView *)scrollView{
    if (scrollView == self.pageCollectionView) {
        [scrollView reloadData];
        int index = scrollView.contentOffset.x / self.pageCollectionView.frame.size.width;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
//        [self collectionView:self.tagCollectionView didSelectItemAtIndexPath:indexPath];
        if ([self.delegate respondsToSelector:@selector(container:didScrollToItemAtIndex:)]) {
            [self.delegate container:self didScrollToItemAtIndex:indexPath.item];
        }
    }
}

#pragma - mark publicMethod
-(void)reloadDataWithSubViewDisplayVcInstance:(NSArray *)vcs{
    self.capacityItems = [vcs copy];
    [self.pageCollectionView reloadData];
}
-(void)reloadDataWithSubViewDisplayVcInstance:(NSArray *)vcs withParams:(NSArray *)params{
    self.params = [params copy];
    self.capacityItems = [vcs copy];
    [self.pageCollectionView reloadData];
}





@end
