//
//  SVViewController.m
//  Calculator
//
//  Created by Steffan Voges on 7/6/14.
//  Copyright (c) 2014 Steffan. All rights reserved.
//

#import "SVViewController.h"

@interface SVViewController ()

@property (nonatomic, strong) NSString *valuesEntered;

@property (nonatomic, weak) IBOutlet UILabel *currentValue;

@property (nonatomic, weak) IBOutlet UILabel *runningTotal;

@end

@implementation SVViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _valuesEntered = [[NSString alloc] init];
    }
    return self;
}

- (IBAction)calculate: (id) sender
   {
       // When the calculate button is hit, return the result of the operands
       
       int total = nil;
       
       NSString *currOp;
       int first;
       int second;
       int parenTotal = nil;
       
       BOOL parenMode = NO;
       
       NSMutableArray *ops = [_valuesEntered componentsSeparatedByString:@" "];
       
       while (!([ops count] == 0)) {
           if (total) {
               if ([[ops objectAtIndex:0] isEqualToString:@"("]) {
                   parenMode = YES;
                   [ops removeObjectAtIndex:0];
               } else if ([[ops objectAtIndex:0] isEqualToString:@")"]) {
                   parenMode = NO;
                   [ops removeObjectAtIndex:0];
                   total += parenTotal;
                   parenTotal = nil;
               } else if (parenMode) {
                   if (parenTotal) {
                       first = parenTotal;
                       currOp = [ops objectAtIndex:0];
                       second = [[ops objectAtIndex:1] intValue];
                       
                       [ops removeObjectAtIndex:1];
                       [ops removeObjectAtIndex:0];
                   } else {
                       first =[[ops objectAtIndex:0] intValue];
                       currOp = [ops objectAtIndex:1];
                       second = [[ops objectAtIndex:2] intValue];
                       
                       [ops removeObjectAtIndex:2];
                       [ops removeObjectAtIndex:1];
                       [ops removeObjectAtIndex:0];
                   }
               } else {
                   first = total;
                   currOp = [ops objectAtIndex:0];
                   second = [[ops objectAtIndex:1] intValue];
               
                   [ops removeObjectAtIndex:1];
                   [ops removeObjectAtIndex:0];
               }
               
           } else {
               if ([[ops objectAtIndex:1] isEqualToString:@"("]) {
                   parenMode = YES;
                   [ops removeObjectAtIndex:1];
                   [ops removeObjectAtIndex:0];
               } else {
                   first =[[ops objectAtIndex:0] intValue];
                   currOp = [ops objectAtIndex:1];
                   second = [[ops objectAtIndex:2] intValue];
               
                   [ops removeObjectAtIndex:2];
                   [ops removeObjectAtIndex:1];
                   [ops removeObjectAtIndex:0];
               }
           }
           
           if ([currOp isEqualToString:@"+"]) {
               total = first + second;
           } else if ([currOp isEqualToString:@"-"]) {
               total = first - second;
           } else if ([currOp isEqualToString:@"/"]) {
               total = first / second;
           } else if ([currOp isEqualToString:@"*"]) {
               total = first * second;
           } else {
               [NSException raise:@"Invalid operator" format:@"Value of operator is invalid"];
           }
       }
       NSString* newTotal = [NSString stringWithFormat:@"%i", total];
       self.currentValue.text = newTotal;
   }

- (IBAction)reset: (id) sender
{
    // Reset all the values in the calculator
    _valuesEntered = @"";
    [self showCurrentValue:(sender)];
}

- (IBAction)openParen: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@" ( "];
    [self showCurrentValue:(sender)];
}

- (IBAction)closedParen: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@" ) "];
    [self showCurrentValue:(sender)];
}

- (IBAction)one: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"1"];
    [self showCurrentValue:(sender)];
}

- (IBAction)two: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"2"];
    [self showCurrentValue:(sender)];
}

- (IBAction)three: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"3"];
    [self showCurrentValue:(sender)];
}

- (IBAction)four: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"4"];
    [self showCurrentValue:(sender)];
}

- (IBAction)five: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"5"];
    [self showCurrentValue:(sender)];
}

- (IBAction)six: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"6"];
    [self showCurrentValue:(sender)];
}

- (IBAction)seven: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"7"];
    [self showCurrentValue:(sender)];
}

- (IBAction)eight: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"8"];
    [self showCurrentValue:(sender)];
}

- (IBAction)nine: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"9"];
    [self showCurrentValue:(sender)];
}

- (IBAction)mul: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@" * "];
    [self showCurrentValue:(sender)];
}

- (IBAction)sub: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@" - "];
    [self showCurrentValue:(sender)];

}

- (IBAction)add: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@" + "];
    [self showCurrentValue:(sender)];
}

- (IBAction)div: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@" / "];
    [self showCurrentValue:(sender)];
}

- (IBAction)back: (id) sender
{
    int lastValIndex = [_valuesEntered length];
    
    int startIndex;
    int length;
    
    if (lastValIndex != 0) {
        if ([[_valuesEntered substringFromIndex:lastValIndex - 1] isEqualToString:@" "]) {
            startIndex = lastValIndex - 3;
            length = 3;
        } else {
            startIndex = lastValIndex - 1;
            length = 1;
        }
        NSRange lastValue = {startIndex, length};
        
        _valuesEntered = [_valuesEntered stringByReplacingCharactersInRange:lastValue withString: @""];

    }
    [self showCurrentValue:(sender)];
}

- (IBAction)period: (id) sender
{
    _valuesEntered = [_valuesEntered stringByAppendingString:@"."];
    [self showCurrentValue:(sender)];
}

- (IBAction)showCurrentValue:(id)sender
{
    self.currentValue.text = _valuesEntered;
}

- (IBAction)showRunningTotal:(id)sender
{
    self.runningTotal.text = _valuesEntered;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
