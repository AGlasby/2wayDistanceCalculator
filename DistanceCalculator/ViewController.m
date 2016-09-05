//
//  ViewController.m
//  DistanceCalculator
//
//  Created by Alan Glasby on 05/09/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *startPointTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *destination1TxtFld;
@property (weak, nonatomic) IBOutlet UITextField *destination2TxtFld;
@property (weak, nonatomic) IBOutlet UITextField *destination3TxtFld;
@property (weak, nonatomic) IBOutlet UILabel *distance1Lbl;
@property (weak, nonatomic) IBOutlet UILabel *distance2LBL;
@property (weak, nonatomic) IBOutlet UILabel *distance3Lbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)getDistancesPushed:(id)sender {

}

-(void)configureTxtFlds {
    NSMutableArray *txtFlds = [[NSMutableArray alloc] initWithCapacity:4];
    [txtFlds addObject:_startPointTxtFld];
    [txtFlds addObject:_destination1TxtFld];
    [txtFlds addObject:_destination2TxtFld];
    [txtFlds addObject:_destination3TxtFld];

    UITextField *tempTextFld = [txtFlds objectAtIndex:0];
    tempTextFld.layer.cornerRadius = 8.0;
//    tempTextFld.layer.borderColor = 



}

-(void)configureLbls {

}

-(void)configureBtn {

}

@end
