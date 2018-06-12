//
//  JSONManeger.h
//  OmnifyAppProject
//
//  Created by Abhijit Paul on 28/05/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Singleton.h"

@interface JSONManeger : NSObject

+ (void)JSONRequestWithparameters:(NSDictionary *)parameters Request:(NSString *)urlRequest
                       success:(void (^)(NSString *request,id JSON))success
                       failure:(void (^)(NSString *request, NSError* error))failure typeOfMethod:(NSString *)type;


@end
