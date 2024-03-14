//
//  DemoCollectionViewController.m
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/18.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "DemoCollectionViewController.h"
#import "CollectionViewItemViewController.h"

 
#import "UINavigationController+HPTransitionAnimation.h"
#import "UIViewController+HPTransitionAnimation.h"

@interface DemoCollectionViewController () <

    UICollectionViewDataSource,
    UICollectionViewDelegate,

    UINavigationControllerDelegate
>

@end

@implementation DemoCollectionViewController {

    UICollectionView *_collectionView;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100, 150);
    
    CGRect frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 100);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collectionView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self; 
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.navigationController.delegate = nil;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((arc4random() % 255) / 255.0)
                                           green:((arc4random() % 255) / 255.0)
                                            blue:((arc4random() % 255) / 255.0)
                                           alpha:1.0f];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
    [cell.contentView addSubview:imageView];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long)indexPath.item]];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewItemViewController *itemVC = [[CollectionViewItemViewController alloc] init];
    itemVC.navigationItem.title = @"CollectionViewItemViewController";
    itemVC.imageIndex = indexPath.item;
    itemVC.animationType = self.animationType;
//    self.navigationController.delegate = self;
    
    
    
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];

    CGPoint p = [_collectionView convertPoint:cell.center toView:self.view];
    CGSize s = cell.frame.size;
    
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
////    CGPoint p = CGPointMake(100, 220);
////    CGSize s = CGSizeMake(30, 60);
////    CGPoint p = [_collectionView convertPoint:cell.center toView:self.view];
//    NSValue *centerPointValue = [NSValue valueWithBytes:&p objCType:@encode(CGPoint)];
//    NSValue *itemSizeValue = [NSValue valueWithBytes:&s objCType:@encode(CGSize)];
//    NSString *itemImageName = [NSString stringWithFormat:@"%ld", indexPath.item];
//
//    dict[@"itemCenter"] = centerPointValue;
//    dict[@"itemSize"] = itemSizeValue;
//    dict[@"itemImageName"] = itemImageName;
    HPBaseTransitionAnimatorParams *params = [[HPBaseTransitionAnimatorParams alloc]init];
    params.itemCenter = p;
    params.itemSize = s;
    params.itemImageName = [NSString stringWithFormat:@"%ld", indexPath.item];
    params.startPosition = self.startPosition;
    itemVC.params = params;
    if (self.isModal==0) {
        [self.navigationController pushViewController:itemVC animationOptions:self.animationType params:params];
    }else{
        [self presentViewController:itemVC animationOption:self.animationType params:params completion:^{
        NSLog(@"presenting");
        }];
    }
  
   
}

 


@end
