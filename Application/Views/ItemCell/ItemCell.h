#import <UIKit/UIKit.h>
#import "Item.h"

#define kItemCellPadding 10.f

@interface ItemCell : UICollectionViewCell

-(void)setItem:(Item*)item;

-(UIImageView*)itemImage;
-(UILabel*)title;
-(UILabel*)price;
-(UIView*)container;

@end
