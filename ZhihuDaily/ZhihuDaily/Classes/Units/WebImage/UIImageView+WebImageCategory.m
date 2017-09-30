//
//  UIImageView+WebImageCategory.m
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "UIImageView+WebImageCategory.h"
#import "SINImageDownloader.h"

@implementation UIImageView (WebImageCategory)
- (void)sin_setImageWithUrlStr:(NSString *)urlStr
{
    [self sin_setImageWithUrlStr:urlStr placeholderImage:[UIImage new]];
}


- (void)sin_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage
{
    self.image = placeholderImage;
    SINImageDownloader *dmgr = [SINImageDownloader shared];
    [dmgr downloadImageWithUrlStr:urlStr completion:^(UIImage *image) {
        self.image = image;
    }];
}
@end
