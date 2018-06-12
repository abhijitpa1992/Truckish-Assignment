//
//  JsonAPICall.m
//  OmnifyAppProject
//
//  Created by Abhijit Paul on 28/05/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "JsonAPICall.h"

#define kRequestTimeOut 30.00

@implementation JsonAPICall

    - (void) getAddressForLat:(NSString *)latitude andLong:(NSString *)longitude {
        
        NSString *stringUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&key=%@", latitude, longitude, GOOGLE_APPKEY];
        
        [JSONManeger JSONRequestWithparameters:nil Request:stringUrl success:^(NSString *request, id JSON) {
            if ([self.delegate respondsToSelector:@selector(didSucceedRequest: jsonData: forApi:)]){
                [self.delegate didSucceedRequest:request jsonData:JSON forApi:@"ADDRESS"];
            }
        } failure:^(NSString *request, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(didFailedRequest: withError: forApi:)]){
                [self.delegate didFailedRequest:request withError:error forApi:@"ADDRESS"];
            }
        } typeOfMethod:@"GET"];
    }
    
    - (void) getTemperatureForLat:(NSString *)latitude andLong:(NSString *)longitude {
        
        NSString *stringUrl = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&APPID=%@&units=metric", latitude, longitude, WEATHER_APPID];
        
        [JSONManeger JSONRequestWithparameters:nil Request:stringUrl success:^(NSString *request, id JSON) {
            if ([self.delegate respondsToSelector:@selector(didSucceedRequest: jsonData: forApi:)]){
                [self.delegate didSucceedRequest:request jsonData:JSON forApi:@"WEATHER"];
            }
        } failure:^(NSString *request, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(didFailedRequest: withError: forApi:)]){
                [self.delegate didFailedRequest:request withError:error forApi:@"WEATHER"];
            }
        } typeOfMethod:@"GET"];
    }

    - (void)GetDirectionFromOrigin:(NSString *)origin toDestination:(NSString *)destination {
        NSString *stringUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&key=%@", origin,destination,GOOGLE_APPKEY];
        
        [JSONManeger JSONRequestWithparameters:nil Request:stringUrl success:^(NSString *request, id JSON) {
            if ([self.delegate respondsToSelector:@selector(didSucceedRequest: jsonData: forApi:)]){
                [self.delegate didSucceedRequest:request jsonData:JSON forApi:@"DIRECTION"];
            }
        } failure:^(NSString *request, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(didFailedRequest: withError: forApi:)]){
                [self.delegate didFailedRequest:request withError:error forApi:@"DIRECTION"];
            }
        } typeOfMethod:@"GET"];
    }




@end
