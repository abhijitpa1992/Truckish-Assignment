//
//  InitialListViewController.m
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "InitialListViewController.h"

@interface InitialListViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *tableData;
}
    
    @property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation InitialListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableData = [[NSMutableArray alloc] init];
    [self getDataFromFirebase];
}
    - (void) getDataFromFirebase {
        self.ref = [[FIRDatabase database] reference];
        
        [self.ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            // Get user value
            NSLog(@"%@", snapshot.value[@"places"]);
            for(NSDictionary* place in snapshot.value[@"places"]) {
                NSLog(@"%@", place);
                PlaceModel *placeModel = [PlaceModel createEmptyObject];
                placeModel.name = [place valueForKey:@"name"];
                placeModel.latitude = [[[place valueForKey:@"location"] componentsSeparatedByString:@","] objectAtIndex:0];
                placeModel.longitude = [[[place valueForKey:@"location"] componentsSeparatedByString:@","] objectAtIndex:1];
                placeModel.desc = [place valueForKey:@"description"];
                
                [self->tableData addObject:placeModel];
            }
            
            [self.main_tableView reloadData];
            // ...
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
        }];

    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 120;
    }

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"InitialListTableViewCell";
    InitialListTableViewCell *cell = (InitialListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];  
    }
    [Singleton radiusOfView:cell.bg_view withRadius:10 andShadow:YES];
    PlaceModel *placeModel = [tableData objectAtIndex:indexPath.row];
    cell.name_label.text = placeModel.name;
    cell.description_label.text = placeModel.desc;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopUpViewController *popUpVC = [storyboard instantiateViewControllerWithIdentifier:@"PopUpViewController"];

    popUpVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    popUpVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    popUpVC.placeModel = [tableData objectAtIndex:indexPath.row];
    popUpVC.delegate = self;
    [self presentViewController:popUpVC animated:YES completion:nil];
}

- (void)dismissedPopUpWithModel:(PlaceModel *)placeModel {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MapViewController *mapVC = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mapVC.placeModel = placeModel;
    [self.navigationController pushViewController:mapVC animated:YES];
}





@end
