//
//  ViewController.m
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <GIDSignInUIDelegate, GIDSignInDelegate, UITextFieldDelegate>

@end

@implementation ViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up the UI with round rectangle views and buttons
        [self setupUI];
        
        // Set up button action
        [self setupButtonAction];
        
    }

    - (void) setupUI {
        [Singleton radiusOfView:self.info_bg_view withRadius:5 andShadow:YES];
        [Singleton radiusOfView:self.sign_in_button withRadius:5 andShadow:YES];
        [Singleton radiusOfView:self.fb_view withRadius:5 andShadow:YES];
        [Singleton radiusOfView:self.google_view withRadius:5 andShadow:YES];
        
        self.password_inputField.delegate = self;
        self.username_inputField.delegate = self;
        self.username_inputField.returnKeyType = UIReturnKeyDone;
        self.password_inputField.returnKeyType = UIReturnKeyDone;

    }

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.logo_center_constraint setConstant:-50];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
//    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.info_bg_view setFrame:CGRectMake(0,-110,320,460)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.logo_center_constraint setConstant:0];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

    - (void) setupButtonAction {
        [self.sign_in_button addTarget:self action:@selector(sign_in_button_action:) forControlEvents:UIControlEventTouchUpInside];
        [self.register_button addTarget:self action:@selector(register_button_action:) forControlEvents:UIControlEventTouchUpInside];
        [self.google_button addTarget:self action:@selector(google_button_action:) forControlEvents:UIControlEventTouchUpInside];
        [self.fb_button addTarget:self action:@selector(fb_button_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    - (IBAction)fb_button_action:(id)sender {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"public_profile"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in");
                 FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                  credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                 [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                                                          completion:^(FIRAuthDataResult * _Nullable authResult,
                                                                       NSError * _Nullable error) {
                                                              if (error) {
                                                                  return;
                                                              }
                                                              // User successfully signed in...
                                                              FIRUser *user = [FIRAuth auth].currentUser;
                                                              if (user) {
                                                                  // The user's ID, unique to the Firebase project.
                                                                  // Do NOT use this value to authenticate with your backend server,
                                                                  // if you have one. Use getTokenWithCompletion:completion: instead.
                                                                  [self successfullySignedIn:user];
                                                              }
                                                          }];
             }
         }];
    }
    
    - (IBAction)google_button_action:(id)sender {
        [GIDSignIn sharedInstance].delegate = self;
        [GIDSignIn sharedInstance].uiDelegate = self;
        [[GIDSignIn sharedInstance] signIn];
    }
    
    - (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
    - (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    - (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
         withError:(NSError *)error {
        if (error == nil) {
            GIDAuthentication *authentication = user.authentication;
            FIRAuthCredential *credential =
            [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                             accessToken:authentication.accessToken];
            [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                                                     completion:^(FIRAuthDataResult * _Nullable authResult,
                                                                  NSError * _Nullable error) {
                                                         if (error) {
                                                             return;
                                                         }
                                                         // User successfully signed in...
                                                         FIRUser *user = [FIRAuth auth].currentUser;
                                                         if (user) {
                                                             // The user's ID, unique to the Firebase project.
                                                             // Do NOT use this value to authenticate with your backend server,
                                                             // if you have one. Use getTokenWithCompletion:completion: instead.
                                                             [self successfullySignedIn:user];
                                                         }
                                                     }];
        }
    }
    
- (void) successfullySignedIn:(FIRUser*)user {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTabBarViewController *tabVC = [storyboard instantiateViewControllerWithIdentifier:@"MainTabBarViewController"];
    [self presentViewController:tabVC animated:YES completion:NULL];
}
    
    - (IBAction)register_button_action:(id)sender {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegisterViewController *regVC = [storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
        [self presentViewController:regVC animated:YES completion:NULL];
    }

    - (IBAction)sign_in_button_action:(id)sender {
        
        [[FIRAuth auth] signInWithEmail:self.username_inputField.text
                               password:self.password_inputField.text
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
                                 
                                 if (error) {
                                     NSLog(@"Error: %@", error.description);
                                     return;
                                 }
                                 FIRUser *user = [FIRAuth auth].currentUser;
                                 if (user) {
                                     // The user's ID, unique to the Firebase project.
                                     // Do NOT use this value to authenticate with your backend server,
                                     // if you have one. Use getTokenWithCompletion:completion: instead.
                                     [self successfullySignedIn:user];
                                 }
                                 [self successfullySignedIn:user];
                                 // ...
                             }];
    }
    
    
    - (void) viewDidAppear:(BOOL)animated {
        self.handle = [[FIRAuth auth]
                       addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                           // ...
                       }];
    }
    
    - (void) viewDidDisappear:(BOOL)animated {
        [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
    }
    
    


    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


@end
