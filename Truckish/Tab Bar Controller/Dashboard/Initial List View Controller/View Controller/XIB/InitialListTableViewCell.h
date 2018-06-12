//
//  InitialListTableViewCell.h
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialListTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *name_label;
    @property (weak, nonatomic) IBOutlet UILabel *description_label;
    @property (weak, nonatomic) IBOutlet UIView *bg_view;
    
@end
