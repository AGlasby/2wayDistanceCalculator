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
@property (weak, nonatomic) IBOutlet UIButton *getDistanceBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureTxtFlds];
    [self configureLbls];
    [self configureBtn];
}

- (IBAction)getDistancesPushed:(id)sender {
    self.distance3Lbl.text = @"  150 miles";

}

-(void)configureTxtFlds {
    NSMutableArray *txtFlds = [[NSMutableArray alloc] initWithCapacity:4];
    [txtFlds addObject:self.startPointTxtFld];
    [txtFlds addObject:self.destination1TxtFld];
    [txtFlds addObject:self.destination2TxtFld];
    [txtFlds addObject:self.destination3TxtFld];


    for (int i = 0; (i < [txtFlds count]); i++) {

        UITextField *tempTextFld = [txtFlds objectAtIndex:i];

        tempTextFld.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
        tempTextFld.layer.sublayerTransform = CATransform3DMakeTranslation(10.0, 1.0, 0.0);
        tempTextFld.layer.cornerRadius = 4.0;
        tempTextFld.layer.backgroundColor = [UIColor colorWithRed:0.020 green:0.102 blue:0.235 alpha:0.4].CGColor;
        tempTextFld.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
        tempTextFld.layer.borderWidth = 2.0;
    }
}

-(void)configureLbls {
    NSMutableArray *lbls = [[NSMutableArray alloc] initWithCapacity:3];

    [lbls addObject:self.distance1Lbl];
    [lbls addObject:self.distance2LBL];
    [lbls addObject:self.distance3Lbl];

    for (int i = 0; (i < [lbls count]); i++) {

        UILabel *tempLbl = [lbls objectAtIndex:i];

        tempLbl.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
        tempLbl.layer.cornerRadius = 4.0;
        tempLbl.layer.backgroundColor = [UIColor colorWithRed:0.020 green:0.102 blue:0.235 alpha:0.4].CGColor;
        tempLbl.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
        tempLbl.layer.borderWidth = 2.0;
        tempLbl.clipsToBounds = YES;
        tempLbl.text = @"   0.0";
    }

}

-(void)configureBtn {
    [self.getDistanceBtn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9] forState:UIControlStateNormal];
    self.getDistanceBtn.layer.cornerRadius = 4.0;
    self.getDistanceBtn.layer.backgroundColor = [UIColor colorWithRed:0.020 green:0.102 blue:0.235 alpha:0.4].CGColor;
    self.getDistanceBtn.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    self.getDistanceBtn.layer.borderWidth = 2.0;
}

@end
