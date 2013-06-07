#import "UIView+Constraints.h"

@implementation UIView (Constraints)

-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1.0 constant:0.0]];
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