//
//  InitialNavigationViewController.h
//  Truckish
//
//  Created by Abhijit Paul on 09/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialNavigationViewController : UINavigationController
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end
