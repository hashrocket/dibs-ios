#import "FriendsItemsController.h"
#import "ItemCell.h"
#import "Item.h"

static CGFloat kPadding = 10;

@interface FriendsItemsController ()

@end

@implementation FriendsItemsController

- (id)init {
  if (self = [super init]) {
  }
  return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
  // obtain and set item on cell
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(self.view.bounds.size.width - kPadding * 2, 320);
}

@end
