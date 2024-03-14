//
//  HPEmptyPlaceholder.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import "HPEmptyPlaceholder.h"
 

//#import "HPViewUtilities.h"


#import <objc/runtime.h>
#import "Masonry.h"


@interface UIView ()

@property (nonatomic,copy) void(^reloadAction)(void);

@end

@implementation UIView (HPEmptyView)

- (void)setReloadAction:(void (^)(void))reloadAction{
    objc_setAssociatedObject(self, @selector(reloadAction), reloadAction, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))reloadAction{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setEmptyImg:(NSString *)emptyImg{
    
}

//HPErrorPageView
- (void)setErrorPageView:(HPErrorPageView *)errorPageView{
    [self willChangeValueForKey:NSStringFromSelector(@selector(errorPageView))];
    objc_setAssociatedObject(self, @selector(errorPageView), errorPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(errorPageView))];
}

- (HPErrorPageView *)errorPageView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)configReloadAction:(HPEmptyHandler)block{
    self.reloadAction = block;
    if (self.errorPageView && self.reloadAction) {
        self.errorPageView.didClickReloadBlock = self.reloadAction;
    }
}

- (void)showErrorPageViewWithType:(HPEmptyType)emptyType{
    if (!self.errorPageView) {
        self.errorPageView = [[HPErrorPageView alloc]initWithFrame:self.bounds];
        if (self.reloadAction) {
            self.errorPageView.didClickReloadBlock = self.reloadAction;
        }
    }
    self.errorPageView.backgroundColor = [UIColor clearColor];
    if (emptyType == HPEmpty_DefaultType) {
        self.errorPageView.errorImageView.image = [UIImage imageNamed:@"pic_nocontent"];
        self.errorPageView.errorTipLabel.text = @"空空如也，啥也没有";
        self.errorPageView.errorFootLabel.hidden = YES;
        self.errorPageView.reloadButton.hidden = YES;
    }else if (emptyType == HPEmpty_ErrorNetWorkType){
        self.errorPageView.errorImageView.image = [UIImage imageNamed:@"pic_nonet"];
        self.errorPageView.errorTipLabel.text = @"网络异常，请检测网络设置";
        self.errorPageView.errorFootLabel.hidden = YES;
        self.errorPageView.reloadButton.hidden = YES;
    }
    
    
    [self addSubview:self.errorPageView];
    [self bringSubviewToFront:self.errorPageView];
}

- (void)hideErrorPageView{
    if (self.errorPageView) {
        [self.errorPageView removeFromSuperview];
        self.errorPageView = nil;
    }
}

//OSCLoadingView
- (void)setLoadingView:(HPLoadingView *)loadingView{
    [self willChangeValueForKey:NSStringFromSelector(@selector(loadingView))];
    objc_setAssociatedObject(self, @selector(loadingView), loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(loadingView))];
}

- (HPLoadingView *)loadingView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)showLoadingView{
    if (!self.loadingView) {
        self.loadingView = [[HPLoadingView alloc]initWithFrame:self.bounds];
    }
    [self.loadingView.indicatorView startAnimating];
    [self addSubview:self.loadingView];
    [self bringSubviewToFront:self.loadingView];
}

- (void)hideLoadingView{
    if (self.loadingView) {
        [self.loadingView.indicatorView stopAnimating];
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }
}

@end

#pragma mark - HPErrorPageView

@interface HPErrorPageView ()

@end

@implementation HPErrorPageView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView* errorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nilNetWork"]];
        _errorImageView = errorImageView;
        [self addSubview:_errorImageView];
        
        UILabel* errorTipLabel = [[UILabel alloc]init];
        errorTipLabel.numberOfLines = 1;
        errorTipLabel.font = [UIFont systemFontOfSize:16];
        errorTipLabel.textAlignment = NSTextAlignmentCenter;
        errorTipLabel.textColor = [UIColor darkGrayColor];
        errorTipLabel.text = @"您的网络好像有点问题哦";
        _errorTipLabel = errorTipLabel;
        [self addSubview:_errorTipLabel];
        
        UILabel* errorFootLabel = [[UILabel alloc]init];
        errorFootLabel.numberOfLines = 1;
        errorFootLabel.font = [UIFont systemFontOfSize:18];
        errorFootLabel.textAlignment = NSTextAlignmentCenter;
        errorFootLabel.textColor = [UIColor darkGrayColor];
        errorFootLabel.text = @"您的网络好像有点问题哦";
        _errorFootLabel = errorFootLabel;
        [self addSubview:_errorFootLabel];
        
        UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        reloadButton.layer.masksToBounds = YES;
        reloadButton.layer.cornerRadius = 20;
        //        [reloadButton setTitle:@"  点击刷新" forState:UIControlStateNormal];
        reloadButton.titleLabel.font =[UIFont systemFontOfSize:15];
        [reloadButton setImage:[UIImage imageNamed:@"refresh_white" ] forState:UIControlStateNormal];
        reloadButton.backgroundColor = [UIColor lightGrayColor];
        [reloadButton addTarget:self action:@selector(_clickReloadButton:) forControlEvents:UIControlEventTouchUpInside];
        _reloadButton = reloadButton;
        [self addSubview:_reloadButton];
        
        [_errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_centerY).offset(-100);
        }];
        
        [_errorTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@20);
            make.top.equalTo(_errorImageView.mas_bottom).offset(15);
        }];
        [_errorFootLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@25);
            make.top.equalTo(_errorTipLabel.mas_bottom).offset(10);
        }];
        
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-60);
            make.height.mas_equalTo(40);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-130);
        }];
    }
    return self;
}

- (void)_clickReloadButton:(UIButton* )btn{
    if (_didClickReloadBlock) {
        _didClickReloadBlock();
    }
}

- (void)showNoNewWorkView{
    if (!self.noNetWorkView) {
        self.noNetWorkView = [[HPErrorPageView alloc]initWithFrame:self.bounds];
    }
    [self addSubview:self.noNetWorkView];
    [self bringSubviewToFront:self.noNetWorkView];
}

- (void)hideNoNetWorkView{
    if (self.noNetWorkView) {
        [self.noNetWorkView removeFromSuperview];
        self.noNetWorkView = nil;
    }
}

@end


#pragma mark - HPLoadingView
#import "UIImage+GIF.h"

#define _Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define _Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface HPLoadingView ()
@end

@implementation HPLoadingView
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[UIView defaultImageNameForScene:HPDefaultImage_Placeholder_Data_Empty] ofType:@"gif"];
        BOOL isExsit = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (isExsit) {
            //存在gif图片
            UIImageView *gifImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
            //            gifImage.image =//            = [UIImage sd_animatedGIFNamed:LoadingGifImageName];
             
            gifImage.image =[UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfFile:path]];
            gifImage.center = CGPointMake(_Main_Screen_Width/2, _Main_Screen_Height/2);
            [self addSubview:gifImage];
        }else{
            //不存在gif，加载菊花
            UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] init];
            indicatorView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-30)*0.5, ([UIScreen mainScreen].bounds.size.height-30)*0.5-60, 30, 30);
            indicatorView.color = [UIColor blackColor];
            _indicatorView = indicatorView;
            [self addSubview:indicatorView];
        }
    }
    return self;
}

@end
