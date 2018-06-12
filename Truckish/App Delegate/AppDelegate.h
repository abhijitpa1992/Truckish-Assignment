//
//  AppDelegate.h
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@import GoogleSignIn;
@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

