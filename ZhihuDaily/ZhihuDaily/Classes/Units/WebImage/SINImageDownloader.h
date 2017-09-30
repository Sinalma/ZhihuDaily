//
//  SINImageDownloader.h
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(UIImage *image);

@interface SINImageDownloader : NSObject

/** singleton instance */
+ (instancetype)shared;

/**
 * Creates a SINWebImageDownloadManager async downloader instance with a given url string
 *
 *
 * @param urlStr            The URL to the image to download
 * @param completion A block called once the download is completed.
 
 */
- (void)downloadImageWithUrlStr:(NSString *)urlStr completion:(CompletionBlock)completion;
@end
