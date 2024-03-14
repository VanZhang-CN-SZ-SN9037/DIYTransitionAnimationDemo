//
//  HPCollectionViewController.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//

#import "HPCollectionViewController.h"
 
#import "Masonry.h"
@interface HPCollectionViewController ()

@end

@implementation HPCollectionViewController

-(HPCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView =  [[HPCollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI{
    __weak typeof(self)  weakSelf = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(@(-35));
    }];
    [self.collectionView reloadData];
}
- (void)bindViewModel{
    
}
- (void)setupNoticeMonitors{
    
}
- (void)dataSouece:(void(^)(HPCollectionView *collectionView,HPDataSource*datasource))datasourceHandlerBlock delegate:(void(^)(HPCollectionView *collectionView,HPDelegate*delegate))delegateHandlerBlock{
    !datasourceHandlerBlock?:datasourceHandlerBlock(self.collectionView,self.collectionView.ns_dataSource);
    !delegateHandlerBlock?:delegateHandlerBlock(self.collectionView,self.collectionView.ns_delegate);
}

@end
