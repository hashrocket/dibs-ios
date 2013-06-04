#import "UIView+Constraints.h"

@implementation UIView (Constraints)
-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1.0 constant:0.0]];
}
@end