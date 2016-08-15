//
//  AnimatedTableCell.m
//      Animated Table
//
//  Created by Philip Yu on 4/18/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "AMAnimatedTableViewCell.h"
#import "UIView+AMAdditions.h"

#define kDefaultAnimationDelay 0.0
#define kDefaultAnimationDuration 0.5

@implementation AMAnimatedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        return self;
    }
    
    return nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.animatedContentView = self.contentView;
    [self.animatedContentView resetOriginToTopLeft];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)resetPosition {
    [self.animatedContentView setCenter:CGPointMake(0.0f, 0.0f)];
}

- (void)configureCellContentSizeWidth:(CGFloat)width height:(CGFloat)height {
    [self.animatedContentView setFrame:CGRectMake(0.0f, 0.0f, width, height)];
}

- (void)pushCellWithAnimation:(BOOL)animated {
    [self pushCellWithAnimation:animated duration:kDefaultAnimationDuration delay:kDefaultAnimationDelay ];
}

- (void)pushCellWithAnimation:(BOOL)animated direction:(AMAnimatedTableCellDirections)direction {
    [self pushCellWithAnimation:animated duration:kDefaultAnimationDuration delay:kDefaultAnimationDelay direction:direction];
}

- (void)pushCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay {
    if (!animated) {
        duration = 0.0f;
    }
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.animatedContentView.center = CGPointMake(0.0f, 0.0f);
                     }
                     completion:nil];
}

- (void)pushCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay direction:(AMAnimatedTableCellDirections)direction {
    [self pushCellWithAnimation:animated duration:duration delay:delay offset:0.0f direction:direction];
}

- (void)pushCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay offset:(CGFloat)offset direction:(AMAnimatedTableCellDirections)direction {
    switch (direction) {
        case AMAnimatedTableCellDirectionUp: {
            [self.animatedContentView setCenter:CGPointMake(0.0f, -(self.animatedContentView.frame.size.height + offset))];
            break;
        }
        case AMAnimatedTableCellDirectionDown: {
            [self.animatedContentView setCenter:CGPointMake(0.0f, self.animatedContentView.frame.size.height + offset)];
            break;
        }
        case AMAnimatedTableCellDirectionLeft: {
            [self.animatedContentView setCenter:CGPointMake(-(self.animatedContentView.frame.size.width + offset), 0.0f)];
            break;
        }
        case AMAnimatedTableCellDirectionRight: {
            [self.animatedContentView setCenter:CGPointMake(self.animatedContentView.frame.size.width + offset, 0.0f)];
            break;
        }
        default: {
            [self.animatedContentView setCenter:CGPointMake(0.0f, -(self.animatedContentView.frame.size.height + offset))];
            break;
        }
    }
    
    [self pushCellWithAnimation:animated duration:duration delay:delay];
}


- (void)popCellWithAnimation:(BOOL)animated {
    [self popCellWithAnimation:animated duration:kDefaultAnimationDuration delay:kDefaultAnimationDelay direction:AMAnimatedTableCellDirectionNone];
}

- (void)popCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay {
    [self popCellWithAnimation:animated duration:duration delay:delay direction:AMAnimatedTableCellDirectionNone];
}

- (void)popCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay direction:(AMAnimatedTableCellDirections)direction {
}

- (void)popCellWithAnimation:(BOOL)animated duration:(CGFloat)duration delay:(CGFloat)delay offset:(CGFloat)offset direction:(AMAnimatedTableCellDirections)direction {
    self.popped = YES;
    
    if (!animated) {
        duration = 0.0f;
    }
    
    [UIView animateWithDuration:duration
                          delay:delay
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         switch (direction) {
                             case AMAnimatedTableCellDirectionNone: {
                                 [self.animatedContentView setCenter:CGPointMake(0.0f, 0.0f)];
                                 break;
                             }
                             case AMAnimatedTableCellDirectionUp: {
                                 [self.animatedContentView setCenter:CGPointMake(0.0f, self.animatedContentView.frame.size.height + offset)];
                                 break;
                             }
                             case AMAnimatedTableCellDirectionDown: {
                                 [self.animatedContentView setCenter:CGPointMake(0.0f, -(self.animatedContentView.frame.size.height + offset) )];
                                 break;
                             }
                             case AMAnimatedTableCellDirectionLeft: {
                                 [self.animatedContentView setCenter:CGPointMake(self.animatedContentView.frame.size.width, 0.0f)];
                                 break;
                             }
                             case AMAnimatedTableCellDirectionRight: {
                                 [self.animatedContentView setCenter:CGPointMake(-(self.animatedContentView.frame.size.width + offset), 0.0f)];
                                 break;
                             }
                             default: {
                                 [self.animatedContentView setCenter:CGPointMake(0.0f, self.animatedContentView.frame.size.height + offset)];
                                 break;
                             }
                         }
                     }
                     completion:nil];
}

@end
