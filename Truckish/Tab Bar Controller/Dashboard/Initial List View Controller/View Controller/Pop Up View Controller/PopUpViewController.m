//
//  PopUpViewController.m
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController () <JSONDelegate>

@end

@implementation PopUpViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        [self addViewGesture];
        [self setupUI];
        [self callAPIForAddress];
        [self callAPIForWeather];
        [self.go_to_map_button addTarget:self action:@selector(go_to_map_button_action:) forControlEvents:UIControlEventTouchUpInside];
        [self.close_button addTarget:self action:@selector(handleSingleTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    - (void)callAPIForAddress {
        JsonAPICall *apicall = [[JsonAPICall alloc] init];
        apicall.delegate = self;
        [apicall getAddressForLat:self.placeModel.latitude andLong:self.placeModel.longitude];
    }
    
    - (void)callAPIForWeather {
        JsonAPICall *apicall = [[JsonAPICall alloc] init];
        apicall.delegate = self;
        [apicall getTemperatureForLat:self.placeModel.latitude andLong:self.placeModel.longitude];
    }
    
    - (void) setupUI {
        [Singleton radiusOfView:self.bg_alert_view withRadius:5 andShadow:YES];
        [self.bg_alert_view.layer setMasksToBounds:YES];
        [Singleton radiusOfView:self.locate_bg_view withRadius:5 andShadow:YES];
    }

    - (void)didFailedRequest:(NSString *)request withError:(NSError *)error forApi:(NSString *)api{
        NSLog(@"api: %@", request);
        NSLog(@"error: %@", error);
    }

    - (void)didSucceedRequest:(NSString *)request jsonData:(id)JSON forApi:(NSString *)api{
        NSLog(@"api: %@", request);
        NSLog(@"data: %@", JSON);
        
        if ([api isEqualToString:@"ADDRESS"]) {
            if ([[JSON valueForKey:@"results"] count]==0) {
                [self setAddressWith:[NSString stringWithFormat:@"%@ %@", self.placeModel.latitude, self.placeModel.longitude]];
            } else {
                
                [self setAddressWith:[[[JSON valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"]];
            }
        } else {
            [self setWeatherWithTemperature:[[JSON valueForKey:@"main"] valueForKey:@"temp"] andType:[[[JSON valueForKey:@"weather"] objectAtIndex:0] valueForKey:@"icon"]];
        }
    }

    - (void) setAddressWith:(NSString *)address {
        self.address_label.text = address;
    }

    - (void) setWeatherWithTemperature:(NSString *)temperature andType:(NSString *)type{
        NSLog(@"%@", [type stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]]);
        NSLog(@"%@", [type stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]]);
        
        if ([[type stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]] isEqualToString:@"n"]) {
            self.day_night_bg_imageView.image = [UIImage imageNamed:@"night.png"];
        } else {
            self.day_night_bg_imageView.image = [UIImage imageNamed:@"day.png"];
        }
        self.temperature_label.text = [NSString stringWithFormat:@"%@ °C", temperature];
        self.weather_imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",type]];
        self.weather_imageView.image = [self.weather_imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.weather_imageView setTintColor:[UIColor whiteColor]];
    }

    - (void) addViewGesture {
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self.view addGestureRecognizer:singleFingerTap];
    }
    
    - (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
        //Do stuff here...
    }

    - (IBAction)go_to_map_button_action:(id)sender {
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate dismissedPopUpWithModel:self.placeModel];
        }];
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
