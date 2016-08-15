//
//  CustomSwitch.h
//  CustomUISwitch
//
//  Created by Sukie Zhao on 13-6-8.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AMSwitchStatus) {
    AMSwitchStatusOn = 0,
    AMSwitchStatusOff = 1
};

typedef NS_ENUM(NSUInteger, AMSwitchArrange) {
    AMSwitchArrangeONLeftOFFRight = 0,
    AMSwitchArrangeOFFLeftONRight = 1
};

@class AMSwitch;

@protocol AMSwitchDelegate <NSObject>

- (void)switchControl:(AMSwitch*)switchControl status:(AMSwitchStatus)status;

@end

@interface AMSwitch : UIControl

@property (nonatomic) UIImage *onImage;
@property (nonatomic) UIImage *offImage;
@property (nonatomic) IBOutlet id<AMSwitchDelegate> delegate;
@property (nonatomic) AMSwitchArrange arrange;
@property (nonatomic) AMSwitchStatus status;
@property (nonatomic) BOOL shadow;

- (void)updateStatus:(AMSwitchStatus)status;

@end