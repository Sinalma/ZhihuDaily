//
//  SINLaunchSkipButton.h
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SINLaunchSkipButtonType) {
    SINLaunchSkipButtonTypeCircle = 0,
    SINLaunchSkipButtonTypeSquare = 1,
    SINLaunchSkipButtonTypeRectangle = 2,
    SINLaunchSkipButtonTypeOval = 3
};

@interface SINLaunchSkipButton : UIButton

/** show skip button time for not launch  */
@property (nonatomic,assign) NSInteger remainSecond;

@property (nonatomic,strong) UIColor *txtColor;

@property (nonatomic,strong) UIColor *bgColor;

/** this is a label to show remain second */
@property (nonatomic,strong) UILabel *remainSecondLabel;
- (instancetype)initWitCustomType:(SINLaunchSkipButtonType)customType;

@end
