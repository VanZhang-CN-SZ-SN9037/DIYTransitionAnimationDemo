//
//  HPCommonUIFactory.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import "HPCommonUIFactory.h"
typedef void(^CallTbDataSourceSettingHandler)(HPTableView *tableView,HPDataSource*datasource);
typedef void(^CallTbDelegateSettingHandler)(HPTableView *tableView,HPDelegate*delegate);


//typedef void(^CallColDataSourceSettingHandler)(HPCollectionView *collectionView,HPDataSource*datasource);
//typedef void(^CallColDelegateSettingHandler)(HPCollectionView *collectionView,HPDelegate*delegate);

@interface HPCommonUIFactory ()
//Desc:
//@property (strong, nonatomic) HPCollectionView *collectionView;
@end
@implementation HPCommonUIFactory
+ (HPTableView*)tableViewWithSuperView:(UIView*)superView datasource:(CallTbDataSourceSettingHandler)datasourceHandlerBlock delegate:(CallTbDelegateSettingHandler)delegateHandlerBlock{
    HPTableView *tableView =  [[HPTableView alloc]initWithFrame:superView.bounds style:UITableViewStyleGrouped];
    [superView addSubview:tableView];
    !datasourceHandlerBlock?:datasourceHandlerBlock(tableView,tableView.ns_dataSource);
    !delegateHandlerBlock?:delegateHandlerBlock(tableView,tableView.ns_delegate); 
    return  tableView;
}
+ (void)tableView:(HPTableView*)tableView datasource:(CallTbDataSourceSettingHandler)datasourceHandlerBlock delegate:(CallTbDelegateSettingHandler)delegateHandlerBlock{
    !datasourceHandlerBlock?:datasourceHandlerBlock(tableView,tableView.ns_dataSource);
    !delegateHandlerBlock?:delegateHandlerBlock(tableView,tableView.ns_delegate);
}


//+ (HPCollectionView*)collectionViewWithSuperView:(UIView*)superView collectionViewLayout:(UICollectionViewLayout*)layout datasource:(CallColDataSourceSettingHandler)datasourceHandlerBlock delegate:(CallColDelegateSettingHandler)delegateHandlerBlock{
//    HPCollectionView *collectionView =  [[HPCollectionView alloc]initWithFrame:superView.bounds collectionViewLayout:layout];
//    [superView addSubview:collectionView];
//    !datasourceHandlerBlock?:datasourceHandlerBlock(collectionView,collectionView.ns_dataSource);
//    !delegateHandlerBlock?:delegateHandlerBlock(collectionView,collectionView.ns_delegate);
//    return  collectionView;
//}
//
//+ (void)collectionView:(HPCollectionView*)collectionView datasource:(CallColDataSourceSettingHandler)datasourceHandlerBlock delegate:(CallColDelegateSettingHandler)delegateHandlerBlock{
//    !datasourceHandlerBlock?:datasourceHandlerBlock(collectionView,collectionView.ns_dataSource);
//    !delegateHandlerBlock?:delegateHandlerBlock(collectionView,collectionView.ns_delegate);
//}
  
// 设置手势
//+ (void)configItemMoveWithCollectionView:(HPCollectionView*)collectionView{
//    [HPCommonUIFactory sharedInstance].collectionView = collectionView;
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:[HPCommonUIFactory sharedInstance] action:@selector(handlelongGesture:)];
//
//    [[HPCommonUIFactory sharedInstance].collectionView addGestureRecognizer:longPress];
//}
//- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
//     
//    //判断手势状态
//    switch (longGesture.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            //判断手势落点位置是否在路径上
//            NSIndexPath *indexPath = [[HPCommonUIFactory sharedInstance].collectionView indexPathForItemAtPoint:[longGesture locationInView:[HPCommonUIFactory sharedInstance].collectionView]];
//            if (indexPath == nil) {
//                break;
//            }
//            //在路径上则开始移动该路径上的cell
//            [[HPCommonUIFactory sharedInstance].collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//            //移动过程当中随时更新cell位置
//            [[HPCommonUIFactory sharedInstance].collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:[HPCommonUIFactory sharedInstance].collectionView]];
//            break;
//        case UIGestureRecognizerStateEnded:
//            //移动结束后关闭cell移动
//            [[HPCommonUIFactory sharedInstance].collectionView endInteractiveMovement];
//            break;
//        default:
//            [[HPCommonUIFactory sharedInstance].collectionView cancelInteractiveMovement];
//            break;
//    }
//}
//+ (HPMenuOperation*)menuWithItemTitles:(NSArray<NSString*>*)titles itemActionHandler:(NSArray<CommonMenuItemHandler>*)actions{
//    return [HPCommonUIFactory menuWithItemTitles:titles itemImages:nil itemActionHandler:actions];
//}
//+ (HPMenuOperation*)menuWithItemImages:(NSArray<UIImage*>*)imgs itemActionHandler:(NSArray<CommonMenuItemHandler>*)actions{
//    return [HPCommonUIFactory menuWithItemTitles:nil itemImages:imgs itemActionHandler:actions];
//}
//+ (HPMenuOperation*)menuWithItemTitles:(NSArray<NSString*>*)titles itemImages:(NSArray<UIImage*>*)imgs itemActionHandler:(NSArray<CommonMenuItemHandler>*)actions{
//    NSMutableArray *menuItems = [[NSMutableArray alloc] init];
//    if (titles.count==actions.count) {
//        for (int i = 0; i<titles.count; i++) {
//            HPMenuItem*itm = [HPMenuItem itemWithImage:!imgs?nil:imgs[i]
//                                                 title:!titles?@"":titles[i]
//                                                action:!actions?NULL:actions[i]];
//            [menuItems addObject:itm];
//        }
//    }
//     
//    HPMenuOperation *menu = [[HPMenuOperation alloc] initWithItems:menuItems];
//    menu.minMenuItemHeight = 45;
//    menu.menuCornerRadiu = 3;
//    menu.showShadow = YES;
//    menu.menuBackGroundColor = [UIColor whiteColor];
//    menu.segmenteLineColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//    menu.menuBackgroundStyle = HPMenuBackgroundStyleLight;
//    menu.menuSegmenteLineStyle = HPMenuSegmenteLineStylefollowContent;
//    return menu;
//}
//+ (void)showNavigationMenu:(HPMenuOperation*)menu withMenuBarPoisition:(HPMenuBarPosition)position{
//    CGRect rect = CGRectZero;
//     
//    switch (position) {
//        case HPMenuBarPosition_Left:{
//            rect = CGRectMake(10, 0, 60, 100);
//        }break;
//        case HPMenuBarPosition_Center:{
//            rect = CGRectMake(([UIScreen mainScreen].bounds.size.width-60)/2.0, 0, 60, 100);
//        }break;
//        case HPMenuBarPosition_Right:{
//            rect = CGRectMake([UIScreen mainScreen].bounds.size.width-70, 0, 60, 100);
//        }break;
//        default:
//            break;
//    }
//    [menu showFromRect:rect inView:[UIApplication sharedApplication].keyWindow];
//}
//+ (void)showTabBarMenu:(HPMenuOperation*)menu withMenuBarPoisition:(HPMenuBarPosition)position{
//    CGRect rect = CGRectZero;
//    switch (position) {
//        case HPMenuBarPosition_Left:{
//            rect = CGRectMake(10, [UIScreen mainScreen].bounds.size.height-85, 60, 100);
//        }break;
//        case HPMenuBarPosition_Center:{
//            rect = CGRectMake(([UIScreen mainScreen].bounds.size.width-60)/2.0, [UIScreen mainScreen].bounds.size.height-85, 60, 100);
//        }break;
//        case HPMenuBarPosition_Right:{
//            rect = CGRectMake([UIScreen mainScreen].bounds.size.width-70, [UIScreen mainScreen].bounds.size.height-85, 60, 100);
//        }break;
//        default:
//            break;
//    }
//    [menu showFromRect:rect inView:[UIApplication sharedApplication].keyWindow];
//}
////UILabel
//+ (UILabel*)labelWithText:(NSString*)text{
//    return [self labelWithText:text textColor:[UIColor blackColor]];
//}
//+ (UILabel*)labelWithText:(NSString*)text textColor:(UIColor*)textColor{
//    return [self labelWithText:text textColor:textColor textAlignment:NSTextAlignmentLeft];
//}
//+ (UILabel*)centerLabelWithText:(NSString*)text textColor:(UIColor*)textColor{
//    return [self labelWithText:text textColor:textColor textAlignment:NSTextAlignmentLeft];
//}
//+ (UILabel*)labelWithText:(NSString*)text textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)alignment{
//    // 1.1 创建UILabel对象
//    UILabel *label = [[UILabel alloc] init];
//    // 1.2 设置frame
//    label.frame = CGRectZero;
//    // 1.3 设置背景颜色
//    label.backgroundColor = [UIColor whiteColor];
//    label.textColor = textColor;
//    // 1.4 设置文字
//    label.text = text;
//    // 1.5 居中
//    label.textAlignment = alignment;
//    // 1.6 设置字体大小
//    label.font = [UIFont systemFontOfSize:15.f];
////    label.font = [UIFont boldSystemFontOfSize:25.f];
////    label.font = [UIFont italicSystemFontOfSize:20.f];
//    // 1.7 设置文字的颜色
//    label.textColor = [UIColor blackColor];
//    // 1.8 设置阴影(默认是有值)
////    label.shadowColor = [UIColor blackColor];
////    label.shadowOffset = CGSizeMake(-2, 1);
//    // 1.9 设置行数(0:自动换行)
//    label.numberOfLines = 0;
//    // 1.10 显示模式
//    label.lineBreakMode =  NSLineBreakByTruncatingHead;
//    /*
//     NSLineBreakByWordWrapping = 0,  // 单词包裹,换行的时候会以一个单词换行
//     NSLineBreakByCharWrapping,        // 字符包裹换行,换行的时候会以一个字符换行
//     NSLineBreakByClipping,        // 裁剪超出的内容
//     NSLineBreakByTruncatingHead,    // 一行中头部省略(注意:numberOfLines要为1): "...wxyz"
//     NSLineBreakByTruncatingTail,    // 一行中尾部省略: "abcd..."
//     NSLineBreakByTruncatingMiddle    // 一行中中间部省略:  "ab...yz"
//     */
//    return label;
//}
////
//+ (UIImageView*)imageViewWithImageNamed:(NSString*)imageNamed{
//    return [self imageViewWithImageNamed:imageNamed contentMode:UIViewContentModeCenter];
//}
//
//+ (UIImageView*)imageViewWithImageNamed:(NSString*)imageNamed contentMode:(UIViewContentMode)contentMode{
//    // 1.创建UIImageView对象
//    UIImageView *imageView = [[UIImageView alloc] init];
//    
//    // 2. 设置尺寸
////    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
////    imageView.frame = self.view.bounds;
//    
//    // 3. 设置背景颜色
//    imageView.backgroundColor = [UIColor redColor];
//    
//    // 4. 设置背景图片
//    imageView.image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    // 5.设置图片的内容模式
//    imageView.contentMode = contentMode;
//    return imageView;
//}
//+ (UIImageView*)blurImageViewWithImageNamed:(NSString*)imageNamed{
//    // 1.创建UIImageView对象
//    UIImageView *imageView = [[UIImageView alloc] init];
//    
//    // 2. 设置尺寸
////    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
////    imageView.frame = self.view.bounds;
//    
//    // 3. 设置背景颜色
//    imageView.backgroundColor = [UIColor redColor];
//    
//    // 4. 设置背景图片
//    imageView.image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    // 5.设置图片的内容模式
////    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    // 6.加毛玻璃
//    
//    // 6.1 创建UIToolBar对象
//    UIToolbar *toolBar = [[UIToolbar alloc] init];
//    // 6.2 设置toolBar的frame
//    toolBar.frame = imageView.bounds;
//    // 6.3 设置毛玻璃的样式
//    toolBar.barStyle = UIBarStyleBlack;
//    toolBar.alpha = 0.98;
//    // 6.4 加到imageView中
//    [imageView addSubview:toolBar];
//    return imageView;
//    
//}
//
//+ (void)imageView:(UIImageView*)imageView startAnimationWithImages:(NSArray<UIImage*>*)images{
//    [self imageView:imageView startAnimationWithImages:images animationDuration:1.0f];
//}
//+ (void)imageView:(UIImageView*)imageView startAnimationWithImages:(NSArray<UIImage*>*)images animationDuration:(CGFloat)duration{
//    // 设置动画图片
//    imageView.animationImages = images;
//    // 设置动画的播放次数
//    imageView.animationRepeatCount = 0;
//    // 设置播放时长
//    // 1秒30帧, 一张图片的时间 = 1/30 = 0.03333 20 * 0.0333
//    imageView.animationDuration = duration;
//    // 开始动画
//    [imageView startAnimating];
//}
///**
//   加载图片的方式:
//   1. imageNamed:
//   2. imageWithContentsOfFile:
// 
//   1. 加载Assets.xcassets这里面的图片:
//    1> 打包后变成Assets.car
//    2> 拿不到路径
//    3> 只能通过imageNamed:来加载图片
//    4> 不能通过imageWithContentsOfFile:来加载图片
// 
//   2. 放到项目中的图片:
//    1> 可以拿到路径
//    2> 能通过imageNamed:来加载图片
//    3> 也能通过imageWithContentsOfFile:来加载图片
// 
// */
//+ (UIImage*)imageWithNamed:(NSString*)imageNamed{
//    UIImage* image = [UIImage imageNamed:imageNamed];
//    if (!image) {
//        NSString *path  = [[NSBundle mainBundle]pathForResource:imageNamed ofType:@"png"];
//        image  = [UIImage imageWithContentsOfFile:path];
//    }
//    
//    if (!image) {
//        NSString *path  = [[NSBundle mainBundle]pathForResource:imageNamed ofType:@"jpg"];
//        image  = [UIImage imageWithContentsOfFile:path];
//    }
//    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//}
//
//+ (UIButton*)buttonWithTitle:(NSString*)title titleColor:(UIColor*)titleColor{
//    return [self buttonWithTitle:title titleColor:titleColor selectedTitle:title selectedTitleColor:titleColor];
//}
//+ (UIButton*)buttonWithTitle:(NSString*)title  titleColor:(UIColor*)titleColor selectedTitle:(NSString*)selectedTitle  selectedTitleColor:(UIColor*)selectedTitleColor{
//    return [self buttonWithTitle:title titleColor:titleColor selectedTitle:selectedTitle selectedTitleColor:selectedTitleColor
//                 backgroundImage:nil];
//}
//
//+ (UIButton*)buttonWithTitle:(NSString*)title  titleColor:(UIColor*)titleColor selectedTitle:(NSString*)selectedTitle  selectedTitleColor:(UIColor*)selectedTitleColor backgroundImage:(UIImage*)backgroundImage {
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitle:selectedTitle forState:UIControlStateSelected];
//    
//    // 1.6 设置文字的颜色
//    [button setTitleColor:titleColor forState:UIControlStateNormal];
//    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
//    
//    [button setBackgroundImage:[backgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [button setBackgroundImage:[backgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
//    
//    return button;
//}
//
//
//+ (UIButton*)buttonWithTitle:(NSString*)title  titleColor:(UIColor*)titleColor selectedTitle:(NSString*)selectedTitle  selectedTitleColor:(UIColor*)selectedTitleColor image:(UIImage*)image {
//    
//    UIButton *button = [[UIButton alloc] init];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitle:selectedTitle forState:UIControlStateSelected];
//    
//    // 1.6 设置文字的颜色
//    [button setTitleColor:titleColor forState:UIControlStateNormal];
//    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
//     
//    
//    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
//     
//    return button;
//}
//
//
//
//+ (HPBubble*)showCircleBubbleOnView:(UIView*)view bubbleCenter:(CGPoint)point bubbleImg:(UIImage *)image click:(CommonClickHandler)clockBlock{
//    if (!view||![view isKindOfClass:[UIView class]]) return nil;
//    HPBubble *bubble = [HPBubble circleBubbleWithCenter:point bubbleImg:image clickCallBack:clockBlock];
//    [view addSubview:bubble];
//    return bubble;
//}
//+ (HPBubble*)showBubbleOnView:(UIView*)view bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect bubbleImg:(UIImage*)image click:(CommonClickHandler)clockBlock{
//    if (!view||![view isKindOfClass:[UIView class]]) return nil;
//    if (CGRectEqualToRect(rect, CGRectZero)) return nil;
//    HPBubble *bubble = [HPBubble bubbleWithStyle:style frame:rect bubbleImg:image clickCallBack:clockBlock];
//    [view addSubview:bubble];
//    return bubble;
//}
//+ (HPBubble*)showBubbleOnView:(UIView*)view bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect custtomBubbleView:(UIView*)bubbleView click:(CommonClickHandler)clockBlock{
//    if (!view||![view isKindOfClass:[UIView class]]) return nil;
//    if (CGRectEqualToRect(rect, CGRectZero)) return nil;
//    HPBubble *bubble = [HPBubble bubbleWithStyle:style frame:rect custtomView:bubbleView clickCallBack:clockBlock];
//    [view addSubview:bubble];
//    return bubble;
//}




//===============SingleTon====================//
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}
- (id)mutableCopy{
    return _instance;
}
- (id)copy{
    return _instance;
}
+ (instancetype)sharedInstance{
    return [[self alloc]init];
}
//===================================//
@end
