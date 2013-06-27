#import "ItemsController.h"
#import "ItemCell.h"
#import "Item.h"

static CGFloat kPadding = 10;

@interface ItemsController ()

@end

@implementation ItemsController

-(void)setItemsAttributes:(NSArray *)itemsAttributes {
  [self setItems:[Item parse:itemsAttributes]];
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

@end
