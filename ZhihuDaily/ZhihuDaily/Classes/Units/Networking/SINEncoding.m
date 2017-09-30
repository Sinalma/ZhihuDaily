//
//  SINEncoding.m
//  ZhihuDaily
//
//  Created by apple on 30/09/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINEncoding.h"

@implementation SINEncoding

+ (NSDictionary *)dictionaryObjectWithData:(NSData *)data
{
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error == nil) {
        return jsonDict;
    }else{
        NSLog(@"$$$_SINEncoding解析失败,原因:%@",error);
    }
    return @{@"":@""};
}
@end
