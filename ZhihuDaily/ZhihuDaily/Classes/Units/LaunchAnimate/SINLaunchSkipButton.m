//
//  SINLaunchSkipButton.m
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINLaunchSkipButton.h"
#import "SINLanguageManager.h"

@interface SINLaunchSkipButton ()

@property (nonatomic,assign) SINLaunchSkipButtonType customType;

@end

@implementation SINLaunchSkipButton
{
    CGRect _CircleBounds;
    CGRect _SquareBounds;
    CGRect _RectangleBounds;
    CGRect _OvalBounds;
}

- (void)setupCustomBtnRect{
    _CircleBounds = CGRectMake(0, 0, 40, 40);
    _SquareBounds = CGRectMake(0, 0, 40, 40);
    _RectangleBounds = CGRectMake(0, 0, 50, 40);
    _OvalBounds = CGRectMake(0, 0,50, 40);
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

- (void)setTxtColor:(UIColor *)txtColor
{
    _txtColor = txtColor;
    [self setTitleColor:txtColor forState:UIControlStateNormal];
    _remainSecondLabel.textColor = txtColor;
}

- (instancetype)initWitCustomType:(SINLaunchSkipButtonType)customType
{
    _customType = customType;
    
    self = [self init];
    if (self) {
    }
    return self;
}

- (CGRect)getBtnBounds
{
    CGRect skipBtnBounds;
    switch (self.customType) {
        case SINLaunchSkipButtonTypeSquare:
            skipBtnBounds = _SquareBounds;
            break;
        case SINLaunchSkipButtonTypeRectangle:
            skipBtnBounds = _RectangleBounds;
            break;
        case SINLaunchSkipButtonTypeOval:
            skipBtnBounds = _OvalBounds;
            break;
        default:
            skipBtnBounds = _CircleBounds;
            break;
    }
    return skipBtnBounds;
}

- (CGFloat)getRadius
{
    if (_customType == SINLaunchSkipButtonTypeOval || _customType == SINLaunchSkipButtonTypeCircle) {
        return [self getBtnBounds].size.height/2;
    }
    return 0;
}

- (instancetype)init
{
    [self setupCustomBtnRect];
    CGRect skipBtnBounds = [self getBtnBounds];
    
    self = [super initWithFrame:skipBtnBounds];
    if (self) {
        NSString *btnTitle = [SINLanguageManager isChinaLanguage]?@"跳过":@"skip";
        [self setTitle:btnTitle forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = [self getRadius];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 2;
        [self addSubview:self.remainSecondLabel];
    }
    return self;
}

- (UILabel *)remainSecondLabel
{
    if (!_remainSecondLabel) {
        _remainSecondLabel = [[UILabel alloc] init];
        _remainSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, 13)];
        _remainSecondLabel.textAlignment = NSTextAlignmentCenter;
        _remainSecondLabel.font = [UIFont systemFontOfSize:12];
        _remainSecondLabel.text = @"0 s";
    }
    return _remainSecondLabel;
}

- (void)setRemainSecond:(NSInteger)remainSecond
{
    _remainSecond = remainSecond;
    self.remainSecondLabel.text = [NSString stringWithFormat:@"%ld s",remainSecond];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height/2-13, contentRect.size.width, 13);
}


@end
