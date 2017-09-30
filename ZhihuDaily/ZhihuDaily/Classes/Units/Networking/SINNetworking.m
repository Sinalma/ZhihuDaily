//
//  SINNetworking.m
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINNetworking.h"
#import "SINEncoding.h"

@implementation SINNetworking
- (void)GET:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self dataTaskWithMethod:@"GET" urlStr:urlStr params:params success:success failure:failure];
}

- (void)POST:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self dataTaskWithMethod:@"POST" urlStr:urlStr params:params success:success failure:failure];
}

- (void)dataTaskWithMethod:(NSString *)method urlStr:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    SINNetworking *networking = [[SINNetworking alloc] init];
    
    if ([method isEqualToString:@"GET"]) {
        [urlStr stringByAppendingString:@"?"];
        [urlStr stringByAppendingString:[networking sin_getParamStr:params]];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    request.HTTPMethod = method;
    if ([method isEqualToString:@"POST"]) {
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        request.HTTPBody = [[networking sin_getParamStr:params] dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {// NSURLResponse
        if (error != nil) {
            
            failure(error);
            NSLog(@"$$$_ SINNetworking load network failed,reason:%@",error);
        }else{
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] == 200) {
                // transform to json
                NSDictionary *responseDict = [SINEncoding dictionaryObjectWithData:data];
                
                // back main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    NSLog(@"%@",responseDict);
                    success(responseDict);
                });// main queue end
                
            }else{
                
                failure(error);
                
                NSLog(@"$$$_ SINNetworking load network failed,reason:%@",error);
            }
        }
    }];
    
    [task resume];
}

/**
 * @Method:connect network to get background data of  child thread.
 *
 * @description : According to the URL string asynchronous connection network, access to background data, currently supports two methods, GET and POST.
 * @param method : Currently, there are two ways to support get and post
 * @param url : network url string
 * @param params : parameters dictionary
 * @param successed : block callback of connect successed
 * @param failed : block callback of connect failed
 */
+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params successed:(NetSuccessed)successed failed:(NetFailed)failed {
    
    // enter sub thread
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        SINNetworking *networking = [[SINNetworking alloc] init];
        
        if ([method isEqualToString:@"GET"]) {
            [url stringByAppendingString:@"?"];
            [url stringByAppendingString:[networking sin_getParamStr:params]];
            
        }
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.HTTPMethod = method;
        
        if ([method isEqualToString:@"POST"]) {
            [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            request.HTTPBody = [[networking sin_getParamStr:params] dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {// NSURLResponse
            if (error != nil) {
                
                failed(error);
                NSLog(@"$$$_ SINNetworking load network failed,reason:%@",error);
            }else{
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if ([httpResponse statusCode] == 200) {
                    // transform to json
                    NSDictionary *responseDict = [SINEncoding dictionaryObjectWithData:data];
                    
                    // back main queue
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //                    NSLog(@"%@",responseDict);
                        successed(responseDict);
                    });// main queue end
                    
                }else{
                    
                    failed(error);
                    
                    NSLog(@"$$$_ SINNetworking load network failed,reason:%@",error);
                }
            }
        }];
        
        [task resume];
        
    });// sub thread end
}

- (NSString *)sin_getParamStr:(NSDictionary *)params
{
    NSMutableString *strM = [NSMutableString string];
    for (NSString *key in params.allKeys) {
        [strM appendString:[self sin_queryComponents:key value:params[key]]];
        if (params.allKeys.lastObject != key) [strM appendString:@"&"];
    }
    return [strM copy];
}

- (NSString *)sin_queryComponents:(NSString *)key value:(id)value
{
    NSMutableString *components = [[NSMutableString alloc] init];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = value;
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull nestedKey, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [components appendString:[self sin_queryComponents:[NSString stringWithFormat:@"%@%@",key,nestedKey] value:obj]];
        }];
    } else if ([value isKindOfClass:[NSArray class]]){
        NSArray *arr = value;
        for (id value in arr) {
            [components appendString:[self sin_queryComponents:key value:value]];
        }
    }else{
        [components appendFormat:@"%@%@",key,value];
    }
    
    return [components copy];
}
@end
