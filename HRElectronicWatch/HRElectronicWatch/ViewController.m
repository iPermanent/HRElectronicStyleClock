//
//  ViewController.m
//  HRElectronicWatch
//
//  Created by ZhangHeng on 2017/7/24.
//  Copyright © 2017年 ZhangHeng. All rights reserved.
//

#import "ViewController.h"
#import "HRNumberUnitView.h"
#import "HRTimeView.h"

@interface ViewController ()
{
    HRNumberUnitView *numView;
    int number;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    numView = [[HRNumberUnitView alloc] initWithFrame:CGRectMake(50, 50, 50, 60)];
    numView.backgroundColor = [UIColor whiteColor];
    numView.fillColor = [UIColor redColor];
    numView.emptyColor = [[UIColor redColor] colorWithAlphaComponent:0.02];
    [self.view addSubview:numView];
    
    numView.number = 0;
    
    [self performSelector:@selector(countNumber) withObject:nil afterDelay:0.5];
    
    HRTimeView *timeView = [[HRTimeView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 80)];
    [self.view addSubview:timeView];
    
    [timeView setTimeInterval:[[NSDate date] timeIntervalSince1970]];
}

-(void)countNumber{
    number ++;
    numView.number = number%10;
    
    [self performSelector:@selector(countNumber) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
