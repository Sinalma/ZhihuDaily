//
//  UIImageView+WebImageCategory.h
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImageCategory)
/**
 * Set the imageView `image` with an `url string`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param urlStr            The url string for the image.
 */
- (void)sin_setImageWithUrlStr:(NSString *)urlStr;


/**
 * Set the imageView `image` with an `url string`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param urlStr            The url string for the image.
 * @param placeholderImage    The image to be set initially, until the image
 */
- (void)sin_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage;
@end
