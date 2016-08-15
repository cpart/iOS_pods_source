//
//  CustomSwitch.m
//  CustomUISwitch
//
//  Created by Sukie Zhao on 13-6-8.
//
//

#import "AMSwitch.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_DURATION 0.5f

@interface AMSwitch()

@property (nonatomic) UIView *customSwitch;
@property (nonatomic) UIButton *onButton;
@property (nonatomic) UIButton *offButton;
@property (nonatomic) CGFloat minusTranslate;
@property (nonatomic) CGRect leftRect;
@property (nonatomic) CGRect middleRect;
@property (nonatomic) BOOL first;
@property (nonatomic) CGFloat currentTranslationX;

@end

@implementation AMSwitch

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

-(void)setStatus:(AMSwitchStatus)status
{
    [self updateStatus:status];
    
    if ([self.delegate respondsToSelector:@selector(switchControl:status:)]) {
        [self.delegate switchControl:self status:_status];
    }
    
}

- (void)updateStatus:(AMSwitchStatus)status {
    if (_arrange == AMSwitchArrangeOFFLeftONRight) {
        
        if (_status == AMSwitchStatusOn) {
            if (status == AMSwitchStatusOff) {
                [self moveButtonTranslation:self.minusTranslate];
            }
        } else {
            if (status == AMSwitchStatusOn) {
                
                [self moveButtonTranslation:0];
            }
        }
    } else {
        if (_status == AMSwitchStatusOn) {
            if (status == AMSwitchStatusOff) {
                [self moveButtonTranslation:0];
            }
        } else {
            if (status == AMSwitchStatusOn) {
                [self moveButtonTranslation:self.minusTranslate];
            }
        }
    }
    
    //[self.customSwitch exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    _status = status;
    
    if (_status == AMSwitchStatusOff) {
        [self.customSwitch bringSubviewToFront:self.offButton];
    } else {
        [self.customSwitch bringSubviewToFront:self.onButton];
    }
}

-(void)moveButtonTranslation:(CGFloat)translation
{
    [UIView animateWithDuration:DEFAULT_DURATION animations:^{
        
        self.onButton.transform = CGAffineTransformMakeTranslation(translation, 0);
        self.offButton.transform = CGAffineTransformMakeTranslation(translation, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(id)initWithOnImage:(UIImage*)onImage offImage:(UIImage*)offImage status:(AMSwitchStatus)status arrange:(AMSwitchArrange)arrange {
    self = [super init];
    
    self.status = status;
    
    self.onImage = onImage;
    self.offImage = offImage;
    
    self.customSwitch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.onImage.size.width, self.onImage.size.height)];
    self.customSwitch.backgroundColor = [UIColor redColor];
    
    self.onButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.onButton setImage:onImage forState:UIControlStateNormal];
    
    self.offButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.offButton setImage:offImage forState:UIControlStateNormal];
    self.currentTranslationX = 0;
    
    
    if (self.arrange == AMSwitchArrangeONLeftOFFRight) {
        
        self.onButton.frame = CGRectMake(0, 0, self.onImage.size.width, self.onImage.size.height);
        self.offButton.frame = CGRectMake(self.onImage.size.width - self.onImage.size.height, 0, self.offImage.size.width, self.offImage.size.height);
    }else{
        
        self.offButton.frame = CGRectMake(0, 0, self.offImage.size.width, self.offImage.size.height);
        self.onButton.frame = CGRectMake(self.onImage.size.width - self.onImage.size.width, 0, self.onImage.size.width, self.onImage.size.height);
    }
    
    [self.onButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.offButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.status == AMSwitchStatusOn) {
        [self addSubview:self.offButton];
        [self addSubview:self.onButton];
    } else {
        [self addSubview:self.onButton];
        [self addSubview:self.offButton];
    }
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(switchBtnDragged:)];
    [self.onButton addGestureRecognizer:panGesture];
    [self.offButton addGestureRecognizer:panGesture];
    
    [self addSubview:self.customSwitch];
    
    return self;
}


-(void)awakeFromNib
{
    self.status = AMSwitchStatusOff;
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"AMSwitch" owner:self options:nil];
    for (UIView *view in nibs)
        if ([view isKindOfClass:[UIView class]]) {
            self.customSwitch = (UIView*)view;
            break;
        }
    NSArray *subviews = [self.customSwitch subviews];
    for (UIView *view in subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton*)view;
            if (btn.tag == 1)
                self.onButton = btn;
            else if (btn.tag == 2)
                self.offButton = btn;
        }
    }
    
    if (self.status == AMSwitchStatusOff) {
        [self.customSwitch bringSubviewToFront:self.offButton];
    } else {
        [self.customSwitch bringSubviewToFront:self.onButton];
    }
}

- (void)addShadow {
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.layer.shadowRadius = 0.5;
    self.layer.shadowOpacity = 0.3;
    self.layer.masksToBounds = NO;
}

-(void)switchBtnClicked
{
    if (self.status == AMSwitchStatusOn) {
        [self setStatus:AMSwitchStatusOff];
        [self moveButtonTranslation:self.minusTranslate];
        
    }else{
        [self setStatus:AMSwitchStatusOn];
        [self moveButtonTranslation:0];
        
    }
}


-(void)switchBtnDragged:(UIPanGestureRecognizer*)panGuester
{
    CGFloat translation = [panGuester translationInView:panGuester.view].x;
    CGFloat moveTranslation = 0.0;
    moveTranslation = translation + self.currentTranslationX;
    
    if (panGuester.state == UIGestureRecognizerStateChanged) {
        
        if (translation < 0) {
            
            BOOL move = NO;
            if (self.arrange == AMSwitchArrangeOFFLeftONRight) {
                if (self.status == AMSwitchStatusOff) {
                    move = YES;
                }
            }else{
                if (self.status == AMSwitchStatusOn) {
                    move = YES;
                }
            }
            if (move) {
                
                if (fabs(moveTranslation) >= 0) {
                    [self moveButtonTranslation:0];
                }else
                {
                    [self moveButtonTranslation:moveTranslation];
                }
                
            }
        }
        else if (translation > 0) {
            
            BOOL move = NO;
            if (self.arrange == AMSwitchArrangeOFFLeftONRight) {
                if (self.status == AMSwitchStatusOn) {
                    move = YES;
                }
            }else{
                if (self.status == AMSwitchStatusOff) {
                    move = YES;
                }
            }
            if (move) {
                
                if (fabs(moveTranslation) > self.minusTranslate) {
                    [self moveButtonTranslation:self.minusTranslate];
                }else{
                    [self moveButtonTranslation:moveTranslation];
                }
                
            }
        }
    }
    else if (panGuester.state == UIGestureRecognizerStateEnded)
    {
        self.currentTranslationX = panGuester.view.transform.tx;
        
        if (translation < 0) {
            
            if (fabs(moveTranslation) >= self.minusTranslate/3) {
                
                if (self.arrange == AMSwitchArrangeOFFLeftONRight) {
                    if (self.status == AMSwitchStatusOff) {
                        [self moveButtonTranslation:0];
                        [self setStatus:AMSwitchStatusOn];
                    }
                }else{
                    if (self.status == AMSwitchStatusOn) {
                        [self moveButtonTranslation:0];
                        [self setStatus:AMSwitchStatusOff];
                    }
                }
            }
            else{
                if (self.arrange == AMSwitchArrangeOFFLeftONRight) {
                    if (self.status == AMSwitchStatusOff) {
                        [self moveButtonTranslation:self.minusTranslate];
                    }
                }else{
                    if (self.status == AMSwitchStatusOn) {
                        [self moveButtonTranslation:self.minusTranslate];
                    }
                }
                
            }
        }
        else if (translation > 0) {
            
            if (fabs(moveTranslation) >= self.minusTranslate/2) {
                
                
                
                if (self.arrange == AMSwitchArrangeOFFLeftONRight) {
                    if (self.status == AMSwitchStatusOn) {
                        [self moveButtonTranslation:self.minusTranslate];
                        [self setStatus:AMSwitchStatusOff];
                    }
                }else{
                    if (self.status == AMSwitchStatusOff) {
                        [self moveButtonTranslation:self.minusTranslate];
                        [self setStatus:AMSwitchStatusOn];
                    }
                }
            }
            else{
                if (self.arrange == AMSwitchArrangeOFFLeftONRight) {
                    if (self.status == AMSwitchStatusOn) {
                        [self moveButtonTranslation:0];
                    }
                }else{
                    if (self.status == AMSwitchStatusOff) {
                        [self moveButtonTranslation:0];
                    }
                }
                
            }
            
        }
    }
}


- (void)drawRect:(CGRect)rect
{
    if (!self.first) {
        self.customSwitch.backgroundColor = [UIColor clearColor];
        [self.customSwitch setFrame:CGRectMake(0, 0, self.onImage.size.width, self.onImage.size.height)];
        [self.onButton setImage:self.onImage forState:UIControlStateNormal];
        [self.offButton setImage:self.offImage forState:UIControlStateNormal];
        [self.onButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.offButton addTarget:self action:@selector(switchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.leftRect = CGRectMake(-(self.onImage.size.width - self.onImage.size.height), 0, self.onImage.size.width, self.onImage.size.height);
        self.middleRect = CGRectMake(0, 0, self.onImage.size.width, self.onImage.size.height);
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.customSwitch.bounds
                                                            cornerRadius:self.customSwitch.bounds.size.height / 2.0];
        maskLayer.path = maskPath.CGPath;
        self.customSwitch.layer.mask = maskLayer;
        
        
        self.minusTranslate = self.onImage.size.width - self.onImage.size.height;
        self.currentTranslationX = 0;
        if (self.arrange == AMSwitchArrangeONLeftOFFRight) {
            
            self.onButton.frame = self.leftRect;
            self.offButton.frame =  self.middleRect;
            if (self.status == AMSwitchStatusOn) {
                
                [self moveButtonTranslation:self.minusTranslate];
                
                
            }else{
                [self moveButtonTranslation:0];
                //[self.customSwitch exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            }
            
        }else{
            
            self.offButton.frame = self.leftRect;
            self.onButton.frame =  self.middleRect;
            if (self.status == AMSwitchStatusOn) {
                
                [self moveButtonTranslation:0];
                
                
            }else{
                
                [self moveButtonTranslation:self.minusTranslate];
                //[self.customSwitch exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
            }
            
        }
        UIPanGestureRecognizer *offPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(switchBtnDragged:)];
        UIPanGestureRecognizer *onPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(switchBtnDragged:)];
        [self.onButton addGestureRecognizer:onPanGesture];
        [self.offButton addGestureRecognizer:offPanGesture];
        
        [self addSubview:self.customSwitch];
    }
    
    self.first = YES;
    
    if (self.shadow) {
        [self addShadow];
    }
}
@end


