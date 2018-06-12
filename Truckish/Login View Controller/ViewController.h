//
//  ViewController.h
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseAuth;

@interface ViewController : UIViewController
    @property (weak, nonatomic) IBOutlet UIView *info_bg_view;
    @property (weak, nonatomic) IBOutlet UIFloatLabelTextField *username_inputField;
    @property (weak, nonatomic) IBOutlet UIFloatLabelTextField *password_inputField;
    @property (weak, nonatomic) IBOutlet UIButton *sign_in_button;

    @property (weak, nonatomic) IBOutlet UIView *fb_view;
    @property (weak, nonatomic) IBOutlet UIImageView *fb_icon;
    @property (weak, nonatomic) IBOutlet UILabel *fb_label;
    @property (weak, nonatomic) IBOutlet UIButton *fb_button;
    @property (weak, nonatomic) IBOutlet UIView *google_view;
    @property (weak, nonatomic) IBOutlet UIImageView *google_icon;
    @property (weak, nonatomic) IBOutlet UILabel *google_label;
    @property (weak, nonatomic) IBOutlet UIButton *google_button;
    @property (weak, nonatomic) IBOutlet UIButton *register_button;
    
    @property (strong, nonatomic) FIRAuth *handle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logo_center_constraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bg_view_top_constraint;

@end

