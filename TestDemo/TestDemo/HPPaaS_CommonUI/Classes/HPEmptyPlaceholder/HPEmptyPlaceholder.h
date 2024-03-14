//
//  HPEmptyPlaceholder.h
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import <UIKit/UIKit.h>
  
@class HPErrorPageView , HPLoadingView;

typedef enum {
    HPEmpty_DefaultType = 0,
    HPEmpty_ErrorNetWorkType = 1
} HPEmptyType;

typedef void(^HPEmptyHandler)(void);

@interface UIView (HPEmptyView)

//HPErrorPageView
@property(nonatomic,strong) HPErrorPageView * errorPageView;
- (void)configReloadAction:(HPEmptyHandler)block;
- (void)showErrorPageViewWithType:(HPEmptyType)emptyType;
- (void)hideErrorPageView;

//HPLoadingView
@property(nonatomic,strong) HPLoadingView * loadingView;
- (void)showLoadingView;
- (void)hideLoadingView;

@end

#pragma mark - HPErrorPageView

@interface HPErrorPageView : UIView

@property (nonatomic,weak) UIImageView* errorImageView;
@property (nonatomic,weak) UILabel* errorTipLabel;
@property (nonatomic,weak) UILabel* errorFootLabel;
@property (nonatomic,weak) UIButton* reloadButton;
@property (nonatomic,copy) HPEmptyHandler didClickReloadBlock;

//HPErrorPageView
@property (nonatomic,strong) HPErrorPageView * noNetWorkView;

- (void)showNoNewWorkView;
- (void)hideNoNetWorkView;



@end

#pragma mark - HPLoadingView

@interface HPLoadingView : UIView

@property (nonatomic ,strong) UIActivityIndicatorView * indicatorView;
@property (nonatomic,weak) UIImageView* nodataImageView;
@property (nonatomic,weak) UILabel* nodataTipLabel;

@end
