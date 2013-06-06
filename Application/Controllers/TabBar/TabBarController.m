#import "TabBarController.h"
#import "TabView.h"

@interface TabBarController () {
  TabView *_tabView;
}
-(TabView*)tabView;
@end

@implementation TabBarController

-(id)init {
  if (self = [super init]) {
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tabView];
    [self.tabView addButton:@"Buy"];
    [self.tabView addButton:@"Sell"];
    [self.tabView selectButtonAtIndex:0];
    [self.view setNeedsUpdateConstraints];
  }
  return self;
}

-(TabView*)tabView {
  if (!_tabView) {
    _tabView = [[TabView alloc] initWithDelegate:self];
  }
  return _tabView;
}

-(void)updateViewConstraints {
  [super updateViewConstraints];
  [self.view addEqualityConstraintOn:NSLayoutAttributeBottom forSubview:self.tabView];
  [self.view addEqualityConstraintOn:NSLayoutAttributeLeft forSubview:self.tabView];
  [self.view addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.tabView];
  [self.view addConstraintsWithVisualFormat:@"V:[tabview(height)]"
                                     forSubviews:@{@"tabview": self.tabView}
                                     withMetrics:@{@"height": @(40)}];
}

-(void)didTapButtonAtIndex:(NSInteger)index {
  log_float((CGFloat)index);
}

@end