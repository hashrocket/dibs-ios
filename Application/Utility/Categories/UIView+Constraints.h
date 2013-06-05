#import <UIKit/UIKit.h>

@interface UIView (Constraints)
-(id)initWithoutAutoresizing;
-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview;
-(void)addConstraintsWithVisualFormat:(NSString*)format forSubviews:(NSDictionary*)views;
-(void)addConstraintsWithVisualFormat:(NSString*)format forSubviews:(NSDictionary*)views withMetrics:(NSDictionary*)metrics;
-(void)addUniformConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views;
@end
