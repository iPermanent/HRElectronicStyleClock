//
//  HRTimeView.m
//  HRElectronicWatch
//
//  Created by ZhangHeng on 2017/7/24.
//  Copyright © 2017年 ZhangHeng. All rights reserved.
//

#import "HRTimeView.h"

#import "HRNumberUnitView.h"

//分割号的宽度
#define HRTimeSeparateWidth 30

@interface HRTimeView(){
    UIView  *hourMinuteSep;
    UIView  *minSecSep;
}
@end

@implementation HRTimeView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self configTimeView];
    }
    return self;
}

-(void)configTimeView{
    CGFloat unitViewWidth = (self.frame.size.width - HRTimeSeparateWidth*2)/6;
    for(int i = 0;i < 6;i++){
        HRNumberUnitView *unitView = [[HRNumberUnitView alloc] initWithFrame:CGRectMake(i*unitViewWidth, 0, unitViewWidth, self.frame.size.height)];
        unitView.fillColor = [UIColor redColor];
        unitView.emptyColor = [[UIColor redColor] colorWithAlphaComponent:0.02];
        unitView.tag = i+10;
        [self addSubview:unitView];
        
        if(i > 1){
            unitView.frame = CGRectOffset(unitView.frame, i/2 * HRTimeSeparateWidth, 0);
        }
    }
    
    hourMinuteSep = [[UIView alloc] initWithFrame:CGRectMake(unitViewWidth *2, 0, HRTimeSeparateWidth, self.frame.size.height)];
    minSecSep = [[UIView alloc] initWithFrame:CGRectMake(unitViewWidth * 4 + HRTimeSeparateWidth, 0, HRTimeSeparateWidth, self.frame.size.height)];
    
    for(int i = 0 ; i < 2; i++){
        UIView  *dotView = [[UIView alloc] initWithFrame:CGRectMake(HRTimeSeparateWidth/2 - 5, self.frame.size.height / 3 * (i + 1) - 5, 10, 10)];
        dotView.backgroundColor = [UIColor redColor];
        [hourMinuteSep addSubview:dotView];
        
        UIView  *dView = [[UIView alloc] initWithFrame:CGRectMake(HRTimeSeparateWidth/2 - 5, self.frame.size.height / 3 * (i + 1) - 5, 10, 10)];
        dView.backgroundColor = [UIColor redColor];
        [minSecSep addSubview:dView];
        
    }
    
    [self addSubview:hourMinuteSep];
    [self addSubview:minSecSep];
}

-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    _timeInterval = timeInterval;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *timeString = [[[df stringFromDate:date] componentsSeparatedByString:@" "] objectAtIndex:1];
    NSString *pureString = [timeString stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    for(int i = 0;i < 6;i++){
        HRNumberUnitView *unitV = [self viewWithTag:i+10];
        unitV.number = [[pureString substringWithRange:NSMakeRange(i, 1)] intValue];
    }
}


@end
