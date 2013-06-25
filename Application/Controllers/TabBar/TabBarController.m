#import "TabBarController.h"
#import "TabView.h"
#import "TitleBarView.h"
#import "FriendsItemsController.h"
#import "MyItemsController.h"
#import "ItemCell.h"

static CGFloat kPadding = 10;

@interface TabBarController () {
  TabView *_tabView;
  TitleBarView *_titleBarView;
  UICollectionViewFlowLayout *_layout;
  UICollectionView *_contentView;
  FriendsItemsController *_friendsItemsController;
  MyItemsController *_myItemsController;
}
-(TabView*)tabView;
-(TitleBarView*)titleBarView;
-(UICollectionViewFlowLayout*)layout;
-(UICollectionView*)contentView;
-(FriendsItemsController*)friendsItemsController;
-(MyItemsController*)myItemsController;
-(UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>*)controllerForIndex:(NSInteger)index;
-(void)didInvalidateContent:(NSNotification*)notification;
@end

@implementation TabBarController

-(id)init {
  if (self = [super init]) {
    [self.view setStyleId:@"tab_container"];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.titleBarView];
    [self.view addSubview:self.tabView];
    [self.tabView addButton:@"Buy" withIconNamed:@"icon_buy"];
    [self.tabView addButton:@"Sell" withIconNamed:@"icon_sell"];
    [self.tabView selectButtonAtIndex:0];
    [self.view addSubview:self.contentView];
    [self.view setNeedsUpdateConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didInvalidateContent:)
                                                 name:TabBarContentControllerWasInvalidated
                                               object:nil];
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

-(UICollectionViewFlowLayout*)layout {
  if (!_layout) {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setSectionInset:UIEdgeInsetsMake(kPadding, 0, kPadding, 0)];
  }
  return _layout;
}

-(UICollectionView*)contentView {
  if (!_contentView) {
    _contentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [_contentView registerClass:[ItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return _contentView;
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

-(UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>*)controllerForIndex:(NSInteger)index {
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
  [self.contentView setDataSource:[self controllerForIndex:index]];
  [self.contentView setDelegate:[self controllerForIndex:index]];
  [self.contentView reloadData];
}

-(void)didInvalidateContent:(NSNotification *)notification {
  [self.contentView reloadData];
}

@end