//
//  HPSliderContainerTitleBanner.m
//  HPSliderContainerKitDemo
//
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//

#import "HPSliderContainerTitleBanner.h"
 
#import "UIView+HPCommonUI.h"


#import "HPSliderTagItemModel.h"
@interface HPSliderContainerTitleItem:UICollectionViewCell
@property (weak, nonatomic) UILabel *titleLb;
@property (weak, nonatomic) UIImageView *iconImgView;
@property (strong, nonatomic) HPSliderTagItemModel *item;
@end

@implementation HPSliderContainerTitleItem
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
-(void)setItem:(HPSliderTagItemModel *)item{
    _item = item;
    
    self.titleLb.text = item.tagTitle;
}
-(void)setupMainView{
    UILabel *titlelLb = [[UILabel alloc]init];
    titlelLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titlelLb];
    self.titleLb = titlelLb;
    UIImageView *iconImgV = [[UIImageView alloc]init];
    [self.contentView addSubview:iconImgV];
    self.iconImgView = iconImgV;
}
#pragma mark UIView LifeCycle

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.iconImgView setFrame:self.bounds];
    [self.titleLb setFrame:self.bounds];
}


@end

@interface HPSliderContainerTitleBanner()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *capacityItems; /**< 标题模型数组  */
@property (nonatomic,assign) NSInteger selectedIndex;   /**< 记录tag当前选中的cell索引  */
@property (nonatomic,strong) UIView *selectionIndicator;  /**< 选择指示器  */

@end
@implementation HPSliderContainerTitleBanner


+(instancetype)bannerWithFrame:(CGRect)frame delegate:(id<HPSliderContainerTitleBannerProtocol>)delegate{
    HPSliderContainerTitleBanner *banner = [[self alloc]initWithFrame:frame];
    
    banner.delegate = delegate;
    return banner;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMainView];
    }
    return self;
}
- (void)setScrollEanble:(BOOL)enable{
    [self.collectionView setScrollEnabled:enable];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupMainView];
}

- (UIView *)selectionIndicator
{
    if (!_selectionIndicator) {
        _selectionIndicator = [[UIView alloc]init];
        _selectionIndicator.backgroundColor = [UIColor clearColor];
        _selectionIndicator.frame = CGRectMake(0, CGRectGetHeight(self.frame)-5, self.selectedIndicatorSize.width, 2);
    }
    
    return _selectionIndicator;
}
-(void)setSelectedIndicatorSize:(CGSize)selectedIndicatorSize{
    _selectedIndicatorSize = selectedIndicatorSize;
    [self.collectionView reloadData];
}
static NSString*const Id = @"HPSliderContainerTitleItem";
-(void)setupMainView{
    self.backgroundColor = [UIColor clearColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    collectionView.backgroundColor = [UIColor clearColor];
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [collectionView registerClass:[HPSliderContainerTitleItem class] forCellWithReuseIdentifier:Id];
    [self addSubview:collectionView];
    //
    self.collectionView = collectionView;
    [self setupDefaultProperties];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}
-(void)reloadDataWithItems:(NSArray*)items{
    if(!items||items.count<=0)return;
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
    [items enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HPSliderTagItemModel *tag = [HPSliderTagItemModel modelWithtagTitle:obj
                                             andNormalTitleFont:self.normalTitleFont
                                           andSelectedTitleFont:self.selectedTitleFont
                                            andNormalTitleColor:self.normalTitleColor
                                          andSelectedTitleColor:self.selectedTitleColor];
        [titles addObject:tag];
    }];
    self.capacityItems = [titles copy];
}
-(void)setCapacityItems:(NSArray *)capacityItems{
    _capacityItems =capacityItems;
    self.selectedIndex = (capacityItems.count>0)?0:-1;
    
//    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO   scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
//    XHTagItemModel *tag = self.capacityItems[0];
//    CGSize selSize = !tag.tagTitle.length?CGSizeZero:[self sizeForTitle:tag.tagTitle withFont:tag.selectedTitleFont];
//    CGSize tagSize =   CGSizeEqualToSize(CGSizeZero, self.tagItemSize)?selSize:self.tagItemSize;
//    if (self.selectedIndicatorSize.width<=0) {
//        self.selectedIndicatorSize = CGSizeMake(tagSize.width, 2);
//    }
    
    self.selectionIndicator.backgroundColor = self.selectedIndicatorColor;
    [self.collectionView addSubview:self.selectionIndicator];
    [self.collectionView reloadData];
}
#pragma - mark setupMethod
- (void)setupDefaultProperties{
    //    NSLog(@"FontFamily:%@",[UIFont familyNames]);
    ////    [UIFont fontNamesForFamilyName:[UIFont familyNames][0]];
    //    NSLog(@"fontNames:%@",[UIFont fontNamesForFamilyName:@"PingFang SC"]);
    
    self.normalTitleFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    self.selectedTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    
    self.normalTitleColor = [UIColor whiteColor];
    self.selectedTitleColor = [UIColor redColor];
    
    self.selectedIndicatorColor = [UIColor redColor];
    self.tagItemSize = CGSizeZero;
    //    self.tagItemGap = 10.f;
    
    self.selectedIndex = -1;

//    _selectedIndicatorSize = CGSizeMake(0, 5);
    _itemNormalColor = [UIColor orangeColor];
    _itemSelectedColor = _itemNormalColor;
}

#pragma mark - UICollectionViewDelegate&UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.capacityItems.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HPSliderContainerTitleItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Id forIndexPath:indexPath];
 
    
    [((CAGradientLayer *)cell.layer) setColors:@[_itemNormalColor]];
    [((CAGradientLayer *)cell.layer) setLocations:@[@0.0,@1.0]];
   
    
    NSInteger index = indexPath.item;
    HPSliderTagItemModel *item = self.capacityItems[index];
    cell.item = item;
    cell.titleLb.textColor = (self.selectedIndex == index)?item.selectedTitleColor:item.normalTitleColor;
    cell.titleLb.font = (self.selectedIndex == index)?item.selectedTitleFont:item.normalTitleFont;
    

    



    if (self.selectedIndex==index) {
        [UIView animateWithDuration:0.3f animations:^{
            CGSize selSize = !item.tagTitle.length?CGSizeZero:[self sizeForTitle:item.tagTitle withFont:item.selectedTitleFont];
            CGSize tagSize = selSize;
            //CGSizeEqualToSize(CGSizeZero, self.selectedIndicatorSize)?selSize:self.selectedIndicatorSize;
            if (self.selectedIndicatorSize.width<=0) {
                self.selectionIndicator.size = CGSizeMake(tagSize.width, self.selectedIndicatorSize.height>0?self.selectedIndicatorSize.height:5);
            }else{
                self.selectionIndicator.size = self.selectedIndicatorSize;
            }
            self.selectionIndicator.centerX = cell.centerX;
        }];

        [UIView animateWithDuration:0.37 animations:^{
            if ([self->_itemSelectedColor isKindOfClass:[UIColor class]]) {
                cell.backgroundColor = self->_itemSelectedColor;
            }else{
                if([self->_itemSelectedColor isKindOfClass:[NSDictionary class]]){
                    [cell setGradientBackgroundWithColors:self->_itemSelectedColor[@"colors"] locations:self->_itemSelectedColor[@"locations"] startPoint:CGPointZero endPoint:CGPointMake(1, 1)];
                }
                
            }
        }];
    }else{
        [UIView animateWithDuration:0.37 animations:^{
            if ([self->_itemNormalColor isKindOfClass:[UIColor class]]) {
                cell.backgroundColor = self->_itemNormalColor;
            }else{
                if([self->_itemNormalColor isKindOfClass:[NSDictionary class]]){
                    [cell setGradientBackgroundWithColors:self->_itemNormalColor[@"colors"] locations:self->_itemNormalColor[@"locations"] startPoint:CGPointZero endPoint:CGPointMake(1, 1)];
                }
            }
        }];
    }
    [cell.iconImgView setHidden:YES];
    [cell setSelected:(self.selectedIndex == index)?YES:NO];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] animated:YES];
    
    self.selectedIndex = indexPath.item;
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell) {
        HPSliderTagItemModel *tag = self.capacityItems[indexPath.item];
        CGSize selSize = !tag.tagTitle.length?CGSizeZero:[self sizeForTitle:tag.tagTitle withFont:tag.selectedTitleFont];
        CGSize tagSize =   CGSizeEqualToSize(CGSizeZero, self.tagItemSize)?selSize:self.tagItemSize;
        if (self.selectedIndicatorSize.width<=0) {
             self.selectionIndicator.width = tagSize.width;
        }
    }
    [collectionView reloadData];
    [UIView animateWithDuration:0.3f animations:^{
        //        self.selectionIndicator.width =  (CGRectGetMidX(cell.frame)>self.selectionIndicator.x)?(CGRectGetMaxX(cell.frame) - self.selectionIndicator.x):(self.selectionIndicator.x-(CGRectGetMidX(cell.frame)));
        
        self.selectionIndicator.centerX = cell.centerX;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            //            self.selectionIndicator.centerX = cell.centerX;
            //            self.selectionIndicator.width = 20;
        }];
    }];
    if ([self.delegate respondsToSelector:@selector(banner:didSelectItemAtIndex:)]  ) {
        [self.delegate banner:self didSelectItemAtIndex:indexPath.item];
    }
    //    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}
-(void)selectItemAtIndex:(NSInteger)index{
    self.selectedIndex = index;
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self.collectionView reloadData];
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.item;
    HPSliderTagItemModel *tagTitleModel = self.capacityItems[index];
    
    NSString *title = tagTitleModel.tagTitle;
    CGSize titleSize = !title?CGSizeZero:[self sizeForTitle:title withFont:((tagTitleModel.normalTitleFont.pointSize >= tagTitleModel.selectedTitleFont.pointSize)?tagTitleModel.normalTitleFont:tagTitleModel.selectedTitleFont)];
    //如果用户没有手动设置tagItemSize
    return CGSizeEqualToSize(CGSizeZero, self.tagItemSize)?CGSizeMake(titleSize.width, CGRectGetHeight(self.frame)):self.tagItemSize;
} 
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.minimumLineSpacing>0?self.minimumLineSpacing:3.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.minimumInteritemSpacing>0?self.minimumInteritemSpacing:3.0f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}





#pragma - mark UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UICollectionView *)scrollView{
    //    self.selectionIndicator.centerX = self.currentSelCell.centerX;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //     + scrollView.contentOffset.x;
}
- (CGSize)sizeForTitle:(NSString *)title withFont:(UIFont *)font
{
    if (!font) {
        return CGSizeZero;
    }
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil];
    
    return CGSizeMake(titleRect.size.width,
                      titleRect.size.height);
}
@end
