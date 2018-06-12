//
//  PopUpViewController.h
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"

@protocol callDismissPopUp <NSObject>
-(void)dismissedPopUpWithModel:(PlaceModel *)placeModel;
@end

@interface PopUpViewController : UIViewController
@property(nonatomic,assign)id delegate;
@property (weak, nonatomic) IBOutlet UIButton *go_to_map_button;
    @property (strong, nonatomic) PlaceModel *placeModel;
    @property (weak, nonatomic) IBOutlet UIView *bg_alert_view;
    @property (weak, nonatomic) IBOutlet UIImageView *day_night_bg_imageView;
    @property (weak, nonatomic) IBOutlet UILabel *temperature_label;
    @property (weak, nonatomic) IBOutlet UILabel *address_label;
    @property (weak, nonatomic) IBOutlet UIView *locate_bg_view;
@property (weak, nonatomic) IBOutlet UIImageView *weather_imageView;
@property (weak, nonatomic) IBOutlet UIButton *close_button;

@end
