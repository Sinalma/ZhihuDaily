//
//  UIButton+WebImageCategory.m
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "UIButton+WebImageCategory.h"
#import "SINImageDownloader.h"

@implementation UIButton (WebImageCategory)

- (void)sin_setImageWithUrlStr:(NSString *)urlStr
{
    [self sin_setImageWithUrlStr:urlStr placeholderImage:[UIImage new]];
}

- (void)sin_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage
{
    [self setImage:placeholderImage forState:UIControlStateNormal];
    
    SINImageDownloader *dmgr = [[SINImageDownloader alloc] init] ;
    [dmgr downloadImageWithUrlStr:urlStr completion:^(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
    }];
}

@end
