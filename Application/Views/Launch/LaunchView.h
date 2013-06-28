#import <UIKit/UIKit.h>

@protocol LaunchViewDelegate <NSObject>

-(void)didTapConnect:(id)sender;

@end

@interface LaunchView : UIView

@property(nonatomic,weak) UIViewController *delegate;

-(id)initWithDelegate:(UIViewController*)delegate;
-(void)setEnabled:(BOOL)enabled;

@end
