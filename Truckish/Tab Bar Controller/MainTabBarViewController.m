//
//  MainTabBarViewController.m
//  Truckish
//
//  Created by Abhijit Paul on 09/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] } forState:UIControlStateSelected];
    
    InitialNavigationViewController *dashNavVC = [storyboard instantiateViewControllerWithIdentifier:@"InitialNavigationViewController"];
    dashNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Dashboard" image:[[UIImage imageNamed:@"dash_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"dash_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    ProfileViewController *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    profileVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[[UIImage imageNamed:@"profile_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"profile_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers =[NSArray arrayWithObjects:dashNavVC, profileVC, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
