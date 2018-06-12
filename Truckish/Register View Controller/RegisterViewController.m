//
//  RegisterViewController.m
//  Truckish
//
//  Created by Abhijit Paul on 11/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self setupButtonAction];
}
    
    - (void) setupUI {
        [Singleton radiusOfView:self.register_button withRadius:5 andShadow:YES];
    }
    
    - (void) setupButtonAction {
        [self.register_button addTarget:self action:@selector(register_button_action:) forControlEvents:UIControlEventTouchUpInside];
        [self.back_button addTarget:self action:@selector(back_button_action:) forControlEvents:UIControlEventTouchUpInside];
    }

- (IBAction)back_button_action:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
    
    - (IBAction)register_button_action:(id)sender {
        [[FIRAuth auth] createUserWithEmail:self.email_textField.text
                                   password:self.password_textField.text
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                                     // ...
                                     if (error) {
                                         NSLog(@"Error: %@", error.description);
                                         return;
                                     }
                                     [self dismissViewControllerAnimated:YES completion:NULL];
                                 }];
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
