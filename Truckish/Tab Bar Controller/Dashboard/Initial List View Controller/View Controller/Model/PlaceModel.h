//
//  PlaceModel.h
//  Truckish
//
//  Created by Abhijit Paul on 11/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject
    
    @property (strong, nonatomic) NSString *name;
    @property (strong, nonatomic) NSString *latitude;
    @property (strong, nonatomic) NSString *longitude;
    @property (strong, nonatomic) NSString *desc;
    
    + (PlaceModel *)createEmptyObject;

@end
