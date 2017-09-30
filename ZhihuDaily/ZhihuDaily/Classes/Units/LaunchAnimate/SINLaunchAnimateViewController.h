//
//  SINLaunchAnimateViewController.h
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//
// use : transfer custom method in appDelegate 'didFinishLaunchingWithOptions'
// - (instancetype)initWitContentView:(UIView *)contentView animateType:(SINLaunchAnimateType)animateType isShowSkipButton:(BOOL)isShowSkipButton skipBtnType:(SINLaunchSkipButtonType)skipBtnType

#import <UIKit/UIKit.h>
#import "SINLaunchSkipButton.h"

typedef void(^CompleteBlock)(void);

typedef NS_ENUM(NSInteger,SINLaunchAnimateType) {
    SINLaunchAnimateTypeNone = 0,
    SINLaunchAnimateTypeFade,
    SINLaunchAnimateTypeFadeAndZoomIn,
    SINLaunchAnimateTypePointZoomIn1,
    SINLaunchAnimateTypePointZoomIn2,
    SINLaunchAnimateTypePointZoomOut1,
    SINLaunchAnimateTypePointZoomOut2
};


@interface SINLaunchAnimateViewController : UIViewController

/** content view , must not be nil. */
@property (nonatomic,strong) UIView *contentView;

/** animate type , default is SINLaunchAnimateTypeNone. */
@property (nonatomic,assign) SINLaunchAnimateType animateType;

/** animate duration , default is 0.8s. */
@property (nonatomic,assign) CGFloat animateDuration;

/** is start launch animate duration , default is 3.0s.*/
@property (nonatomic,assign) CGFloat waitDuration;

/** launch operation complete transfer , do somethings on the block. */
@property (nonatomic,strong) CompleteBlock complete;

/** skip button is SINLaunchSkipButton instance, position in the right and top , can click to close launch page. */
@property (nonatomic,assign) BOOL isShowSkipButton;

/** about skip button attribute. */
@property (nonatomic,assign) SINLaunchSkipButtonType skipBtnType;
@property (nonatomic,assign) UIColor *skipBtnBgColor;
@property (nonatomic,assign) UIColor *skipBtnTxtColor;
@property (nonatomic,assign) BOOL isShowSkipProgress;

/**
 * @method : quickly create 'SINLaunchAnimateViewController' instance.
 *
 * @description : transfer this method to create SINLaunchAnimateViewController instance
 *
 * @param contentView : launch page main view , must not be nil.
 * @param animateType : SINLaunchAnimateType
 * @param isShowSkipButton : skip button
 */
- (instancetype)initWitContentView:(UIView *)contentView animateType:(SINLaunchAnimateType)animateType isShowSkipButton:(BOOL)isShowSkipButton skipBtnType:(SINLaunchSkipButtonType)skipBtnType;

/** show launch page. */
- (void)show;

/** close launch page. */
- (void)dismissAtOnce;
@end
