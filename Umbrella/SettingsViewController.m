//
//  SettingsViewController.m
//  Umbrella
//
//  Created by Chen Shi on 9/13/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "SettingsViewController.h"
#import "DataManager.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Zip";
            cell.detailTextLabel.text = [DataManager sharedInstance].zipCode;
            break;
        case 1:
            cell.textLabel.text = @"Units";
            cell.detailTextLabel.text = [DataManager sharedInstance].fahrenheit ? @"Fahrenheit" : @"Celsius";
            break;
        default:
            break;
    }

    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Zip Code" message:@"Please enter zipcode" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok= [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [DataManager sharedInstance].zipCode = alert.textFields[0].text;
                                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                     [defaults setObject:alert.textFields[0].text forKey:@"zip"];
                                     [defaults synchronize];
                                     [tableView reloadData];
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            UIAlertAction *cancel = [UIAlertAction
                                     actionWithTitle:@"Cancel"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"Zipcode";
            }];
            [alert addAction:ok];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 1:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Units" message:@"Please choose units" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *fahrenheit= [UIAlertAction
                                actionWithTitle:@"Fahrenheit"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [DataManager sharedInstance].fahrenheit = YES;
                                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                    [defaults setBool:YES forKey:@"fahrenheit"];
                                    [defaults synchronize];
                                    [tableView reloadData];
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                }];
            UIAlertAction *celsius = [UIAlertAction
                                     actionWithTitle:@"Celsius"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [DataManager sharedInstance].fahrenheit = NO;
                                         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                         [defaults setBool:NO forKey:@"fahrenheit"];
                                         [defaults synchronize];
                                         [tableView reloadData];
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
            [alert addAction:fahrenheit];
            [alert addAction:celsius];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
