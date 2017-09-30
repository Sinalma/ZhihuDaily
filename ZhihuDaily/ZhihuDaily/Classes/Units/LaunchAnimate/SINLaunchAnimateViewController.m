//
//  SINLaunchAnimateViewController.m
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINLaunchAnimateViewController.h"

static CGFloat SINDefaultAnimateDuration = 0.8;
static CGFloat SINDefaultWaitDuration = 3.0;

@interface SINLaunchAnimateViewController ()<CAAnimationDelegate>
@property (nonatomic,strong) SINLaunchSkipButton *skipBtn;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) CGFloat timePass;
@end

@implementation SINLaunchAnimateViewController

- (SINLaunchSkipButton *)skipBtn
{
    if (!_skipBtn) {
        _skipBtn = [[SINLaunchSkipButton alloc] initWitCustomType:_skipBtnType];
        CGRect skipBtnFrame = _skipBtn.bounds;
        skipBtnFrame.origin.x = self.view.frame.size.width - skipBtnFrame.size.width - 20;
        skipBtnFrame.origin.y = 40;
        self.skipBtn.frame = skipBtnFrame;
    }
    return _skipBtn;
}

- (void)setSkipBtnBgColor:(UIColor *)skipBtnBgColor
{
    self.skipBtn.bgColor = skipBtnBgColor;
}

- (void)setSkipBtnTxtColor:(UIColor *)skipBtnTxtColor
{
    self.skipBtn.txtColor = skipBtnTxtColor;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animateDuration = SINDefaultAnimateDuration;
        _waitDuration = SINDefaultWaitDuration;
    }
    return self;
}

- (instancetype)initWitContentView:(UIView *)contentView animateType:(SINLaunchAnimateType)animateType isShowSkipButton:(BOOL)isShowSkipButton skipBtnType:(SINLaunchSkipButtonType)skipBtnType
{
    self = [self init];
    if (self) {
        _contentView = contentView;
        _animateType = animateType;
        _isShowSkipButton = isShowSkipButton;
        _skipBtnType = skipBtnType;
    }
    return self;
}

#pragma mark - program enter
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self createTimer];
}

- (void)setupSubviews
{
    NSAssert(_contentView, @"SINLaunchAnimateViewController : Content view must not be nil.");
    _contentView.center = self.view.center;
    [self.view addSubview:_contentView];
    
    if (_isShowSkipButton) {
        self.skipBtn.remainSecond = _waitDuration;
        [self.view addSubview:self.skipBtn];
        [self.skipBtn addTarget:self action:@selector(dismissAtOnce) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)createTimer
{
    _timePass = 0.0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
    [timer fire];
}

- (void)countDown
{
    _timePass += 0.1;
    _skipBtn.remainSecond = _waitDuration-_timePass<0? 0:_waitDuration-_timePass;
    if (_waitDuration < _timePass) {
        [self.timer invalidate];
        self.timer = nil;
        [self dismiss];
    }
}

- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSAssert(keyWindow,@"SINLaunchAnimateViewController : Key window must be init.");
    [keyWindow addSubview:self.view];
    
}

- (void)dismissAtOnce
{
    [self.view removeFromSuperview];
    [self.timer invalidate];
    self.timer = nil;
    if (_complete) {
        self.complete();
    }
}

/**
 * According animate type hide launch page.
 */
- (void)dismiss
{
    switch (self.animateType){
        case SINLaunchAnimateTypeFade:{
            CABasicAnimation *animation = [CABasicAnimation animation];
            animation.delegate = self;
            [animation setDuration:_animateDuration];
            animation.keyPath = @"opacity";
            animation.toValue = @(0);
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.view.layer addAnimation:animation forKey:nil];
            break;
        }
        case SINLaunchAnimateTypeFadeAndZoomIn:{
            CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
            groupAnimation.delegate = self;
            [groupAnimation setDuration:_animateDuration];
            
            CABasicAnimation *fadeAnimation = [CABasicAnimation animation];
            fadeAnimation.keyPath = @"opacity";
            fadeAnimation.toValue = @(0);
            
            CABasicAnimation *zoomInAnimation = [CABasicAnimation animation];
            zoomInAnimation.keyPath = @"transform.scale";
            zoomInAnimation.toValue = @(2.0);
            
            groupAnimation.animations = @[fadeAnimation,zoomInAnimation];
            
            groupAnimation.removedOnCompletion = NO;
            groupAnimation.fillMode = kCAFillModeForwards;
            
            [self.view.layer addAnimation:groupAnimation forKey:nil];
            break;
        }
        case SINLaunchAnimateTypePointZoomOut1:{
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            [maskLayerAnimation setDuration:_animateDuration];
            maskLayerAnimation.delegate = self;
            
            UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *beginCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [beginPath appendPath:beginCirclePath];
            maskLayerAnimation.fromValue = (__bridge id)(beginPath.CGPath);
            
            UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *endCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [endPath appendPath:endCirclePath];
            maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
            
            maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            maskLayerAnimation.removedOnCompletion = NO;
            maskLayerAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:maskLayerAnimation forKey:nil];
            
            break;
        }
        case SINLaunchAnimateTypePointZoomOut2:{
            
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            [keyFrameAnimation setDuration:_animateDuration];
            keyFrameAnimation.delegate = self;
            
            UIBezierPath *pathOne = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathOneCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1.0 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathOne appendPath:pathOneCircle];
            
            UIBezierPath *pathTwo = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathTwoCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.7 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathTwo appendPath:pathTwoCircle];
            
            UIBezierPath *pathThree = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathThreeCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.5 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathThree appendPath:pathThreeCircle];
            
            UIBezierPath *pathFour = [UIBezierPath bezierPathWithRect:self.view.bounds];
            UIBezierPath *pathFourCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            [pathFour appendPath:pathFourCircle];
            
            keyFrameAnimation.values = @[(__bridge id)(pathOne.CGPath),(__bridge id)(pathTwo.CGPath),(__bridge id)(pathThree.CGPath),(__bridge id)(pathFour.CGPath)];
            keyFrameAnimation.keyTimes = @[@(0),@(0.3),@(0.6),@(1)];
            
            keyFrameAnimation.removedOnCompletion = NO;
            keyFrameAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:keyFrameAnimation forKey:nil];
            
            break;
        }
        case SINLaunchAnimateTypePointZoomIn1:{
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
            [keyFrameAnimation setDuration:_animateDuration];
            keyFrameAnimation.delegate = self;
            
            UIBezierPath *pathOne = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *pathTwo = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.5 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *pathThree = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:screenSize.width/2*0.7 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *pathFour = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            keyFrameAnimation.values = @[(__bridge id)(pathOne.CGPath),(__bridge id)(pathTwo.CGPath),(__bridge id)(pathThree.CGPath),(__bridge id)(pathFour.CGPath)];
            keyFrameAnimation.keyTimes = @[@(0),@(0.5),@(0.9),@(1)];
            
            keyFrameAnimation.removedOnCompletion = NO;
            keyFrameAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:keyFrameAnimation forKey:nil];
            
            break;
        }
        case SINLaunchAnimateTypePointZoomIn2:{
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            self.view.layer.mask = maskLayer;
            
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            
            CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            [maskLayerAnimation setDuration:_animateDuration];
            maskLayerAnimation.delegate = self;
            
            UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:hypot(screenSize.height, screenSize.width)/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
            
            maskLayerAnimation.fromValue = (__bridge id)(beginPath.CGPath);
            maskLayerAnimation.toValue = (__bridge id)(endPath.CGPath);
            
            maskLayerAnimation.removedOnCompletion = NO;
            maskLayerAnimation.fillMode = kCAFillModeForwards;
            
            [maskLayer addAnimation:maskLayerAnimation forKey:nil];
            
            break;
        }
        default:
            [self dismissAtOnce];
            break;
    }
}

#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self dismissAtOnce];
}

@end
