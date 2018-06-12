//
//  MapViewController.m
//  Truckish
//
//  Created by Abhijit Paul on 09/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController () <GMSMapViewDelegate, JSONDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadMapView];
    self.distance_label.text = [NSString stringWithFormat:@"Distance:"];
    [Singleton radiusOfView:self.draw_route_button withRadius:5 andShadow:YES];
    [self.draw_route_button addTarget:self action:@selector(didTapMyLocationButtonForMapView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMapView {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.placeModel.latitude doubleValue]
                                                            longitude:[self.placeModel.longitude doubleValue]
                                                                 zoom:6];

    self.map_view.camera = camera;
    
    // Map styling
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"style" withExtension:@"json"];
    NSError *error;
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    self.map_view.mapStyle = style;
    
    // Creates a marker
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([self.placeModel.latitude doubleValue], [self.placeModel.longitude doubleValue]);
    marker.title = self.placeModel.name;
    marker.snippet = self.placeModel.desc;
    marker.map = self.map_view;
    
    self.map_view.myLocationEnabled = YES;
    self.map_view.delegate = self;
    self.map_view.settings.myLocationButton = YES;
    self.map_view.settings.allowScrollGesturesDuringRotateOrZoom = YES;
}


- (BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView{
    [self callApiForDirection:self.map_view.myLocation toDestination:[[CLLocation alloc] initWithLatitude:[self.placeModel.latitude doubleValue] longitude:[self.placeModel.longitude doubleValue]]];

    NSLog(@"%@", self.map_view.myLocation);
    
    return YES;
}

- (void)drawRouteFromPathString:(NSString *)pathString {
    
    GMSPath *path = [GMSPath pathFromEncodedPath:pathString];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 4;
    polyline.strokeColor =[UIColor blueColor];
    polyline.map = self.map_view;
    
    GMSCoordinateBounds *bounds =
    [[GMSCoordinateBounds alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.map_view.myLocation.coordinate.latitude, self.map_view.myLocation.coordinate.longitude) coordinate:CLLocationCoordinate2DMake([self.placeModel.latitude doubleValue], [self.placeModel.longitude doubleValue])];
    [self.map_view animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:40.0f]];
}

- (void) callApiForDirection: (CLLocation *)origin toDestination:(CLLocation*)destination {
    JsonAPICall *apicall = [[JsonAPICall alloc] init];
    apicall.delegate = self;
    [apicall GetDirectionFromOrigin:[NSString stringWithFormat:@"%f,%f", origin.coordinate.latitude, origin.coordinate.longitude] toDestination:[NSString stringWithFormat:@"%f,%f", destination.coordinate.latitude, destination.coordinate.longitude]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didFailedRequest:(NSString *)request withError:(NSError *)error forApi:(NSString *)api {
    NSLog(@"api: %@", request);
    NSLog(@"error: %@", error);
}

- (void)didSucceedRequest:(NSString *)request jsonData:(id)JSON forApi:(NSString *)api {
    NSLog(@"api: %@", request);
    NSLog(@"data: %@", JSON);
    
    if ([api isEqualToString:@"DIRECTION"]) {
        if ([[JSON valueForKey:@"routes"] count]==0) {
            NSLog(@"set alert");
        } else {
            [self drawRouteFromPathString:[[[[JSON valueForKey:@"routes"] objectAtIndex:0] valueForKey:@"overview_polyline"] valueForKey:@"points"]];
            self.distance_label.text = [NSString stringWithFormat:@"Distance: %@", [[[[[[JSON valueForKey:@"routes"] objectAtIndex:0] valueForKey:@"legs"] objectAtIndex:0] valueForKey:@"distance"] valueForKey:@"text"]];
        }
    }
}

@end
