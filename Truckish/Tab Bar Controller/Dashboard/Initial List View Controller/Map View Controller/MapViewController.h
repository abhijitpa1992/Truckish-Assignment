//
//  MapViewController.h
//  Truckish
//
//  Created by Abhijit Paul on 09/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) PlaceModel *placeModel;
@property (weak, nonatomic) IBOutlet GMSMapView *map_view;
@property (weak, nonatomic) IBOutlet UIButton *draw_route_button;
@property (weak, nonatomic) IBOutlet UILabel *distance_label;

@end
