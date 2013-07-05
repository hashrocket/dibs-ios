#import "ItemsController.h"
#import "ItemCell.h"
#import "Item.h"

static CGFloat kPadding = 10;

@interface ItemsController () {
  UICollectionViewFlowLayout *_layout;
  UICollectionView *_collectionView;
  UIRefreshControl *_refreshControl;
}
-(void)invalidateData;
-(void)disableCollectionViewInteraction;
-(void)enableCollectionViewInteraction;
@end

@implementation ItemsController

-(id)init {
  if (self = [super init]) {
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.refreshControl];
    [self.view setNeedsUpdateConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(invalidateData)
                                                 name:UserSessionShouldBeInvalidated
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableCollectionViewInteraction)
                                                 name:SlideMenuWillSlideIn
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disableCollectionViewInteraction)
                                                 name:SlideMenuWillSlideOut
                                               object:nil];
  }
  return self;
}

-(void)setItemsAttributes:(NSArray *)itemsAttributes {
  [self setItems:[Item parse:itemsAttributes]];
  [self.collectionView reloadData];
}

-(void)invalidateData {
  [self setItemsAttributes:[NSArray array]];
}

-(void)disableCollectionViewInteraction {
  [self.collectionView setScrollEnabled:NO];
}

-(void)enableCollectionViewInteraction {
  [self.collectionView setScrollEnabled:YES];
}

-(UIRefreshControl*)refreshControl {
  if (!_refreshControl) {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl setTintColor:[UIColor colorWithHexString:@"353535"]];
    [_refreshControl addTarget:self action:@selector(loadItems)
              forControlEvents:UIControlEventValueChanged];
    [_refreshControl.layer setOpacity:0.75];
  }
  return _refreshControl;
}

-(UICollectionViewFlowLayout*)layout {
  if (!_layout) {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    [_layout setSectionInset:UIEdgeInsetsMake(kPadding, 0, kPadding, 0)];
  }
  return _layout;
}

-(UICollectionView*)collectionView {
  if (!_collectionView) {
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setAlwaysBounceVertical:YES];
  }
  return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
  [cell setItem:self.items[indexPath.row]];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(self.view.bounds.size.width - kPadding * 2, 320);
}

-(void)updateViewConstraints {
  [super updateViewConstraints];
  id views = @{@"coll": self.collectionView};
  [self.view addUniformConstraintsWithVisualFormat:@"|[coll]|" forSubviews:views];
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
