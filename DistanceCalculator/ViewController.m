//
//  ViewController.m
//  DistanceCalculator
//
//  Created by Alan Glasby on 05/09/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startPointTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *destination1TxtFld;
@property (weak, nonatomic) IBOutlet UITextField *destination2TxtFld;
@property (weak, nonatomic) IBOutlet UITextField *destination3TxtFld;
@property (weak, nonatomic) IBOutlet UITextField *destination4TxtFld;
@property (weak, nonatomic) IBOutlet UILabel *distance1Lbl;
@property (weak, nonatomic) IBOutlet UILabel *distance2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *distance3Lbl;
@property (weak, nonatomic) IBOutlet UILabel *distance4Lbl;
@property (weak, nonatomic) IBOutlet UIButton *getDistanceBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *distanceUnitsSegmentedController;

@property (nonatomic) double divisor;
@property (nonatomic) NSString *distanceUnits;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureTxtFlds];
    [self configureLbls];
    [self configureBtn];
    self.divisor = 1.00;
    self.distanceUnits = @"m";
}

- (IBAction)distanceUnitsSegmentedControl:(id)sender {

    switch (self.distanceUnitsSegmentedController.selectedSegmentIndex) {
        case 0:
            self.divisor = 1.00;
            self.distanceUnits = @"m";
            break;
        case 1:
            self.divisor = 1000.0;
            self.distanceUnits = @"km";
            break;
        case 2:
            self.divisor = 1609.344;
            self.distanceUnits = @"mi";
            break;
        default:
            break;
    }
}

- (IBAction)getDistancesPushed:(id)sender {
    
    if(![self.startPointTxtFld.text  isEqualToString:@"Enter starting location"] && ![self.startPointTxtFld.text isEqualToString:@""]) {

    self.getDistanceBtn.enabled = NO;

    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startPointTxtFld.text;
    NSString *end1 = self.destination1TxtFld.text;
    NSString *end2 = self.destination2TxtFld.text;
    NSString *end3 = self.destination3TxtFld.text;
    NSString *end4 = self.destination4TxtFld.text;

    NSArray *destinations = @[end1, end2, end3, end4];

    UILabel *distance1 = self.distance1Lbl;
    UILabel *distance2 = self.distance2Lbl;
    UILabel *distance3 = self.distance3Lbl;
    UILabel *distance4 = self.distance4Lbl;

    NSArray *distances = @[distance1, distance2, distance3, distance4];

    self.req = [self.req initWithLocationDescriptions:destinations sourceDescription:start];

    __weak ViewController *weakSelf = self;

    self.req.callback = ^void(NSArray *responses) {
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;

        NSNull *badResult = [NSNull null];

        for (int i = 0; i < [responses count]; i++) {
            double dist = ([responses[i] floatValue] / self.divisor);
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setLocale:[NSLocale currentLocale]];
            [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [numberFormatter setMaximumFractionDigits:2];
            NSString *formattedDist = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:(dist)]];

            if(responses[i] != badResult) {
                NSString *distance = [NSString stringWithFormat:@"  %@ %@", (formattedDist), (strongSelf.distanceUnits)];
                UILabel *labelToUpdate = [distances objectAtIndex:i];
                labelToUpdate.text = distance;
            } else {
                UILabel *labelToUpdate = [distances objectAtIndex:i];
                labelToUpdate.text = @"  Error";
            }
        }
        strongSelf.getDistanceBtn.enabled = YES;
        strongSelf.req = nil;
    };
    [self.req start];
    } else {
        NSLog(@"Error - start location has not been set");
        UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Set Start Location" message:@"Please set a valid start location for the distance calculation." preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];

        [actionController addAction:cancelAction];
        [self presentViewController:actionController animated:YES completion:nil];
    }
}

-(void)configureTxtFlds {
    NSMutableArray *txtFlds = [[NSMutableArray alloc] initWithCapacity:4];
    [txtFlds addObject:self.startPointTxtFld];
    [txtFlds addObject:self.destination1TxtFld];
    [txtFlds addObject:self.destination2TxtFld];
    [txtFlds addObject:self.destination3TxtFld];
    [txtFlds addObject:self.destination4TxtFld];


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
    [lbls addObject:self.distance2Lbl];
    [lbls addObject:self.distance3Lbl];
    [lbls addObject:self.distance4Lbl];

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
