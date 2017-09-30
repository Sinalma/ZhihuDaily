//
//  UIButton+WebImageCategory.h
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WebImageCategory)

/**
 * Set the button `image` with an `url string`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param urlStr            The url string for the image.
 */
- (void)sin_setImageWithUrlStr:(NSString *)urlStr;

/**
 * Set the button `image` with an `url string`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param urlStr            The url string for the image.
 * @param placeholderImage    The image to be set initially, until the image
 */
- (void)sin_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage;
@end
