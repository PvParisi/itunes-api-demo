//
//  TableViewController.m
//  itunesAPI
//
//  Created by Piervincenzo Parisi on 11/11/16.
//  Copyright © 2016 Piervincenzo Parisi. All rights reserved.
//

#import "TableViewController.h"
#import "NetworkingUtils.h"
#import "Artist.h"
#import "CollectionViewController.h"
#import "UIViewController+AlertInterface.h"

@interface TableViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) NSArray<NSString *> *pickerItems;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolbarCancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toolbarDoneButton;
@property (strong, nonatomic) NSString *selectedArtistFromPicker;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerItems = @[@"Bob",@"John",@"Elvis"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.searchTextField.inputView = self.pickerView;
    self.searchTextField.inputAccessoryView = self.toolbar;
    [NetworkingUtils loadJsonDataFromEndPoint:@"lookup" responseClass:[Artist class] params: @{
                                                                                               @"amgArtistId" : @"468749,5723"
                                                                                               }
                            completionHandler:^(Response *response)
     {
         self.tableEntries = response.artists.mutableCopy;
         dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
     }
                               failureHandler:^(NSError *error)
     {
         [self showAlertWithError:error];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    Artist *artistItem = [self.tableEntries objectAtIndex:indexPath.row];
    cell.textLabel.text = artistItem.name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showAlbumsSegue"]){
        CollectionViewController *controller = (CollectionViewController *)segue.destinationViewController;
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"%ld", (long)selectedIndexPath.row);
        controller.artist = [self.tableEntries objectAtIndex:selectedIndexPath.row];
    }
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    // do nothing
}

- (IBAction)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)searchButtonClicked:(id)sender {
    [self textFieldShouldReturn:self.searchTextField];
}

// controllo no caratteri alfanumerici
// altrimenti dai un error e mostri un alert

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self closeKeyboard:(id)textField];
    [NetworkingUtils loadJsonDataFromEndPoint:@"search" responseClass:[Artist class] params:@{
                                                                                              @"term" : textField.text,
                                                                                              @"entity" : @"allArtist",
                                                                                              @"attribute" : @"allArtistTerm"
                                                                                              }
                            completionHandler:^(Response *response)
    {
        self.tableEntries = response.artists.mutableCopy;
        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
    }
                               failureHandler:^(NSError *error)
    {
        [self showAlertWithError:error];
     }];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    // trim trailing and leading spaces and newline
    NSString *trimmed = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    textField.text = trimmed;
    
    // controllo input
    NSCharacterSet *set = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey : @"Invalid characters",
                                   NSLocalizedFailureReasonErrorKey : @"Non-aphanumeric character(s) found.",
                                   NSLocalizedRecoverySuggestionErrorKey : @"Remove any special character from your search string"
                                   };
        
        NSError *error = [NSError errorWithDomain:@"com.example" code:-1 userInfo:userInfo];
        [self showAlertWithError:error];
        
        return NO;
    }
    return YES;
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerItems count];
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedArtistFromPicker = [self.pickerItems objectAtIndex:row];
}

- (IBAction)toolbarButtonClicked:(id)sender
{
    [self.view endEditing:YES];
    
    if (sender == self.toolbarCancelButton)
    {
        self.searchTextField.text = @"";
        return;
    }
    
    self.searchTextField.text = self.selectedArtistFromPicker;
}

@end
