#import "TabBarController.h"
#import "TabView.h"
#import "TitleBarView.h"
#import "ContainerController.h"
#import "FriendsItemsController.h"
#import "MyItemsController.h"
#import "ItemCell.h"

@interface TabBarController () {
  TabView *_tabView;
  TitleBarView *_titleBarView;
  ContainerController *_containerController;
  FriendsItemsController *_friendsItemsController;
  MyItemsController *_myItemsController;
}

-(TabView*)tabView;
-(TitleBarView*)titleBarView;
-(UIView*)contentView;
-(ContainerController*)containerController;
-(FriendsItemsController*)friendsItemsController;
-(MyItemsController*)myItemsController;
-(UIViewController*)controllerForIndex:(NSInteger)index;

@end

@implementation TabBarController

-(id)init {
  if (self = [super init]) {
    [self.view setStyleId:@"tab_container"];
    [self.view addSubview:self.titleBarView];
    [self.view addSubview:self.tabView];
    [self.tabView addButton:@"Buy" withIconNamed:@"icon_buy"];
    [self.tabView addButton:@"Sell" withIconNamed:@"icon_sell"];
    [self.view addSubview:self.contentView];
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

-(TitleBarView*)titleBarView {
  if (!_titleBarView) {
    _titleBarView = [[TitleBarView alloc] init];
  }
  return _titleBarView;
}

-(UIView*)contentView {
  return self.containerController.view;
}

-(ContainerController*)containerController {
  if (!_containerController) {
    _containerController = [[ContainerController alloc] init];
  }
  return _containerController;
}

-(FriendsItemsController*)friendsItemsController {
  if (!_friendsItemsController) {
    _friendsItemsController = [[FriendsItemsController alloc] init];
  }
  return _friendsItemsController;
}

-(MyItemsController*)myItemsController {
  if (!_myItemsController) {
    _myItemsController = [[MyItemsController alloc] init];
  }
  return _myItemsController;
}

-(UIViewController*)controllerForIndex:(NSInteger)index {
  return @[self.friendsItemsController,self.myItemsController][index];
}

-(void)updateViewConstraints {
  [super updateViewConstraints];

  [self.view addEqualityConstraintOn:NSLayoutAttributeTop forSubview:self.titleBarView];
  [self.view addEqualityConstraintOn:NSLayoutAttributeLeft forSubview:self.titleBarView];
  [self.view addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.titleBarView];
  [self.view addConstraintsWithVisualFormat:@"V:[titleview(height)]"
                                     forSubviews:@{@"titleview": self.titleBarView}
                                     withMetrics:@{@"height": @(44)}];
  [self.view addEqualityConstraintOn:NSLayoutAttributeBottom forSubview:self.tabView];
  [self.view addEqualityConstraintOn:NSLayoutAttributeLeft forSubview:self.tabView];
  [self.view addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.tabView];
  [self.view addConstraintsWithVisualFormat:@"V:[tabview(height)]"
                                     forSubviews:@{@"tabview": self.tabView}
                                     withMetrics:@{@"height": @(64)}];
  [self.view addEqualityConstraintFor:self.contentView relatedBy:NSLayoutAttributeTop
                                   on:self.titleBarView relatedBy:NSLayoutAttributeBottom];
  [self.view addEqualityConstraintOn:NSLayoutAttributeLeft forSubview:self.contentView];
  [self.view addEqualityConstraintOn:NSLayoutAttributeRight forSubview:self.contentView];
  [self.view addEqualityConstraintFor:self.tabView relatedBy:NSLayoutAttributeTop
                                   on:self.contentView relatedBy:NSLayoutAttributeBottom];
}

-(void)didTapButtonAtIndex:(NSInteger)index {
  [self.containerController setContentViewController:[self controllerForIndex:index]];
}

-(void)viewDidAppear:(BOOL)animated {
  if ([[UserDataStore sharedInstance] isAuthenticated]) {
    postNotification(SlideMenuShouldEnableSwipe);
    [self.tabView selectButtonAtIndex:0];
  }
}

@end