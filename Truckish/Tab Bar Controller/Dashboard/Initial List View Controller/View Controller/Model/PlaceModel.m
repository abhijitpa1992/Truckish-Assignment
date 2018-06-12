//
//  PlaceModel.m
//  Truckish
//
//  Created by Abhijit Paul on 11/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel
    
    @synthesize name;
    @synthesize latitude;
    @synthesize longitude;
    @synthesize desc;
    
    + (PlaceModel *)createEmptyObject{
        PlaceModel *model = [[PlaceModel alloc] init];
        return model;
    }

@end
