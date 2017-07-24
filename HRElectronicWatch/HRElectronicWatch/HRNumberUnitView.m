//
//  HRNumberUnitView.m
//  HRElectronicWatch
//
//  Created by ZhangHeng on 2017/7/24.
//  Copyright © 2017年 ZhangHeng. All rights reserved.
//

#import "HRNumberUnitView.h"

typedef NS_ENUM(NSUInteger,HRNumberLocation){
    HRNumberLocationTop = 1,
    HRNumberLocationTopLeft,
    HRNumberLocationTopRight,
    HRNumberLocationCenter,
    HRNumberLocationBottomLeft,
    HRNumberLocationBottomRight,
    HRNumberLocationBottom
};

@interface HRNumberUnitView()
//字的宽度
@property(nonatomic,assign)CGFloat  numberWidth;
//字体和view的边距
@property(nonatomic,assign)CGFloat  margin;
@end

@implementation HRNumberUnitView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.numberWidth = 5;
        self.margin = 5;
        [self configLineViews];
    }
    
    return self;
}

-(void)configLineViews{
    for(int i = 1 ; i < 8 ;i++){
        UIView  *lineView = [[UIView alloc] init];
        lineView.tag = i;
        lineView.layer.masksToBounds = YES;
        
        CAShapeLayer    *maskLayer = [CAShapeLayer layer];
        UIBezierPath    *path = [UIBezierPath bezierPath];
        
        switch (i) {
            case HRNumberLocationTop:{
                [lineView setFrame:CGRectMake(_margin, _margin, self.frame.size.width - _margin * 2, _numberWidth)];
                
                [path moveToPoint:CGPointMake(_numberWidth/3, 0)];
                [path addLineToPoint:CGPointMake(lineView.frame.size.width - _numberWidth/3, 0)];
                [path addLineToPoint:CGPointMake(lineView.frame.size.width - _numberWidth*4/3, _numberWidth)];
                [path addLineToPoint:CGPointMake(_numberWidth*4/3, _numberWidth)];
            }
                break;
            case HRNumberLocationTopLeft:{
                [lineView setFrame:CGRectMake(_margin, _margin, _numberWidth, self.frame.size.height/2 - _margin)];
                
                [path moveToPoint:CGPointMake(0,_numberWidth/3)];
                [path addLineToPoint:CGPointMake(_numberWidth, _numberWidth)];
                [path addLineToPoint:CGPointMake(_numberWidth, lineView.frame.size.height - _numberWidth)];
                [path addLineToPoint:CGPointMake(0, lineView.frame.size.height - _numberWidth/3)];
            }
                break;
            case HRNumberLocationTopRight:{
                [lineView setFrame:CGRectMake(self.frame.size.width - _margin - _numberWidth, _margin, _numberWidth, self.frame.size.height/2 - _margin)];
                
                [path moveToPoint:CGPointMake(_numberWidth,_numberWidth/3)];
                [path addLineToPoint:CGPointMake(_numberWidth, lineView.frame.size.height - _numberWidth/3)];
                [path addLineToPoint:CGPointMake(0, lineView.frame.size.height - _numberWidth)];
                [path addLineToPoint:CGPointMake(0, _numberWidth)];
            }
                break;
            case HRNumberLocationCenter:{
                [lineView setFrame:CGRectMake(_margin, self.frame.size.height/2 - _numberWidth/2, self.frame.size.width - _margin * 2, _numberWidth)];
                
                [path moveToPoint:CGPointMake(0,_numberWidth/2)];
                [path addLineToPoint:CGPointMake(_numberWidth, 0)];
                [path addLineToPoint:CGPointMake(lineView.frame.size.width - _numberWidth, 0)];
                [path addLineToPoint:CGPointMake(lineView.frame.size.width - _numberWidth/3, _numberWidth/2)];
                [path addLineToPoint:CGPointMake(lineView.frame.size.width - _numberWidth, _numberWidth)];
                [path addLineToPoint:CGPointMake(_numberWidth, _numberWidth)];
            }
                break;
            case HRNumberLocationBottomLeft:{
                [lineView setFrame:CGRectOffset([self viewWithTag:HRNumberLocationTopLeft].frame, 0, [self viewWithTag:HRNumberLocationTopLeft].frame.size.height)];
                
                [path moveToPoint:CGPointMake(0,_numberWidth/3)];
                [path addLineToPoint:CGPointMake(_numberWidth, _numberWidth)];
                [path addLineToPoint:CGPointMake(_numberWidth, lineView.frame.size.height - _numberWidth*4/3)];
                [path addLineToPoint:CGPointMake(0, lineView.frame.size.height - _numberWidth/3)];
            }
                break;
            case HRNumberLocationBottomRight:{
                [lineView setFrame:CGRectOffset([self viewWithTag:HRNumberLocationTopRight].frame, 0, [self viewWithTag:HRNumberLocationTopRight].frame.size.height)];
                
                [path moveToPoint:CGPointMake(_numberWidth,_numberWidth/3)];
                [path addLineToPoint:CGPointMake(_numberWidth, lineView.frame.size.height - _numberWidth/3)];
                [path addLineToPoint:CGPointMake(0, lineView.frame.size.height - _numberWidth*4/3)];
                [path addLineToPoint:CGPointMake(0, _numberWidth)];
            }
                break;
            case HRNumberLocationBottom:{
                [lineView setFrame:CGRectMake(_margin, self.frame.size.height - _margin - _numberWidth, self.frame.size.width - 2 * _margin, _numberWidth)];
                
                [path moveToPoint:CGPointMake(_numberWidth*4/3,0)];
                [path addLineToPoint:CGPointMake(lineView.frame.size.width - _numberWidth*4/3, 0)];
                [path addLineToPoint:CGPointMake(lineView.frame.size.width - _numberWidth/3,_numberWidth)];
                [path addLineToPoint:CGPointMake(_numberWidth/3, _numberWidth)];
            }break;
            default:
                break;
        }
        maskLayer.path = path.CGPath;
        maskLayer.frame = lineView.bounds;
        lineView.layer.mask = maskLayer;
        [self addSubview:lineView];
    }
}

-(void)setViewLayer:(UIView *)view selected:(BOOL)select{
    CAShapeLayer *maskLayer = (CAShapeLayer *)[view layer].mask;
    maskLayer.strokeColor = select ? _fillColor.CGColor : _emptyColor.CGColor;
    view.backgroundColor = select ? _fillColor : _emptyColor;
    [view setNeedsDisplay];
}

-(void)setNumber:(int)number{
    _number = number;
    
    for(int i = 1; i < 8 ; i ++){
        [self setViewLayer:[self viewWithTag:i] selected:YES];
    }
    
    switch (number) {
        case 0:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationCenter]  selected:NO];
        }
            break;
        case 1:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationTop] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationCenter] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottom] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationTopLeft] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottomLeft] selected:NO];
        }
            break;
        case 2:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationTopLeft] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottomRight] selected:NO];
        }
            break;
        case 3:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationTopLeft] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottomLeft] selected:NO];
        }
            break;
        case 4:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationTop] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottom] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottomLeft] selected:NO];
        }
            break;
        case 5:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationTopRight] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottomLeft] selected:NO];
        }
            break;
        case 6:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationTopRight] selected:NO];
        }
            break;
        case 7:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationTopLeft] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottomLeft] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationCenter] selected:NO];
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottom] selected:NO];
        }
            break;
        case 8:{
        
        }break;
        case 9:{
            [self setViewLayer:[self viewWithTag:HRNumberLocationBottomLeft] selected:NO];
        }
            break;
        default:
            break;
    }
}

@end
