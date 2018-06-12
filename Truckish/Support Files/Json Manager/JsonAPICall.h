//
//  JsonAPICall.h
//  OmnifyAppProject
//
//  Created by Abhijit Paul on 28/05/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "JSONManeger.h"
#import "Singleton.h"
#import "AFNetworking.h"

@protocol JSONDelegate <NSObject>

//success
-(void)didSucceedRequest:(NSString *)request jsonData:(id)JSON forApi:(NSString *)api;

//failure
-(void)didFailedRequest:(NSString *)request withError:(NSError *)error forApi:(NSString *)api;

@end

@interface JsonAPICall : NSObject
@property (nonatomic, weak) id <JSONDelegate> delegate;


#pragma mark - Get Address
    - (void) getAddressForLat:(NSString *)latitude andLong:(NSString *)longitude;

#pragma mark - Get Temperature
- (void)getTemperatureForLat:(NSString *)latitude andLong:(NSString *)longitude;

#pragma mark - Get Direction
- (void)GetDirectionFromOrigin:(NSString *)origin toDestination:(NSString *)destination;
@end
