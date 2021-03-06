//
//  UIView+Category.m
//  ZhihuDaily
//
//  Created by apple on 22/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
/**
 * x
 */
- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
    
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

/**
 * y
 */
- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
    
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

/**
 * width
 */
- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

/**
 * height
 */
- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

/**
 * size
 */
- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
- (CGSize)size
{
    return self.frame.size;
}

/**
 * origin
 */
- (void)setOrigin:(CGPoint)origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}
- (CGPoint)origin
{
    return self.frame.origin;
}

/**
 * centre
 */
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
@end
