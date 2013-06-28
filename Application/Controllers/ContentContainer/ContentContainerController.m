#import "ContentContainerController.h"

@implementation ContentContainerController

-(id)init {
  if (self = [super init]) {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return self;
}

-(UIViewController*)currentViewController {
  return [self.childViewControllers lastObject];
}


-(void)setContentViewController:(UIViewController *)controller {
  // remove previous view controller
  [self.currentViewController.view removeFromSuperview];
  [self.currentViewController removeFromParentViewController];
  // add new view controller
  [controller willMoveToParentViewController:self];
  [self addChildViewController:controller];
  [self.view addSubview:controller.view];
  [controller didMoveToParentViewController:self];
}

@end
