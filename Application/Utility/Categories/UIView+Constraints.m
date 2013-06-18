#import "UIView+Constraints.h"

@implementation UIView (Constraints)

-(void)addEqualityConstraintFor:(UIView*)firstView relatedBy:(NSLayoutAttribute)firstAttribute
                             on:(UIView*)secondView relatedBy:(NSLayoutAttribute)secondAttribute
                       constant:(CGFloat)constant {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:firstView attribute:firstAttribute
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:secondView attribute:secondAttribute
                                                  multiplier:1.0 constant:constant]];
}

-(void)addEqualityConstraintFor:(UIView*)firstView relatedBy:(NSLayoutAttribute)firstAttribute
                             on:(UIView*)secondView relatedBy:(NSLayoutAttribute)secondAttribute {
  [self addEqualityConstraintFor:firstView relatedBy:firstAttribute
                              on:secondView relatedBy:secondAttribute
                        constant:0.0];
}

-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview {
  [self addEqualityConstraintFor:self relatedBy:attribute on:subview relatedBy:attribute];
}

-(void)addConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views {
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views]];
}

-(void)addConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views withMetrics:(NSDictionary *)metrics {
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views]];
}

-(void)addUniformConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views {
  [@[@"H:",@"V:"] each:^(NSString *direction) {
    NSString *uniformat = [direction stringByAppendingString:format];
    [self addConstraintsWithVisualFormat:uniformat forSubviews:views];
  }];
}

@end