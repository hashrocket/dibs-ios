#import <UIKit/UIKit.h>
#import "TabButton.h"

@protocol TabViewDelegate;

@interface TabView : UIView

-(id)initWithDelegate:(id<TabViewDelegate>)delegate;
-(void)addButton:(NSString*)title;
-(void)addButton:(NSString*)title withIconNamed:(NSString*)iconName;
-(void)selectButtonAtIndex:(NSInteger)index;
-(TabButton*)selectedButton;

@end
