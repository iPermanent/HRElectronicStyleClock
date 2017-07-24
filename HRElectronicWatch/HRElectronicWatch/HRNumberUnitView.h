//
//  HRNumberUnitView.h
//  HRElectronicWatch
//
//  Created by ZhangHeng on 2017/7/24.
//  Copyright © 2017年 ZhangHeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRNumberUnitView : UIView

//0-9范围
@property(nonatomic,assign)int  number;
@property(nonatomic,strong)UIColor  *fillColor;
@property(nonatomic,strong)UIColor  *emptyColor;

@end
