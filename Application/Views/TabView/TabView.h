#import <UIKit/UIKit.h>

@protocol TabViewDelegate;

@interface TabView : UIView

-(id)initWithDelegate:(id<TabViewDelegate>)delegate;
-(void)addButton:(NSString*)title;
-(void)selectButtonAtIndex:(NSInteger)index;

@end
