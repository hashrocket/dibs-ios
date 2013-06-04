#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
