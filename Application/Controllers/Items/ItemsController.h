@interface ItemsController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) NSArray *items;

-(void)setItemsAttributes:(NSArray*)itemsAttributes;

@end
