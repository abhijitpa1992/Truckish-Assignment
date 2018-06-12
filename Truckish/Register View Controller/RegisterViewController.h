//
//  RegisterViewController.h
//  Truckish
//
//  Created by Abhijit Paul on 11/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
    @property (weak, nonatomic) IBOutlet UIImageView *name_icon;
    @property (weak, nonatomic) IBOutlet UIImageView *email_icon;
    @property (weak, nonatomic) IBOutlet UIImageView *password_icon;
@property (weak, nonatomic) IBOutlet UIButton *back_button;

    @property (weak, nonatomic) IBOutlet UIFloatLabelTextField *name_textField;
    @property (weak, nonatomic) IBOutlet UIFloatLabelTextField *email_textField;
    @property (weak, nonatomic) IBOutlet UIFloatLabelTextField *password_textField;
    @property (weak, nonatomic) IBOutlet UIButton *register_button;
    
@end
