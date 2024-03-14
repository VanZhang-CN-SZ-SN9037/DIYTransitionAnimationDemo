//
//  HPBubble.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/7.
//

#import "HPBubble.h"
 
#define kBubbleWidth 48

#define kOffSet kBubbleWidth / 2

#define kNormalColor [UIColor redColor]

@interface HPBubble ()<UIDynamicAnimatorDelegate>
  
@property (nonatomic , strong ) UIDynamicAnimator *animator;//物理仿真动画

@property (nonatomic , assign ) CGPoint startPoint;//触摸起始点

@property (nonatomic , assign ) CGPoint endPoint;//触摸结束点

@end


@interface HPBubble ()
 
  

@property (nonatomic , strong ) UIImage *image;

@property (nonatomic , strong ) UIImageView *imageView;//图片视图

@property (nonatomic , strong ) UIView * imageBackgroundView;//图片背景视图

@property (nonatomic , strong ) UIView *backgroundView;//背景视图

@property (nonatomic , copy ) void(^clickBubbleBlock)(void);

@end


@interface HPBubble ()
  
@property (nonatomic , strong ) UIView * customView;//图片背景视图
 
 
@end

@implementation HPBubble

- (UIView*)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectZero];
        _backgroundView.clipsToBounds = YES;
        _backgroundView.backgroundColor = [kNormalColor colorWithAlphaComponent:0.7f] ;
        _backgroundView.userInteractionEnabled = NO;
    }
    return _backgroundView;
}
- (UIView*)imageBackgroundView{
    if (!_imageBackgroundView) {
        _imageBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
        _imageBackgroundView.clipsToBounds = YES;
        _imageBackgroundView.backgroundColor = kNormalColor ;
        _imageBackgroundView.userInteractionEnabled = NO;
    }
    return _imageBackgroundView;
}
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
#pragma mark - 初始化

+ (instancetype)circleBubbleWithCenter:(CGPoint)point bubbleImg:(UIImage *)image clickCallBack:(void (^)(void))clickHandlerBlock{
    CGRect rect = CGRectMake(0, 0, kBubbleWidth, kBubbleWidth);
    HPBubble *bubble = [HPBubble bubbleWithStyle:HP_Bubble_Style_Circle_WithShadowLine frame:rect bubbleImg:image clickCallBack:clickHandlerBlock];
    bubble.center = point;
    return bubble;
}

+ (instancetype)bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect custtomView:(UIView*)view clickCallBack:(void(^)(void))clickHandlerBlock{
    HPBubble *bubble =  [[HPBubble alloc] initWithFrame:rect];
    bubble.customView = view;
    bubble.clickBubbleBlock = [clickHandlerBlock copy];
    [bubble setupWithStyle:style];
    return bubble;;
}

+ (instancetype)bubbleWithStyle:(HPBubbleStyle)style frame:(CGRect)rect bubbleImg:(UIImage*)image clickCallBack:(void(^)(void))clickHandlerBlock{
    HPBubble *bubble =  [[HPBubble alloc] initWithFrame:rect];
    [bubble setupWithStyle:style];
    [bubble setImage:image];
    bubble.clickBubbleBlock = [clickHandlerBlock copy];
    return bubble;
}
-(void)setAutoAnimation:(BOOL)autoAnimation{
    _autoAnimation = autoAnimation;
}
- (void)setupWithStyle:(HPBubbleStyle)style{
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    CGFloat contentInset = 0;
    CGFloat cornerRadius = 5.0f;
    _autoAnimation = YES;
    UIColor *bgColor = kNormalColor;
    switch (style) {
        case HP_Bubble_Style_Circle:{
            rect.size = CGSizeMake(kBubbleWidth, kBubbleWidth);
            contentInset = 0;
            cornerRadius = kOffSet;
        }break;
        case HP_Bubble_Style_Rectangle:{
            contentInset = 0;
        }break;
        case HP_Bubble_Style_Customization:{
            contentInset = 0;
            bgColor = [UIColor clearColor];
        }break;
        case HP_Bubble_Style_Circle_WithShadowLine:{
            contentInset = 5;
            rect.size = CGSizeMake(kBubbleWidth, kBubbleWidth);
            cornerRadius = kOffSet;
        }break;
        case HP_Bubble_Style_Rectangle_WithShadowLine:{
            contentInset = 5;
        }break;
        case HP_Bubble_Style_Customization_WithShadowLine:{
            contentInset = 5;
            bgColor = [UIColor clearColor];
        }break;
        default:
            break;
    }
    

    //初始化背景视图
    [self.backgroundView setFrame:rect];
    [self.backgroundView setBackgroundColor:[bgColor colorWithAlphaComponent:0.7]];
    self.backgroundView.layer.cornerRadius = cornerRadius;
    self.backgroundView.layer.masksToBounds = YES;
    [self addSubview:self.backgroundView];
    
    
    
    if (style==HP_Bubble_Style_Customization) {
        [self.customView setFrame:self.backgroundView.bounds];
        [self.backgroundView addSubview:self.customView];
    }else if (style==HP_Bubble_Style_Customization_WithShadowLine) {
        [self.customView setFrame:CGRectMake(contentInset, contentInset, CGRectGetWidth(rect) - contentInset*2, CGRectGetHeight(rect) - contentInset*2)];
        [self.backgroundView addSubview:self.customView];
    }else{
        //初始化图片背景视图
        CGRect imgRect  = CGRectMake(contentInset, contentInset, CGRectGetWidth(rect) - contentInset*2, CGRectGetHeight(rect) - contentInset*2);
        [self.imageBackgroundView setFrame:imgRect];
        [self.imageBackgroundView setBackgroundColor:bgColor];
        [self.backgroundView addSubview:self.imageBackgroundView];
        
        if (style==HP_Bubble_Style_Circle||style==HP_Bubble_Style_Circle_WithShadowLine) {
            self.imageBackgroundView.layer.cornerRadius = (CGRectGetHeight(rect) - contentInset*2)/2;
            self.imageBackgroundView.layer.masksToBounds = YES;
        }
        
        //初始化图片
        self.imageView.frame = self.imageBackgroundView.bounds;
        
        [self.imageBackgroundView addSubview:self.imageView];
        
        //设置默认偏移
        
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (void)setColor:(UIColor *)color{
    
    _color = color;
    
    self.backgroundView.backgroundColor = [color colorWithAlphaComponent:0.7f];
    
    
    self.imageBackgroundView.backgroundColor = color;
}

- (void)setImage:(UIImage *)image{
    
    _image = image;
    
    self.imageView.image = image;
}

#pragma mark - 添加动画

- (void)addAnimations{
    
    //开启呼吸动画
    
    if (![_backgroundView.layer animationForKey:@"BreathingAnimation"]) {
        
        [_backgroundView.layer addAnimation:[self BreathingAnimation] forKey:@"BreathingAnimation"];
    }
    
    //添加气泡晃动效果
    
    [self AddAniamtionLikeGameCenterBubbleWithView:_backgroundView];
    
    [self AddAniamtionLikeGameCenterBubbleWithView:_imageBackgroundView];
    
    [self AddAniamtionLikeGameCenterBubbleWithView:_imageView];
}
- (void)endAnimator{
    
    
    // 移除之前的所有行为
    
    [self.animator removeAllBehaviors];
    self.animator = nil;
    
    //移除气泡晃动效果
    [self RemoveAniamtionLikeGameCenterBubbleWithView:_backgroundView];
    
    [self RemoveAniamtionLikeGameCenterBubbleWithView:_imageBackgroundView];
    
    [self RemoveAniamtionLikeGameCenterBubbleWithView:_imageView];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
    
    UITouch *startTouch = [touches anyObject];
    
    //返回触摸点坐标
    
    self.startPoint = [startTouch locationInView:self.superview];
    
    // 移除之前的所有行为
    if (!self.animator) {
      // 创建物理仿真器(ReferenceView : 仿真范围)
          
       self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
          
        //设置代理
          
        self.animator.delegate = self;
    }
    [self.animator removeAllBehaviors];
    
    
    //移除气泡晃动效果
    
    [self RemoveAniamtionLikeGameCenterBubbleWithView:_backgroundView];
    
    [self RemoveAniamtionLikeGameCenterBubbleWithView:_imageBackgroundView];
    
    [self RemoveAniamtionLikeGameCenterBubbleWithView:_imageView];
}

//触摸移动

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸点
    
    UITouch *startTouch = [touches anyObject];
    
    //将触摸点赋值给touchView的中心点 也就是根据触摸的位置实时修改view的位置
    
    self.center = [startTouch locationInView:self.superview];
}

//结束触摸

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //得到触摸结束点
    
    UITouch *endTouch = [touches anyObject];
    
    //返回触摸结束点
    
    self.endPoint = [endTouch locationInView:self.superview];
    
    //判断是否移动了视图 (误差范围5)
    
    CGFloat errorRange = 5;
    
    if (( self.endPoint.x - self.startPoint.x >= -errorRange && self.endPoint.x - self.startPoint.x <= errorRange ) && ( self.endPoint.y - self.startPoint.y >= -errorRange && self.endPoint.y - self.startPoint.y <= errorRange )) {
        
        //未移动
        
        //调用点击Block
        
        if (self.clickBubbleBlock) self.clickBubbleBlock();
    }
    
    self.center = self.endPoint;
    
    CGFloat margin = 10.0f;
    
    //计算距离最近的边缘 吸附到边缘停靠
    
    CGFloat superwidth = self.superview.bounds.size.width;
    
    CGFloat superheight = self.superview.bounds.size.height;
    
    CGFloat endX = self.endPoint.x;
    
    CGFloat endY = self.endPoint.y;
    
    CGFloat topRange = endY - _edgeInsets.top;//上距离
    
    CGFloat bottomRange = (superheight - _edgeInsets.bottom) - endY;//下距离
    
    CGFloat leftRange = endX - _edgeInsets.left;//左距离
    
    CGFloat rightRange = (superwidth - _edgeInsets.right) - endX;//右距离
    
    
    //比较上下左右距离 取出最小值
    
    CGFloat minRangeTB = topRange > bottomRange ? bottomRange : topRange;//获取上下最小距离
    
    CGFloat minRangeLR = leftRange > rightRange ? rightRange : leftRange;//获取左右最小距离
    
    CGFloat minRange = minRangeTB > minRangeLR ? minRangeLR : minRangeTB;//获取最小距离
    
    
    //判断最小距离属于上下左右哪个方向 并设置该方向边缘的point属性
    
    CGPoint minPoint;
    
    if (minRange == topRange) {
        
        //上
        
        endX = endX - kOffSet - margin < _edgeInsets.left ? kOffSet + margin + _edgeInsets.left : endX;
        
        endX = endX + kOffSet + margin > (superwidth - _edgeInsets.right) ? (superwidth - _edgeInsets.right) - kOffSet - margin : endX;
        
        minPoint = CGPointMake(endX , _edgeInsets.top + kOffSet + margin);
        
    } else if(minRange == bottomRange){
        
        //下
        
        endX = endX - kOffSet - margin < _edgeInsets.left ? kOffSet + margin + _edgeInsets.left : endX;
        
        endX = endX + kOffSet + margin > (superwidth - _edgeInsets.right) ? (superwidth - _edgeInsets.right) - kOffSet - margin : endX;
        
        minPoint = CGPointMake(endX , (superheight - _edgeInsets.bottom) - kOffSet - margin);
        
    } else if(minRange == leftRange){
        
        //左
        
        endY = endY - kOffSet - margin < _edgeInsets.top ? kOffSet + margin + _edgeInsets.top : endY;
        
        endY = endY + kOffSet + margin > (superheight - _edgeInsets.bottom) ? (superheight - _edgeInsets.bottom) - kOffSet - margin : endY;
        
        minPoint = CGPointMake(_edgeInsets.left + kOffSet + margin , endY);
        
    } else if(minRange == rightRange){
        
        //右
        
        endY = endY - kOffSet - margin < _edgeInsets.top ? kOffSet + margin + _edgeInsets.top : endY;
        
        endY = endY + kOffSet + margin > (superheight - _edgeInsets.bottom) ? (superheight - _edgeInsets.bottom) - kOffSet - margin : endY;
        
        minPoint = CGPointMake((superwidth - _edgeInsets.right) - kOffSet - margin , endY);
        
    } else{
        
        minPoint = CGPointZero;
    }
    //添加吸附物理行为
     UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
     
     [attachmentBehavior setLength:1.0f];
     
     [attachmentBehavior setDamping:0.2f];//阻尼
     
     [attachmentBehavior setFrequency:4.0f];//频率
     // 移除之前的所有行为
    if (!self.animator) {
      // 创建物理仿真器(ReferenceView : 仿真范围)
          
       self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
          
        //设置代理
          
        self.animator.delegate = self;
    }
     [self.animator addBehavior:attachmentBehavior];
   
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    
    
}

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator{
    
    //添加气泡晃动效果
    
   if (self.autoAnimation) {
       [self AddAniamtionLikeGameCenterBubbleWithView:_backgroundView];
       
       [self AddAniamtionLikeGameCenterBubbleWithView:_imageBackgroundView];
       
       [self AddAniamtionLikeGameCenterBubbleWithView:_imageView];
   }
}

#pragma mark - LazyLoading

//- (UIDynamicAnimator *)animator{
//
//    if (!_animator) {
//
//        // 创建物理仿真器(ReferenceView : 仿真范围)
//
//        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
//
//        //设置代理
//
//        _animator.delegate = self;
//    }
//
//    return _animator;
//}

#pragma mark - BreathingAnimation 呼吸动画

- (CABasicAnimation *)BreathingAnimation{
    
    CABasicAnimation* basicAnimation;
    
    basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    basicAnimation.toValue = [NSNumber numberWithFloat: 0.8f ];
    
    basicAnimation.fromValue = [NSNumber numberWithFloat:0.2f ];
    
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    basicAnimation.duration = 1.2f;
    
    basicAnimation.repeatCount = HUGE;//设置到最大的整数值
    
    basicAnimation.cumulative = NO;
    
    basicAnimation.autoreverses = YES;//重复播放
    
    basicAnimation.removedOnCompletion = NO;
    
    basicAnimation.fillMode = kCAFillModeForwards;
    
    return basicAnimation;
}

#pragma mark - 添加类似GameCenter的气泡晃动动画

- (void)AddAniamtionLikeGameCenterBubbleWithView:(UIView *)animationView{
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = INFINITY;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0;
    
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(animationView.frame, animationView.bounds.size.width / 2 - 3, animationView.bounds.size.width / 2 - 3);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.duration = 1;
    scaleX.values = @[@1.0, @1.1, @1.0];
    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
    scaleX.repeatCount = INFINITY;
    scaleX.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.duration = 1.5;
    scaleY.values = @[@1.0, @1.1, @1.0];
    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
    scaleY.repeatCount = INFINITY;
    scaleY.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    //添加动画
    
    if (![animationView.layer animationForKey:@"circleAnimation"]) {
        
        [animationView.layer addAnimation:pathAnimation forKey:@"circleAnimation"];
    }
    
    if (![animationView.layer animationForKey:@"scaleXAnimation"]) {
        
        [animationView.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    }
    
    if (![animationView.layer animationForKey:@"scaleYAnimation"]) {
        
        [animationView.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
    }
    
}

#pragma mark - 移除类似GameCenter的气泡晃动动画

- (void)RemoveAniamtionLikeGameCenterBubbleWithView:(UIView *)animationView{
    
    [animationView.layer removeAnimationForKey:@"circleAnimation"];
    
    [animationView.layer removeAnimationForKey:@"scaleXAnimation"];
    
    [animationView.layer removeAnimationForKey:@"scaleYAnimation"];
}

- (void)dealloc{
    
    _backgroundView = nil;
    
    _imageBackgroundView = nil;
    
    _imageView = nil;
    
    _animator = nil;
}

@end
