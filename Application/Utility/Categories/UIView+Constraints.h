#import <UIKit/UIKit.h>

@interface UIView (Constraints)
-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview;
-(void)addEqualityConstraintFor:(UIView*)firstView relatedBy:(NSLayoutAttribute)firstAttribute on:(UIView*)secondView relatedBy:(NSLayoutAttribute)secondAttribute;
-(void)addEqualityConstraintFor:(UIView*)firstView relatedBy:(NSLayoutAttribute)firstAttribute on:(UIView*)secondView relatedBy:(NSLayoutAttribute)secondAttribute constant:(CGFloat)constant;
-(void)addConstraintsWithVisualFormat:(NSString*)format forSubviews:(NSDictionary*)views;
-(void)addConstraintsWithVisualFormat:(NSString*)format forSubviews:(NSDictionary*)views withMetrics:(NSDictionary*)metrics;
-(void)addUniformConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views;
-(void)addUniformConstraintsWithVisualFormat:(NSString *)format forSubviews:(NSDictionary *)views withMetrics:(NSDictionary*)metrics;
@end
