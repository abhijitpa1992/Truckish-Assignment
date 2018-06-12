//
//  JSONManeger.m
//  OmnifyAppProject
//
//  Created by Abhijit Paul on 28/05/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "JSONManeger.h"

@implementation JSONManeger


+ (void)JSONRequestWithparameters:(NSDictionary *)parameters Request:(NSString *)urlRequest success:(void (^)(NSString *, id))success failure:(void (^)(NSString *, NSError *))failure typeOfMethod:(NSString *)type{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if ([type isEqualToString:@"POST"]) {
        [manager POST:urlRequest parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            success(urlRequest,responseObject);
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            failure(urlRequest,error);
        }];
    } else {
        [manager GET:urlRequest parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(urlRequest,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(urlRequest,error);
        }];
    }
}
@end
