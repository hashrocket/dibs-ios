@interface ItemsController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSArray *items;
@property(nonatomic) BOOL isLoading;

-(void)setItemsAttributes:(NSArray*)itemsAttributes;

-(UICollectionViewFlowLayout*)layout;
-(UICollectionView*)collectionView;

@end
