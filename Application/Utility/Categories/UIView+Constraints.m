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

-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview constant:(CGFloat)constant {
  [self addEqualityConstraintFor:self relatedBy:attribute on:subview relatedBy:attribute constant:constant];
}

-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview {
  [self addEqualityConstraintOn:attribute forSubview:subview constant:0];
}

-(void)addConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views {
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views]];
}

-(void)addConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views withMetrics:(NSDictionary *)metrics {
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views]];
}

-(void)addUniformConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views {
  [self addUniformConstraintsWithVisualFormat:format forSubviews:views withMetrics:nil];
}

-(void)addUniformConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views withMetrics:(NSDictionary *)metrics {
  [@[@"H:",@"V:"] each:^(NSString *direction) {
    NSString *uniformat = [direction stringByAppendingString:format];
    [self addConstraintsWithVisualFormat:uniformat forSubviews:views withMetrics:metrics];
  }];
}

@end