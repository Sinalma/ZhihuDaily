//
//  SINNetworking.h
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

typedef void(^NetSuccessed)(NSDictionary *data);
typedef void(^NetFailed)(NSError *error);

#import <Foundation/Foundation.h>

@interface SINNetworking : NSObject

@property (nonatomic,copy) NetSuccessed successed;
@property (nonatomic,copy) NetFailed failed;

- (void)GET:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;
- (void)POST:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params successed:(NetSuccessed)successed failed:(NetFailed)failed;

@end
